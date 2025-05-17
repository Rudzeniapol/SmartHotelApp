import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;
  String? _name;
  String? _userPhone;
  static const String _tokenKey = 'auth_token';
  static const String _nameKey = 'name';
  static const String _userPhoneKey = 'user_phone';
  static const String _baseUrl = 'http://10.65.158.62:8000';

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  String? get name => _name;
  String? get userPhone => _userPhone;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
    _name = prefs.getString(_nameKey);
    _userPhone = prefs.getString(_userPhoneKey);
    _isAuthenticated = _token != null;
    
    // Проверяем валидность токена при загрузке
    if (_token != null) {
      final isValid = await _validateToken();
      if (!isValid) {
        await logout();
      }
    }
    
    notifyListeners();
  }

  Future<bool> _validateToken() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/auth/validate'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/refresh'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _token = data['token'];
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, _token!);
        
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'phone': phone,
          'password': password,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _token = data['token'];
        _name = data['name'];
        _userPhone = phone;
        _isAuthenticated = true;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, _token!);
        await prefs.setString(_nameKey, _name!);
        await prefs.setString(_userPhoneKey, _userPhone!);
        
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Метод для проверки и обновления токена перед запросом
  Future<bool> ensureValidToken() async {
    if (_token == null) return false;
    
    final isValid = await _validateToken();
    if (!isValid) {
      final refreshed = await _refreshToken();
      if (!refreshed) {
        await logout();
        return false;
      }
    }
    return true;
  }

  Future<bool> register(String phone, String password, String name) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'phone': phone,
          'password': password,
          'name': name,
        }),
      );

      if (response.statusCode == 201) {
        return await login(phone, password);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    _name = null;
    _userPhone = null;
    _isAuthenticated = false;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_userPhoneKey);
    
    notifyListeners();
  }
} 