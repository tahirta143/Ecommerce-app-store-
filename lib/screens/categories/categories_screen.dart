
import 'package:ecommerce_app/screens/shop/shop_screen.dart';
import 'package:ecommerce_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {"name": "Electronics", "icon": Icons.electrical_services},
    {"name": "Fashion", "icon": Icons.checkroom},
    {"name": "Home", "icon": Icons.home},
    {"name": "Beauty", "icon": Icons.face},
    {"name": "Sports", "icon": Icons.sports_soccer},
    {"name": "Toys", "icon": Icons.toys},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text(
                        categories[index]["name"],
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      iconTheme: const IconThemeData(color: Colors.black),
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                    body: ShopScreen(activeCategory: categories[index]["name"]),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    categories[index]["icon"],
                    size: 40,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    categories[index]["name"],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
