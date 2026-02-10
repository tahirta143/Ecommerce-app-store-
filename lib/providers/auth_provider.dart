import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isAdmin => _currentUser?.role == UserRole.admin;

  Future<bool> login(String email, String password) async {
    // Mock login logic
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    if (email.toLowerCase().contains('admin')) {
      _currentUser = User(
        id: 'admin_1',
        name: 'Admin User',
        email: email,
        role: UserRole.admin,
        profileImage: 'assets/users/admin.png',
      );
    } else {
      _currentUser = User(
        id: 'user_1',
        name: 'John Doe',
        email: email,
        role: UserRole.user,
        profileImage: 'assets/users/user.png',
      );
    }

    _isAuthenticated = true;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
