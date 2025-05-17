import 'package:flutter/material.dart';
import 'package:smart_hotel/services/ble_service.dart';
import 'package:smart_hotel/protos/message.pb.dart' as pb;
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

class RoomControlScreen extends StatefulWidget {
  const RoomControlScreen({super.key});

  @override
  State<RoomControlScreen> createState() {
    return _RoomControlScreenState();
  }
}

class _RoomControlScreenState extends State<RoomControlScreen> {
  final BleService _bleService = BleService();
  bool _isConnected = false;
  bool _isDoorOpen = false;
  bool _isLightOn = false;
  bool _isLoading = false;
  String? _error;
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  @override
  void initState() {
    super.initState();
    _initializeBluetooth();
  }

  Future<void> _initializeBluetooth() async {
    try {
      // Подписываемся на изменения состояния Bluetooth
      _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
        if (state == BluetoothAdapterState.off) {
          setState(() {
            _error = 'Bluetooth выключен';
            _isConnected = false;
          });
        } else if (state == BluetoothAdapterState.on) {
          setState(() {
            _error = null;
          });
          _connectToDevice();
        }
      });

      // Проверяем текущее состояние Bluetooth
      final state = await FlutterBluePlus.adapterState.first;
      if (state == BluetoothAdapterState.on) {
        _connectToDevice();
      } else {
        setState(() {
          _error = 'Bluetooth выключен';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Ошибка инициализации Bluetooth: $e';
      });
    }
  }

  @override
  void dispose() {
    _adapterStateSubscription?.cancel();
    _bleService.disconnect();
    super.dispose();
  }

  Future<void> _connectToDevice() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final connected = await _bleService.connect();
      setState(() {
        _isConnected = connected;
        if (!connected) {
          _error = 'Не удалось подключиться к устройству';
        }
      });
    } catch (e) {
      setState(() {
        _error = 'Ошибка подключения: $e';
        _isConnected = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleDoor() async {
    if (!_isConnected || _isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final newState = _isDoorOpen ? pb.States.DoorLockClose : pb.States.DoorLockOpen;
      await _bleService.setDoorState(newState);
      setState(() {
        _isDoorOpen = !_isDoorOpen;
      });
    } catch (e) {
      setState(() {
        _error = 'Ошибка управления дверью: $e';
        _isConnected = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleLight() async {
    if (!_isConnected || _isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final newState = _isLightOn ? pb.States.LightOff : pb.States.LightOn;
      await _bleService.setLightState(newState);
      setState(() {
        _isLightOn = !_isLightOn;
      });
    } catch (e) {
      setState(() {
        _error = 'Ошибка управления светом: $e';
        _isConnected = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Управление комнатой'),
        actions: [
          IconButton(
            icon: Icon(_isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled),
            onPressed: _isLoading ? null : _connectToDevice,
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_error != null)
                  Card(
                    color: Colors.red.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _error!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => setState(() => _error = null),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Дверь',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _isLoading || !_isConnected ? null : _toggleDoor,
                          icon: Icon(_isDoorOpen ? Icons.lock_open : Icons.lock),
                          label: Text(_isDoorOpen ? 'Закрыть дверь' : 'Открыть дверь'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isDoorOpen ? Colors.red : Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Свет',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _isLoading || !_isConnected ? null : _toggleLight,
                          icon: Icon(_isLightOn ? Icons.lightbulb : Icons.lightbulb_outline),
                          label: Text(_isLightOn ? 'Выключить свет' : 'Включить свет'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isLightOn ? Colors.yellow : Colors.grey,
                            foregroundColor: _isLightOn ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}