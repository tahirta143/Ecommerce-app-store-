import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double? discountPercentage;
  final double rating;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.discountPercentage,
    this.rating = 4.5,
    this.onAddToCart,
  });

  // Single cohesive color theme - Professional Indigo/Purple mix (matching MainWrapper)
  static const Color _primaryColor = Color(0xFF6366F1); // Indigo
  static const Color _secondaryColor = Color(0xFF8B5CF6); // Purple accent
  static const Color _surfaceColor = Color(0xFFF8FAFC); // Light background
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _red = Color(0xFFE53E3E);
  static const Color _red2 = Color(0xFFC53030);
  static const Color _red3 = Color(0xFF9B2C2C);
  static const Color _red4 = Color(0xFF742A2A);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;
    final isLargeDesktop = size.width >= 1200;

    final hasDiscount = discountPercentage != null && discountPercentage! > 0;
    final originalPrice = hasDiscount
        ? product.price * 100 / (100 - discountPercentage!)
        : product.price;

    // Responsive sizing
    final double containerRadius = isLargeDesktop ? 24 : (isDesktop ? 20 : (isTablet ? 18 : 16));
    final double imageHeight = isLargeDesktop ? 180 : (isDesktop ? 160 : (isTablet ? 140 : 130));
    final double imageWidth = isLargeDesktop ? 100 : (isDesktop ? 90 : (isTablet ? 85 : 80));
    final double iconSize = isLargeDesktop ? 48 : (isDesktop ? 42 : (isTablet ? 38 : 36));
    final double titleFontSize = isLargeDesktop ? 16 : (isDesktop ? 15 : (isTablet ? 14 : 13));
    final double priceFontSize = isLargeDesktop ? 20 : (isDesktop ? 18 : (isTablet ? 17 : 16));
    final double originalPriceFontSize = isLargeDesktop ? 13 : (isDesktop ? 12 : (isTablet ? 11.5 : 11));
    final double buttonSize = isLargeDesktop ? 44 : (isDesktop ? 40 : (isTablet ? 36 : 32));
    final double buttonIconSize = isLargeDesktop ? 22 : (isDesktop ? 20 : (isTablet ? 19 : 18));
    final double badgeFontSize = isLargeDesktop ? 12 : (isDesktop ? 11 : (isTablet ? 10.5 : 10));
    final double badgePadding = isLargeDesktop ? 12 : (isDesktop ? 10 : (isTablet ? 9 : 8));
    final double ratingFontSize = isLargeDesktop ? 12 : (isDesktop ? 11 : (isTablet ? 10.5 : 10));
    final double ratingIconSize = isLargeDesktop ? 14 : (isDesktop ? 13 : (isTablet ? 12.5 : 12));
    final double contentPadding = isLargeDesktop ? 16 : (isDesktop ? 14 : (isTablet ? 13 : 12));
    final double borderRadius = isLargeDesktop ? 12 : (isDesktop ? 10 : (isTablet ? 9 : 8));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: _white,
          borderRadius: BorderRadius.circular(containerRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: isLargeDesktop ? 16 : (isDesktop ? 14 : (isTablet ? 12 : 10)),
              spreadRadius: 0,
              offset: Offset(0, isLargeDesktop ? 6 : (isDesktop ? 5 : (isTablet ? 4 : 3))),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Main Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: imageHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _surfaceColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(containerRadius),
                      topRight: Radius.circular(containerRadius),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Product Image Placeholder
                      Center(
                        child: Container(
                          width: imageWidth,
                          height: imageWidth,
                          decoration: BoxDecoration(
                            color: _white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            size: iconSize,
                            color: _textSecondary.withOpacity(0.3),
                          ),
                        ),
                      ),

                      // Rating Badge
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: ratingIconSize,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                rating.toStringAsFixed(1),
                                style: GoogleFonts.poppins(
                                  fontSize: ratingFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: _textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Product Info
                Padding(
                  padding: EdgeInsets.all(contentPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w500,
                          color: _textPrimary,
                          height: 1.3,
                        ),
                      ),

                      SizedBox(height: isLargeDesktop ? 8 : (isDesktop ? 7 : (isTablet ? 6.5 : 6))),

                      // Price Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Price Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Current Price in PKR
                              Text(
                                'Rs ${_formatPrice(product.price)}',
                                style: GoogleFonts.poppins(
                                  fontSize: priceFontSize,
                                  fontWeight: FontWeight.w700,
                                  color: _primaryColor,
                                ),
                              ),

                              // Original Price (if discounted)
                              if (hasDiscount)
                                Text(
                                  'Rs ${_formatPrice(originalPrice)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: originalPriceFontSize,
                                    fontWeight: FontWeight.w400,
                                    color: _textSecondary,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),

                          // Add to Cart Button
                          GestureDetector(
                            onTap: onAddToCart,
                            child: Container(
                              width: buttonSize,
                              height: buttonSize,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    _primaryColor,
                                    _secondaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(borderRadius),
                                boxShadow: [
                                  BoxShadow(
                                    color: _primaryColor.withOpacity(0.3),
                                    blurRadius: isLargeDesktop ? 10 : (isDesktop ? 8 : (isTablet ? 7 : 6)),
                                    offset: Offset(0, isLargeDesktop ? 4 : (isDesktop ? 3 : (isTablet ? 2.5 : 2))),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.add,
                                size: buttonIconSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Discount Badge
            if (hasDiscount)
              Positioned(
                top: isLargeDesktop ? 12 : (isDesktop ? 10 : (isTablet ? 9 : 8)),
                left: isLargeDesktop ? 12 : (isDesktop ? 10 : (isTablet ? 9 : 8)),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: badgePadding,
                    vertical: badgePadding * 0.5,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _red,
                        _red2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(isLargeDesktop ? 16 : (isDesktop ? 14 : (isTablet ? 13 : 12))),
                    boxShadow: [
                      BoxShadow(
                        color: _red.withOpacity(0.3),
                        blurRadius: isLargeDesktop ? 12 : (isDesktop ? 10 : (isTablet ? 9 : 8)),
                        offset: Offset(0, isLargeDesktop ? 4 : (isDesktop ? 3 : (isTablet ? 2.5 : 2))),
                      ),
                    ],
                  ),
                  child: Text(
                    '${discountPercentage!.toInt()}% OFF',
                    style: GoogleFonts.poppins(
                      fontSize: badgeFontSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper function to format price with proper commas
  String _formatPrice(double price) {
    // Format price with commas for thousands
    final priceString = price.toStringAsFixed(
      price.truncateToDouble() == price ? 0 : 2,
    );

    // Split into whole and decimal parts
    final parts = priceString.split('.');
    final wholePart = parts[0];

    // Add commas for thousands
    final buffer = StringBuffer();
    for (int i = 0; i < wholePart.length; i++) {
      if (i > 0 && (wholePart.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(wholePart[i]);
    }

    // Add decimal part if exists
    if (parts.length > 1 && parts[1] != '00' && parts[1] != '0') {
      buffer.write('.${parts[1]}');
    }

    return buffer.toString();
  }
}