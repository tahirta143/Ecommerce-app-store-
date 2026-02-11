import 'package:ecommerce_app/data/product_data.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopScreen extends StatefulWidget {
  final String activeCategory;
  const ShopScreen({super.key, this.activeCategory = "All"});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<String> _categories = ["All", "Electronics", "Fashion", "Home"];
  late String _selectedCategory;

  // Define your app's primary color
  final Color _primaryColor = const Color(0xFF3B82F6); // Blue color
  // Alternative: const Color(0xFF6C63FF); // Purple color
  // Alternative: const Color(0xFFE53935); // Red color

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.activeCategory;
  }

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = _selectedCategory == "All"
        ? dummyProducts
        : dummyProducts
        .where((product) => product.category == _selectedCategory)
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Categories horizontal list
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? _primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? _primaryColor
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: GoogleFonts.poppins(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Products grid
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(
                child: Text(
                  "No products found",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              )
                  : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: filteredProducts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}