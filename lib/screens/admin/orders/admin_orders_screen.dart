import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// Order Status Enum
enum OrderStatus { pending, processing, shipped, delivered, cancelled }

// Order Model Class
class Order {
  final String id;
  final String userName;
  final double totalAmount;
  final DateTime date;
  final OrderStatus status;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.userName,
    required this.totalAmount,
    required this.date,
    required this.status,
    required this.items,
  });
}

class OrderItem {
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productName,
    required this.quantity,
    required  this.price,
  });
}

class AdminOrdersScreen extends StatelessWidget {
  AdminOrdersScreen({super.key});

  // Color theme
  static const Color _primaryColor = Color(0xFF6366F1);
  static const Color _surfaceColor = Color(0xFFF8FAFC);
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _white = Color(0xFFFFFFFF);

  // Sample orders data for UI demonstration
  final List<Order> _orders = [
    Order(
      id: 'ORD-001',
      userName: 'John Doe',
      totalAmount: 2500.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: OrderStatus.pending,
      items: [
        OrderItem(productName: 'Modern Dresses for Girls', quantity: 2, price: 1250),
      ],
    ),
    Order(
      id: 'ORD-002',
      userName: 'Jane Smith',
      totalAmount: 4500.50,
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: OrderStatus.processing,
      items: [
        OrderItem(productName: 'iPhone 14 Pro', quantity: 1, price: 20455),
        OrderItem(productName: 'Beauty Products', quantity: 3, price: 2000),
      ],
    ),
    Order(
      id: 'ORD-003',
      userName: 'Bob Johnson',
      totalAmount: 899.99,
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: OrderStatus.shipped,
      items: [
        OrderItem(productName: 'Wireless Headphones', quantity: 1, price: 899.99),
      ],
    ),
    Order(
      id: 'ORD-004',
      userName: 'Alice Williams',
      totalAmount: 1299.99,
      date: DateTime.now().subtract(const Duration(days: 4)),
      status: OrderStatus.delivered,
      items: [
        OrderItem(productName: 'Smart Watch', quantity: 1, price: 1299.99),
      ],
    ),
    Order(
      id: 'ORD-005',
      userName: 'Charlie Brown',
      totalAmount: 349.50,
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: OrderStatus.cancelled,
      items: [
        OrderItem(productName: 'Running Shoes', quantity: 1, price: 349.50),
      ],
    ),
    Order(
      id: 'ORD-006',
      userName: 'Diana Prince',
      totalAmount: 1899.99,
      date: DateTime.now().subtract(const Duration(hours: 6)),
      status: OrderStatus.pending,
      items: [
        OrderItem(productName: 'Tablet', quantity: 1, price: 1899.99),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    return Scaffold(
      backgroundColor: _surfaceColor,
      appBar: AppBar(
        title: Text(
          "Manage Orders",
          style: GoogleFonts.poppins(
            color: _white,
            fontWeight: FontWeight.w600,
            fontSize: isDesktop ? 24 : (isTablet ? 22 : 20),
          ),
        ),
        backgroundColor: _primaryColor,
        foregroundColor: _white,
        elevation: 0,
        centerTitle: false,
        actions: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              // Implement search functionality
            },
          ),
          // Filter button
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              // Implement filter functionality
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Stats Section
          Container(
            padding: EdgeInsets.all(isDesktop ? 24 : (isTablet ? 20 : 16)),
            child: Row(
              children: [
                _buildStatCard(
                  title: "Total Orders",
                  value: _orders.length.toString(),
                  icon: Icons.shopping_bag,
                  color: _primaryColor,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  title: "Pending",
                  value: _orders.where((o) => o.status == OrderStatus.pending).length.toString(),
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  title: "Completed",
                  value: _orders.where((o) => o.status == OrderStatus.delivered).length.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(isDesktop ? 24 : (isTablet ? 20 : 16)),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return _buildOrderCard(
                  context,
                  order,
                  index,
                  isDesktop,
                  isTablet,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDesktop,
    required bool isTablet,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(isDesktop ? 20 : (isTablet ? 16 : 12)),
        decoration: BoxDecoration(
          color: _white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: isDesktop ? 24 : (isTablet ? 22 : 20),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 28 : (isTablet ? 24 : 22),
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                color: _textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(
      BuildContext context,
      Order order,
      int index,
      bool isDesktop,
      bool isTablet,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: isDesktop ? 16 : 12),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(isDesktop ? 20 : (isTablet ? 16 : 12)),
          childrenPadding: EdgeInsets.all(isDesktop ? 20 : (isTablet ? 16 : 12)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          leading: Container(
            width: isDesktop ? 60 : (isTablet ? 50 : 40),
            height: isDesktop ? 60 : (isTablet ? 50 : 40),
            decoration: BoxDecoration(
              color: _getStatusColor(order.status).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#${index + 1}',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                  fontWeight: FontWeight.w600,
                  color: _getStatusColor(order.status),
                ),
              ),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.id,
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 18 : (isTablet ? 16 : 15),
                        fontWeight: FontWeight.w600,
                        color: _textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.userName,
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                        color: _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 20 : (isTablet ? 18 : 16),
                      fontWeight: FontWeight.w700,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM dd, yyyy').format(order.date),
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 12 : 11,
                      color: _textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(order.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                order.status.name.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontSize: isDesktop ? 12 : 11,
                  fontWeight: FontWeight.w600,
                  color: _getStatusColor(order.status),
                ),
              ),
            ),
          ),
          children: [
            // Order Items
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Items',
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.productName,
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                            color: _textSecondary,
                          ),
                        ),
                      ),
                      Text(
                        'x${item.quantity}',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                          fontWeight: FontWeight.w500,
                          color: _textPrimary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                          fontWeight: FontWeight.w600,
                          color: _primaryColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),

                const Divider(height: 24),

                // Status Update Section
                Text(
                  'Update Status',
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: OrderStatus.values.map((status) {
                    final isSelected = order.status == status;
                    return GestureDetector(
                      onTap: () {
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Order ${order.id} status updated to ${status.name}',
                              style: GoogleFonts.poppins(),
                            ),
                            backgroundColor: _getStatusColor(status),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _getStatusColor(status)
                              : _getStatusColor(status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : _getStatusColor(status).withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          status.name.toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop ? 13 : 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? _white : _getStatusColor(status),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.indigo;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}