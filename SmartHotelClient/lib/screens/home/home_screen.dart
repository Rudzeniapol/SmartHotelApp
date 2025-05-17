import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_hotel/providers/auth_provider.dart';
import 'package:smart_hotel/providers/booking_provider.dart';
import 'package:smart_hotel/providers/device_provider.dart';
import 'package:smart_hotel/screens/home/bookings_screen.dart';
import 'package:smart_hotel/screens/home/devices_screen.dart';
import 'package:smart_hotel/screens/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const BookingsScreen(),
    const DevicesScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    await bookingProvider.fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Бронирования',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Устройства',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
} 