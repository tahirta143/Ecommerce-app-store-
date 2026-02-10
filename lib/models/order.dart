import 'package:ecommerce_app/models/product.dart';

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({required this.product, required this.quantity});

  double get total => product.price * quantity;
}

class Order {
  final String id;
  final String userId;
  final String userName;
  final DateTime date;
  final List<OrderItem> items;
  final double totalAmount;
  final OrderStatus status;

  Order({
    required this.id,
    required this.userId,
    required this.userName,
    required this.date,
    required this.items,
    required this.totalAmount,
    required this.status,
  });
}
