import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:smart_hotel/models/device.dart';
import 'dart:async';

class DeviceProvider with ChangeNotifier {
  List<Device> _devices = [];
  bool _isScanning = false;
  String? _error;
  Map<String, BluetoothDevice> _connectedDevices = {};
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  List<Device> get devices => _devices;
  bool get isScanning => _isScanning;
  String? get error => _error;

  DeviceProvider() {
    _initializeBluetooth();
  }

  Future<void> _initializeBluetooth() async {
    try {
      // Подписываемся на изменения состояния Bluetooth
      _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
        if (state == BluetoothAdapterState.off) {
          _error = 'Bluetooth выключен';
          notifyListeners();
        } else if (state == BluetoothAdapterState.on) {
          _error = null;
          notifyListeners();
        }
      });

      // Проверяем текущее состояние Bluetooth
      final state = await FlutterBluePlus.adapterState.first;
      if (state != BluetoothAdapterState.on) {
        _error = 'Bluetooth не включен';
        notifyListeners();
      }
    } catch (e) {
      _error = 'Ошибка инициализации Bluetooth: $e';
      notifyListeners();
    }
  }

  Future<void> startScan() async {
    try {
      if (_isScanning) return;

      _error = null;
      _isScanning = true;
      notifyListeners();

      // Проверяем, включен ли Bluetooth
      final state = await FlutterBluePlus.adapterState.first;
      if (state != BluetoothAdapterState.on) {
        _error = 'Bluetooth выключен';
        _isScanning = false;
        notifyListeners();
        return;
      }

      // Очищаем предыдущий список устройств
      _devices.clear();

      // Начинаем сканирование
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

      // Слушаем результаты сканирования
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (!_devices.any((device) => device.id == result.device.remoteId.toString())) {
            _devices.add(Device(
              id: result.device.remoteId.toString(),
              name: result.device.platformName.isNotEmpty 
                  ? result.device.platformName 
                  : 'Unknown Device',
              type: 'BLE Device',
              isConnected: false,
            ));
          }
        }
        notifyListeners();
      }, onError: (e) {
        _error = 'Ошибка при сканировании: $e';
        _isScanning = false;
        notifyListeners();
      });

      // Ждем завершения сканирования
      await Future.delayed(const Duration(seconds: 4));
      _isScanning = false;
      notifyListeners();
    } catch (e) {
      _error = 'Ошибка при сканировании: $e';
      _isScanning = false;
      notifyListeners();
    }
  }

  Future<void> connectToDevice(String deviceId) async {
    try {
      _error = null;
      final device = _devices.firstWhere((d) => d.id == deviceId);
      
      // Получаем устройство из результатов сканирования
      final scanResults = await FlutterBluePlus.scanResults.first;
      final scanResult = scanResults.firstWhere(
        (result) => result.device.remoteId.toString() == deviceId,
        orElse: () => throw Exception('Устройство не найдено'),
      );

      final bluetoothDevice = scanResult.device;
      await bluetoothDevice.connect(timeout: const Duration(seconds: 5));
      _connectedDevices[deviceId] = bluetoothDevice;
      
      final index = _devices.indexWhere((d) => d.id == deviceId);
      if (index != -1) {
        _devices[index] = device.copyWith(isConnected: true);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Ошибка при подключении: $e';
      notifyListeners();
    }
  }

  Future<void> disconnectFromDevice(String deviceId) async {
    try {
      _error = null;
      final device = _devices.firstWhere((d) => d.id == deviceId);
      final bluetoothDevice = _connectedDevices[deviceId];

      if (bluetoothDevice != null) {
        await bluetoothDevice.disconnect();
        _connectedDevices.remove(deviceId);
        
        final index = _devices.indexWhere((d) => d.id == deviceId);
        if (index != -1) {
          _devices[index] = device.copyWith(isConnected: false);
          notifyListeners();
        }
      }
    } catch (e) {
      _error = 'Ошибка при отключении: $e';
      notifyListeners();
    }
  }

  Future<void> toggleDevice(String deviceId) async {
    try {
      _error = null;
      final device = _devices.firstWhere((d) => d.id == deviceId);
      final bluetoothDevice = _connectedDevices[deviceId];

      if (bluetoothDevice != null) {
        if (device.isConnected) {
          await disconnectFromDevice(deviceId);
        } else {
          await connectToDevice(deviceId);
        }
      }
    } catch (e) {
      _error = 'Ошибка при переключении устройства: $e';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _adapterStateSubscription?.cancel();
    for (var device in _devices) {
      if (device.isConnected) {
        disconnectFromDevice(device.id);
      }
    }
    super.dispose();
  }
} 