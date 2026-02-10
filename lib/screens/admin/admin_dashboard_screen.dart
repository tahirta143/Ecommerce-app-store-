import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/screens/admin/categories/admin_categories_screen.dart';
import 'package:ecommerce_app/screens/admin/orders/admin_orders_screen.dart';
import 'package:ecommerce_app/screens/admin/products/admin_products_screen.dart';
import 'package:ecommerce_app/screens/admin/users/admin_users_screen.dart'; // Import this
import 'package:ecommerce_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const admin_summary_view(),
    const AdminProductsScreen(),
    const AdminCategoriesScreen(),
    const AdminOrdersScreen(),
     const AdminUsersScreen(),
  ];

  final List<String> _titles = [
    "Dashboard",
    "Products",
    "Categories",
    "Orders",
    "Users",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF7C3AED)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.admin_panel_settings, color: Color(0xFF7C3AED)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Admin Panel',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.dashboard, "Dashboard", 0),
            _buildDrawerItem(Icons.inventory, "Products", 1),
            _buildDrawerItem(Icons.category, "Categories", 2),
            _buildDrawerItem(Icons.shopping_bag, "Orders", 3),
            _buildDrawerItem(Icons.people, "Users", 4),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: _selectedIndex == index ? const Color(0xFF7C3AED) : Colors.grey),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: _selectedIndex == index ? const Color(0xFF7C3AED) : Colors.black87,
          fontWeight: _selectedIndex == index ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      selected: _selectedIndex == index,
      onTap: () => _onItemTapped(index),
    );
  }
}

class admin_summary_view extends StatelessWidget {
  const admin_summary_view({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Overview",
             style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildSummaryCard("Total Orders", "12", Icons.shopping_cart, Colors.blue),
              _buildSummaryCard("Total Users", "150", Icons.people, Colors.orange),
              _buildSummaryCard("Products", "45", Icons.inventory_2, Colors.green),
              _buildSummaryCard("Revenue", "\$12.5k", Icons.attach_money, Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
           Text(
            title,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
