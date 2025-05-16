import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

class BLEService {
  static final BLEService _instance = BLEService._internal();
  factory BLEService() => _instance;
  BLEService._internal();

  // Используем FlutterBluePlus напрямую вместо instance
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _doorCharacteristic;
  BluetoothCharacteristic? _lightCharacteristic;

  // UUID сервисов и характеристик
  static const String DOOR_SERVICE_UUID = "00001800-0000-1000-8000-00805f9b34fb";
  static const String LIGHT_SERVICE_UUID = "00001801-0000-1000-8000-00805f9b34fb";
  static const String DOOR_CHARACTERISTIC_UUID = "00002a00-0000-1000-8000-00805f9b34fb";
  static const String LIGHT_CHARACTERISTIC_UUID = "00002a01-0000-1000-8000-00805f9b34fb";

  Future<void> initialize() async {
    try {
      // Проверяем, включен ли Bluetooth
      if (await FlutterBluePlus.isAvailable == false) {
        throw Exception('Bluetooth недоступен на этом устройстве');
      }

      // Проверяем, включен ли Bluetooth
      if (await FlutterBluePlus.isOn == false) {
        throw Exception('Bluetooth выключен');
      }

      // Останавливаем предыдущее сканирование, если оно было
      await FlutterBluePlus.stopScan();
    } catch (e) {
      print('Ошибка инициализации BLE: $e');
      rethrow;
    }
  }

  Future<bool> connectToRoom(String roomId) async {
    try {
      // Сканирование устройств
      await FlutterBluePlus.startScan(timeout: Duration(seconds: 4));
      
      // Поиск устройства по roomId
      final results = await FlutterBluePlus.scanResults.first;
      BluetoothDevice? targetDevice;
      
      for (ScanResult result in results) {
        if (result.device.name.contains(roomId)) {
          targetDevice = result.device;
          break;
        }
      }

      if (targetDevice == null) {
        return false;
      }

      // Подключение к устройству
      await targetDevice.connect();
      _connectedDevice = targetDevice;

      // Поиск сервисов
      List<BluetoothService> services = await targetDevice.discoverServices();
      
      // Поиск характеристик для двери
      for (BluetoothService service in services) {
        if (service.uuid.toString() == DOOR_SERVICE_UUID) {
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            if (characteristic.uuid.toString() == DOOR_CHARACTERISTIC_UUID) {
              _doorCharacteristic = characteristic;
            }
          }
        }
      }

      // Поиск характеристик для освещения
      for (BluetoothService service in services) {
        if (service.uuid.toString() == LIGHT_SERVICE_UUID) {
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            if (characteristic.uuid.toString() == LIGHT_CHARACTERISTIC_UUID) {
              _lightCharacteristic = characteristic;
            }
          }
        }
      }

      return true;
    } catch (e) {
      print('Ошибка подключения: $e');
      return false;
    }
  }

  Future<bool> openDoor() async {
    if (_doorCharacteristic == null) return false;
    
    try {
      await _doorCharacteristic!.write([0x01]);
      return true;
    } catch (e) {
      print('Ошибка открытия двери: $e');
      return false;
    }
  }

  Future<bool> toggleLight(bool turnOn) async {
    if (_lightCharacteristic == null) return false;
    
    try {
      await _lightCharacteristic!.write([turnOn ? 0x01 : 0x00]);
      return true;
    } catch (e) {
      print('Ошибка управления светом: $e');
      return false;
    }
  }

  Future<void> disconnect() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      _connectedDevice = null;
      _doorCharacteristic = null;
      _lightCharacteristic = null;
    }
  }

  void dispose() {
    // Отключаемся от устройства при уничтожении сервиса
    disconnect();
    // Останавливаем сканирование
    FlutterBluePlus.stopScan();
  }
}