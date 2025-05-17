import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_hotel/models/booking.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Booking {
  final String id;
  final String roomNumber;
  final DateTime checkIn;
  final DateTime checkOut;
  final bool isCheckedIn;
  final bool isCheckedOut;

  Booking({
    required this.id,
    required this.roomNumber,
    required this.checkIn,
    required this.checkOut,
    this.isCheckedIn = false,
    this.isCheckedOut = false,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      roomNumber: json['roomNumber'],
      checkIn: DateTime.parse(json['checkIn']),
      checkOut: DateTime.parse(json['checkOut']),
      isCheckedIn: json['isCheckedIn'] ?? false,
      isCheckedOut: json['isCheckedOut'] ?? false,
    );
  }

  Booking copyWith({
    String? id,
    String? roomNumber,
    DateTime? checkIn,
    DateTime? checkOut,
    bool? isCheckedIn,
    bool? isCheckedOut,
  }) {
    return Booking(
      id: id ?? this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
      isCheckedOut: isCheckedOut ?? this.isCheckedOut,
    );
  }
}

class BookingProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;
  static const String _baseUrl = 'YOUR_API_BASE_URL';

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Booking? get currentBooking {
    if (_bookings.isEmpty) return null;
    try {
      return _bookings.firstWhere(
        (booking) => booking.isCheckedIn && !booking.isCheckedOut,
      );
    } catch (e) {
      return null;
    }
  }

  Future<String?> _getAuthToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> fetchBookings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getAuthToken();
      if (token == null) {
        _error = 'Требуется авторизация';
        return;
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/bookings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _bookings = data.map((json) => Booking.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        _error = 'Требуется повторная авторизация';
      } else {
        _error = 'Не удалось загрузить бронирования: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Ошибка при загрузке бронирований: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkIn(String bookingId) async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        _error = 'Требуется авторизация';
        return false;
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/bookings/$bookingId/check-in'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final index = _bookings.indexWhere((b) => b.id == bookingId);
        if (index != -1) {
          _bookings[index] = _bookings[index].copyWith(isCheckedIn: true);
          notifyListeners();
          return true;
        }
      } else if (response.statusCode == 401) {
        _error = 'Требуется повторная авторизация';
      } else {
        _error = 'Ошибка при заселении: ${response.statusCode}';
      }
      return false;
    } catch (e) {
      _error = 'Ошибка при заселении: $e';
      return false;
    }
  }

  Future<bool> checkOut(String bookingId) async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        _error = 'Требуется авторизация';
        return false;
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/bookings/$bookingId/check-out'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final index = _bookings.indexWhere((b) => b.id == bookingId);
        if (index != -1) {
          _bookings[index] = _bookings[index].copyWith(isCheckedOut: true);
          notifyListeners();
          return true;
        }
      } else if (response.statusCode == 401) {
        _error = 'Требуется повторная авторизация';
      } else {
        _error = 'Ошибка при выезде: ${response.statusCode}';
      }
      return false;
    } catch (e) {
      _error = 'Ошибка при выезде: $e';
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
} 