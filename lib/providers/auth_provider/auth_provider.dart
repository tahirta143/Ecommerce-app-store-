import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

  static const String baseUrl = 'https://backend-with-node-js-ueii.onrender.com/api';
  static const String userLoginUrl  = '$baseUrl/auth/login';
  static const String adminLoginUrl = '$baseUrl/admin/login';

  // Getters
  User?   get currentUser   => _currentUser;
  String? get token         => _token;
  bool    get isLoading     => _isLoading;
  String? get errorMessage  => _errorMessage;
  bool    get isAdmin       => _currentUser?.role == UserRole.admin;
  bool    get isLoggedIn    => _currentUser != null && _token != null;
  bool    get isInitialized => _isInitialized;

  AuthProvider() {
    _init();
  }

  // ─── Safe notify ────────────────────────────────────────────────────────────
  /// Defers notifyListeners if called during a build/layout phase.
  void _safeNotify() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => notifyListeners());
    } else {
      notifyListeners();
    }
  }

  // ─── Init ────────────────────────────────────────────────────────────────────
  Future<void> _init() async {
    await loadUserFromStorage();
    _isInitialized = true;
    _safeNotify();
  }

  // ─── Login ──────────────────────────────────────────────────────────────────
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _safeNotify();

    try {
      // Try admin login first
      final adminResponse = await _attemptLogin(adminLoginUrl, email, password);
      if (adminResponse != null && adminResponse['success'] == true) {
        _processAdminLoginResponse(adminResponse);
        return true;
      }

      // Fall back to user login
      final userResponse = await _attemptLogin(userLoginUrl, email, password);
      if (userResponse != null && userResponse['success'] == true) {
        _processUserLoginResponse(userResponse);
        return true;
      }

      _errorMessage = 'Invalid email or password';
      _isLoading = false;
      _safeNotify();
      return false;

    } catch (e) {
      debugPrint('Login error: $e');
      _errorMessage = 'Network error: ${e.toString()}';
      _isLoading = false;
      _safeNotify();
      return false;
    }
  }

  // ─── Attempt login helper ───────────────────────────────────────────────────
  Future<Map<String, dynamic>?> _attemptLogin(
      String url, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      debugPrint('_attemptLogin error ($url): $e');
      return null;
    }
  }

  // ─── Process responses ───────────────────────────────────────────────────────
  void _processUserLoginResponse(Map<String, dynamic> response) {
    try {
      _token       = response['token'] as String?;
      _currentUser = User.fromNonAdminJson(response['user'] as Map<String, dynamic>);
      _isLoading   = false;
      _saveUserToStorage();
      _safeNotify();
    } catch (e) {
      debugPrint('Error processing user login: $e');
      _errorMessage = 'Error processing login response';
      _isLoading = false;
      _safeNotify();
    }
  }

  void _processAdminLoginResponse(Map<String, dynamic> response) {
    try {
      final data   = response['data'] as Map<String, dynamic>;
      _token       = data['token'] as String?;
      _currentUser = User.fromAdminJson(data['admin'] as Map<String, dynamic>);
      _isLoading   = false;
      _saveUserToStorage();
      _safeNotify();
    } catch (e) {
      debugPrint('Error processing admin login: $e');
      _errorMessage = 'Error processing login response';
      _isLoading = false;
      _safeNotify();
    }
  }

  // ─── Logout ──────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    _currentUser = null;
    _token       = null;
    await _clearStorage();
    _safeNotify();
  }

  // ─── Storage ─────────────────────────────────────────────────────────────────

  /// Saves both token and user (with role) to SharedPreferences.
  Future<void> _saveUserToStorage() async {
    try {
      if (_currentUser == null || _token == null) return;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('user',  json.encode(_currentUser!.toJson()));
      debugPrint('Saved user role: ${_currentUser!.role}');
    } catch (e) {
      debugPrint('Error saving user: $e');
    }
  }

  /// Loads user + token. Only considers the user "logged in" if BOTH exist
  /// AND the User object deserialises correctly (non-null id).
  Future<void> loadUserFromStorage() async {
    try {
      final prefs       = await SharedPreferences.getInstance();
      final tokenString = prefs.getString('token');
      final userString  = prefs.getString('user');

      if (tokenString == null || userString == null) {
        debugPrint('No stored session found.');
        return;
      }

      final userMap = json.decode(userString) as Map<String, dynamic>;
      final restoredUser = User.fromJson(userMap);

      // Guard: if id is empty the JSON was malformed — clear storage
      if (restoredUser.id.isEmpty) {
        debugPrint('Stored user JSON is malformed, clearing session.');
        await _clearStorage();
        return;
      }

      _token       = tokenString;
      _currentUser = restoredUser;
      debugPrint('Restored session for role: ${_currentUser?.role}');
    } catch (e) {
      debugPrint('Error loading user from storage: $e');
      // If anything went wrong, wipe the broken session data
      await _clearStorage();
    }
  }

  Future<void> _clearStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      await prefs.remove('token');
    } catch (e) {
      debugPrint('Error clearing storage: $e');
    }
  }

  // ─── Misc ────────────────────────────────────────────────────────────────────
  void clearError() {
    _errorMessage = null;
    _safeNotify();
  }
}