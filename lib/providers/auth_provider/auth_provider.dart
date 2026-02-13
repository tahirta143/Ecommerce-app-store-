import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth_model/auth_models.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  String? _token;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isInitialized = false;

  // API URLs
  static const String baseUrl = 'https://backend-with-node-js-ueii.onrender.com/api';
  static const String userLoginUrl = '$baseUrl/auth/login';
  static const String adminLoginUrl = '$baseUrl/admin/login';

  // Getters
  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAdmin => _currentUser?.role == UserRole.admin;
  bool get isLoggedIn => _currentUser != null;
  bool get isInitialized => _isInitialized;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    await loadUserFromStorage();
    _isInitialized = true;
    notifyListeners();
  }

  // Login method that handles both admin and user login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // First try admin login
      print('Attempting admin login first...');
      final adminResponse = await _attemptLogin(
        adminLoginUrl,
        email,
        password,
      );

      if (adminResponse != null && adminResponse['success'] == true) {
        print('Admin login successful');
        _processAdminLoginResponse(adminResponse);
        return true;
      }

      // If admin login fails, try user login
      print('Admin login failed, attempting user login...');
      final userResponse = await _attemptLogin(
        userLoginUrl,
        email,
        password,
      );

      if (userResponse != null && userResponse['success'] == true) {
        print('User login successful');
        _processUserLoginResponse(userResponse);
        return true;
      }

      // Both login attempts failed
      print('Both login attempts failed');
      _errorMessage = 'Invalid email or password';
      _isLoading = false;
      notifyListeners();
      return false;

    } catch (e) {
      print('Login error: $e');
      _errorMessage = 'Network error: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Helper method to attempt login
  Future<Map<String, dynamic>?> _attemptLogin(
      String url,
      String email,
      String password,
      ) async {
    try {
      print('Attempting login to: $url');
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print('Response data: $responseData');
        return responseData;
      } else {
        print('Login failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Process user login response
  void _processUserLoginResponse(Map<String, dynamic> response) {
    try {
      _token = response['token'];
      _currentUser = User.fromNonAdminJson(response['user']);
      print('User role set to: ${_currentUser?.role}');
      _isLoading = false;
      _saveUserToStorage();
      notifyListeners();
    } catch (e) {
      print('Error processing user login response: $e');
      _errorMessage = 'Error processing login response';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Process admin login response
  void _processAdminLoginResponse(Map<String, dynamic> response) {
    try {
      _token = response['data']['token'];
      _currentUser = User.fromAdminJson(response['data']['admin']);
      print('Admin role set to: ${_currentUser?.role}');
      _isLoading = false;
      _saveUserToStorage();
      notifyListeners();
    } catch (e) {
      print('Error processing admin login response: $e');
      _errorMessage = 'Error processing login response';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout method
  Future<void> logout() async {
    _currentUser = null;
    _token = null;
    await _clearStorage();
    notifyListeners();
  }

  // Storage methods
  Future<void> _saveUserToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_currentUser != null && _token != null) {
        await prefs.setString('user', json.encode(_currentUser!.toJson()));
        await prefs.setString('token', _token!);
        print('User saved to storage with role: ${_currentUser!.role}');
      }
    } catch (e) {
      print('Error saving user to storage: $e');
    }
  }

  Future<void> loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userString = prefs.getString('user');
      final tokenString = prefs.getString('token');

      if (userString != null && tokenString != null) {
        final userMap = json.decode(userString);
        _currentUser = User.fromJson(userMap);
        _token = tokenString;
        print('User loaded from storage with role: ${_currentUser?.role}');
        notifyListeners();
      }
    } catch (e) {
      print('Error loading user from storage: $e');
    }
  }

  Future<void> _clearStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      await prefs.remove('token');
    } catch (e) {
      print('Error clearing storage: $e');
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}