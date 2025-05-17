import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_hotel/providers/booking_provider.dart';
import 'package:intl/intl.dart';
import 'package:smart_hotel/screens/home/create_booking_screen.dart';
import 'package:smart_hotel/screens/home/room_control_screen.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои бронирования'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateBookingScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RoomControlScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          if (bookingProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (bookingProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bookingProvider.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => bookingProvider.fetchBookings(),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }

          final bookings = bookingProvider.bookings;

          if (bookings.isEmpty) {
            return const Center(
              child: Text('У вас нет активных бронирований'),
            );
          }

          return RefreshIndicator(
            onRefresh: () => bookingProvider.fetchBookings(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
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
                              'Номер ${booking.roomNumber}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            _buildStatusChip(booking),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Заезд: ${DateFormat('dd.MM.yyyy').format(booking.checkIn)}',
                        ),
                        Text(
                          'Выезд: ${DateFormat('dd.MM.yyyy').format(booking.checkOut)}',
                        ),
                        if (!booking.isCheckedIn && !booking.isCheckedOut)
                          const SizedBox(height: 16),
                        if (!booking.isCheckedIn && !booking.isCheckedOut)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final success = await bookingProvider.checkIn(
                                  booking.id,
                                );
                                if (success && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Успешное заселение'),
                                    ),
                                  );
                                } else if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Ошибка при заселении'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: const Text('Заселиться'),
                            ),
                          )
                        else if (booking.isCheckedIn && !booking.isCheckedOut)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final success = await bookingProvider.checkOut(
                                  booking.id,
                                );
                                if (success && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Успешный выезд'),
                                    ),
                                  );
                                } else if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Ошибка при выезде'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Выехать'),
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

  Widget _buildStatusChip(Booking booking) {
    if (booking.isCheckedOut) {
      return const Chip(
        label: Text('Завершено'),
        backgroundColor: Colors.grey,
      );
    } else if (booking.isCheckedIn) {
      return const Chip(
        label: Text('Активно'),
        backgroundColor: Colors.green,
      );
    } else {
      return const Chip(
        label: Text('Ожидает'),
        backgroundColor: Colors.orange,
      );
    }
  }
} 