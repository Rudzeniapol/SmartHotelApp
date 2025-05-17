import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:protobuf/protobuf.dart';
import 'package:smart_hotel/protos/message.pb.dart';

class BleService {
  static const String BLE_NAME = "ROOM_27";
  static const String CHAR_WRITE_UUID = "0000ff02-0000-1000-8000-00805f9b34fb";
  static const String CHAR_STATE_UUID = "0000ff01-0000-1000-8000-00805f9b34fb";
  static const String TOKEN = "I382CdOWG1Tr014J";
  static const Duration CONNECTION_TIMEOUT = Duration(seconds: 10);
  static const Duration SCAN_TIMEOUT = Duration(seconds: 4);

  BluetoothDevice? _device;
  BluetoothCharacteristic? _writeCharacteristic;
  BluetoothCharacteristic? _stateCharacteristic;
  bool _isConnected = false;
  StreamSubscription<BluetoothConnectionState>? _deviceStateSubscription;
  StreamSubscription<List<ScanResult>>? _scanResultsSubscription;

  bool get isConnected => _isConnected;

  Future<bool> connect() async {
    try {
      if (_isConnected) return true;

      // Проверяем состояние Bluetooth
      final state = await FlutterBluePlus.adapterState.first;
      if (state != BluetoothAdapterState.on) {
        throw Exception('Bluetooth выключен');
      }

      // Поиск устройства
      await FlutterBluePlus.startScan(timeout: SCAN_TIMEOUT);
      
      // Создаем Completer для ожидания результатов сканирования
      final completer = Completer<List<ScanResult>>();
      
      // Подписываемся на результаты сканирования
      _scanResultsSubscription = FlutterBluePlus.scanResults.listen(
        (results) {
          if (!completer.isCompleted) {
            completer.complete(results);
          }
        },
        onError: (error) {
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        },
      );

      // Ждем результаты сканирования с таймаутом
      final scanResults = await completer.future.timeout(SCAN_TIMEOUT);
      
      // Отменяем подписку на результаты сканирования
      await _scanResultsSubscription?.cancel();
      
      final deviceResult = scanResults.firstWhere(
        (r) => r.device.name == BLE_NAME,
        orElse: () => throw Exception('Устройство не найдено'),
      );
      
      _device = deviceResult.device;

      // Подключение к устройству с таймаутом
      await _device!.connect().timeout(CONNECTION_TIMEOUT, onTimeout: () {
        throw TimeoutException('Превышено время ожидания подключения');
      });
      
      _isConnected = true;

      // Подписываемся на изменения состояния устройства
      _deviceStateSubscription = _device!.connectionState.listen((state) {
        if (state == BluetoothConnectionState.disconnected) {
          _isConnected = false;
          _writeCharacteristic = null;
          _stateCharacteristic = null;
        }
      });

      // Поиск характеристик
      List<BluetoothService> services = await _device!.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString().toLowerCase() == CHAR_WRITE_UUID.toLowerCase()) {
            _writeCharacteristic = characteristic;
          }
          if (characteristic.uuid.toString().toLowerCase() == CHAR_STATE_UUID.toLowerCase()) {
            _stateCharacteristic = characteristic;
          }
        }
      }

      if (_writeCharacteristic == null || _stateCharacteristic == null) {
        throw Exception('Характеристики не найдены');
      }

      // Отправка токена авторизации
      var authMsg = IdentifyRequest()..token = TOKEN;
      await _writeCharacteristic!.write(authMsg.writeToBuffer());
      return true;
    } catch (e) {
      print("Ошибка подключения: $e");
      await disconnect();
      return false;
    } finally {
      await _scanResultsSubscription?.cancel();
    }
  }

  Future<void> disconnect() async {
    try {
      _deviceStateSubscription?.cancel();
      _scanResultsSubscription?.cancel();
      if (_device != null) {
        await _device!.disconnect();
      }
    } catch (e) {
      print("Ошибка отключения: $e");
    } finally {
      _isConnected = false;
      _device = null;
      _writeCharacteristic = null;
      _stateCharacteristic = null;
    }
  }

  Future<void> setDoorState(States state) async {
    if (!_isConnected || _stateCharacteristic == null) {
      throw Exception('Устройство не подключено');
    }

    try {
      var setState = SetState()..state = state;
      await _stateCharacteristic!.write(setState.writeToBuffer())
          .timeout(const Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('Превышено время ожидания отправки команды');
      });
    } catch (e) {
      print("Ошибка установки состояния двери: $e");
      rethrow;
    }
  }

  Future<void> setLightState(States state) async {
    if (!_isConnected || _stateCharacteristic == null) {
      throw Exception('Устройство не подключено');
    }

    try {
      var setState = SetState()..state = state;
      await _stateCharacteristic!.write(setState.writeToBuffer())
          .timeout(const Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('Превышено время ожидания отправки команды');
      });
    } catch (e) {
      print("Ошибка установки состояния света: $e");
      rethrow;
    }
  }
} 