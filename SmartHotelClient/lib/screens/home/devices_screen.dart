import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_hotel/providers/device_provider.dart';
import 'package:smart_hotel/providers/booking_provider.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Управление устройствами'),
      ),
      body: Consumer2<DeviceProvider, BookingProvider>(
        builder: (context, deviceProvider, bookingProvider, child) {
          if (bookingProvider.currentBooking == null) {
            return const Center(
              child: Text('Вы не заселены в номер'),
            );
          }

          final devices = deviceProvider.devices;

          if (devices.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Устройства не найдены'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await deviceProvider.startScan();
                    },
                    child: const Text('Поиск устройств'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await deviceProvider.startScan();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              device.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Switch(
                              value: device.isOn,
                              onChanged: device.isConnected
                                  ? (value) async {
                                      await deviceProvider.toggleDevice(device.id);
                                    }
                                  : null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Тип: ${device.type}'),
                        if (device.temperature != null)
                          Text('Температура: ${device.temperature}°C'),
                        if (device.humidity != null)
                          Text('Влажность: ${device.humidity}%'),
                        const SizedBox(height: 16),
                        if (!device.isConnected)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await deviceProvider.connectToDevice(device.id);
                              },
                              child: const Text('Подключиться'),
                            ),
                          )
                        else
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await deviceProvider.disconnectFromDevice(device.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Отключиться'),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
} 