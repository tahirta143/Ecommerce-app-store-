import 'package:ecommerce_app/data/product_data.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 32.0 : isTablet ? 24.0 : 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: isDesktop ? 32.0 : isTablet ? 24.0 : 16.0),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                  ),
                ),
              ),

              SizedBox(height: isDesktop ? 32.0 : isTablet ? 24.0 : 20.0),

              // Title
              Text(
                "New Arrivals",
                style: GoogleFonts.poppins(
                  fontSize: isDesktop ? 24.0 : isTablet ? 22.0 : 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: isDesktop ? 24.0 : isTablet ? 20.0 : 16.0),

              // Products Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isDesktop ? 4 : isTablet ? 3 : 2,
                    childAspectRatio: isDesktop ? 0.7 : isTablet ? 0.72 : 0.75,
                    crossAxisSpacing: isDesktop ? 24.0 : isTablet ? 20.0 : 16.0,
                    mainAxisSpacing: isDesktop ? 24.0 : isTablet ? 20.0 : 16.0,
                  ),
                  itemCount: dummyProducts.length,
                  itemBuilder: (context, index) {
                    // Add discount for some products (optional)
                    final discount = index % 3 == 0 ? 20.0 : null;

                    return ProductCard(
                      product: dummyProducts[index],
                      discountPercentage: discount,
                      rating: 4.0 + (index % 5) * 0.3,
                      onAddToCart: () {
                        // Handle add to cart
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${dummyProducts[index].title} to cart'),
                            backgroundColor: const Color(0xFF10B981),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}