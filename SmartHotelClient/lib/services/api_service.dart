import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hotel_models.dart';

class ApiService {
  static const String baseUrl = 'https://api.smarthotel.com'; // Замените на реальный URL

  // Регистрация нового пользователя
  Future<User> register(String name, String phone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Ошибка регистрации: ${response.body}');
    }
  }

  // Аутентификация
  Future<User> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Ошибка авторизации');
    }
  }

  // Получение списка номеров
  Future<List<Room>> getRooms() async {
    final response = await http.get(
      Uri.parse('$baseUrl/rooms'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> roomsJson = json.decode(response.body);
      return roomsJson.map((json) => Room.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка получения списка номеров');
    }
  }

  // Поиск доступных номеров
  Future<List<Room>> searchAvailableRooms({
    required DateTime checkIn,
    required DateTime checkOut,
    required String roomType,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/rooms/search'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'checkIn': checkIn.toIso8601String(),
        'checkOut': checkOut.toIso8601String(),
        'roomType': roomType,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> roomsJson = json.decode(response.body);
      return roomsJson.map((json) => Room.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка поиска номеров');
    }
  }

  // Бронирование номера
  Future<Booking> bookRoom({
    required String roomId,
    required DateTime checkIn,
    required DateTime checkOut,
    required String userId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'roomId': roomId,
        'checkIn': checkIn.toIso8601String(),
        'checkOut': checkOut.toIso8601String(),
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      return Booking.fromJson(json.decode(response.body));
    } else {
      throw Exception('Ошибка бронирования номера');
    }
  }

  // Получение активного бронирования пользователя
  Future<Booking?> getActiveBooking(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId/active-booking'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data != null ? Booking.fromJson(data) : null;
    } else {
      throw Exception('Ошибка получения активного бронирования');
    }
  }

  // Обновление статуса номера (для администратора)
  Future<void> updateRoomStatus(String roomId, RoomStatus status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/rooms/$roomId/status'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'status': status.toString().split('.').last,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка обновления статуса номера');
    }
  }

  // Получение статистики отеля (для администратора)
  Future<Map<String, dynamic>> getHotelStatistics() async {
    final response = await http.get(
      Uri.parse('$baseUrl/statistics'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Ошибка получения статистики');
    }
  }
} 