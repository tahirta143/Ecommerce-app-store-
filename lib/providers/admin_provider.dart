import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier {
  List<User> _users = [];
  List<Order> _orders = [];
  List<String> _categories = [];

  List<User> get users => _users;
  List<Order> get orders => _orders;
  List<String> get categories => _categories;

  AdminProvider() {
    _initMockData();
  }

  void _initMockData() {
    // Mock Categories
    _categories = ['Electronics', 'Fashion', 'Home', 'Beauty', 'Sports'];

    // Mock Users
    _users = [
      User(id: '1', name: 'John Doe', email: 'john@test.com', role: UserRole.user),
      User(id: '2', name: 'Jane Smith', email: 'jane@test.com', role: UserRole.user),
      User(id: '3', name: 'Admin User', email: 'admin@test.com', role: UserRole.admin),
    ];

    // Mock Orders
    _orders = [
      Order(
        id: 'ord_1',
        userId: '1',
        userName: 'John Doe',
        date: DateTime.now().subtract(const Duration(days: 1)),
        items: [], // Simplified for mock
        totalAmount: 129.99,
        status: OrderStatus.processing,
      ),
      Order(
        id: 'ord_2',
        userId: '2',
        userName: 'Jane Smith',
        date: DateTime.now().subtract(const Duration(days: 2)),
        items: [],
        totalAmount: 59.50,
        status: OrderStatus.delivered,
      ),
    ];
  }

  void addCategory(String category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
      notifyListeners();
    }
  }

  void removeCategory(String category) {
    _categories.remove(category);
    notifyListeners();
  }
  
  void updateOrderStatus(String orderId, OrderStatus status) {
      // In a real app we would copy and update, but for mock list manipulation is fine
      // However order properties are final so we need to recreate
      final index = _orders.indexWhere((o) => o.id == orderId);
      if (index != -1) {
          final old = _orders[index];
          _orders[index] = Order(
              id: old.id,
              userId: old.userId,
              userName: old.userName,
              date: old.date,
              items: old.items,
              totalAmount: old.totalAmount,
              status: status,
          );
          notifyListeners();
      }
  }
}
