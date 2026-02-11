import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/product_detail/product_detail_screen.dart';
import 'package:ecommerce_app/screens/shop/shop_screen.dart';
import 'package:ecommerce_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin {

  final List<Map<String, dynamic>> categories = const [
    {"name": "Electronics", "icon": Icons.electrical_services},
    {"name": "Fashion", "icon": Icons.checkroom},
    {"name": "Home", "icon": Icons.home},
    {"name": "Beauty", "icon": Icons.face},
    {"name": "Sports", "icon": Icons.sports_soccer},
    {"name": "Toys", "icon": Icons.toys},
  ];

  int? _selectedCategoryIndex;
  TabController? _tabController;

  // Subcategories based on main category
  List<String> getSubCategories(int index) {
    switch(categories[index]["name"]) {
      case "Electronics":
        return ["All", "Phones", "Laptops", "Accessories"];
      case "Fashion":
        return ["All", "Men", "Women", "Kids"];
      case "Home":
        return ["All", "Furniture", "Decor", "Kitchen"];
      case "Beauty":
        return ["All", "Makeup", "Skincare", "Haircare"];
      case "Sports":
        return ["All", "Gym", "Outdoor", "Athletic"];
      case "Toys":
        return ["All", "Action Figures", "Dolls", "Games"];
      default:
        return ["All", "Featured", "New", "Popular"];
    }
  }

  // Sample products - replace with your actual product data
  List<Product> getProducts(String categoryName, String subCategory) {
    return List.generate(6, (index) {
      return Product(
        id: "$categoryName-$subCategory-$index",
        title: "$categoryName ${subCategory == "All" ? "Product" : subCategory} ${index + 1}",
        price: (index + 1) * 29.99,
        description: "This is a sample product description for $categoryName in $subCategory category.",
        category: categoryName,
        imageUrl: "assets/images/product_placeholder.png", image: '', // Fixed image URL
      );
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _selectCategory(int index) {
    setState(() {
      if (_selectedCategoryIndex == index) {
        _selectedCategoryIndex = null;
        _tabController?.dispose();
        _tabController = null;
      } else {
        _selectedCategoryIndex = index;
        _tabController?.dispose();
        _tabController = TabController(
          length: getSubCategories(index).length,
          vsync: this,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive sizing
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;
    final padding = MediaQuery.of(context).padding;
    final screenHeight = size.height - padding.top - padding.bottom;

    // Responsive grid settings
    final crossAxisCount = isDesktop ? 4 : (isTablet ? 3 : 2);
    final categoryAspectRatio = isDesktop ? 1.0 : (isTablet ? 1.1 : 1.2);
    final productAspectRatio = isDesktop ? 0.8 : (isTablet ? 0.75 : 0.7);
    final spacing = isDesktop ? 20.0 : (isTablet ? 18.0 : 16.0);
    final fontSize = isDesktop ? 18.0 : (isTablet ? 16.0 : 14.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: isDesktop ? 24 : (isTablet ? 22 : 20),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        toolbarHeight: isDesktop ? 80 : (isTablet ? 70 : 56),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Categories Grid
            Expanded(
              flex: _selectedCategoryIndex == null ? 1 : 2,
              child: GridView.builder(
                padding: EdgeInsets.all(spacing),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: categoryAspectRatio,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _selectCategory(index),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF10B981).withOpacity(0.1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: isSelected
                              ? Border.all(color: const Color(0xFF10B981), width: 1.5)
                              : null,
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
                              size: isDesktop ? 56 : (isTablet ? 48 : 40),
                              color: isSelected
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFF10B981).withOpacity(0.8),
                            ),
                            SizedBox(height: spacing * 0.6),
                            Text(
                              categories[index]["name"],
                              style: GoogleFonts.poppins(
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                fontSize: fontSize * 0.9,
                                color: isSelected
                                    ? const Color(0xFF10B981)
                                    : Colors.black87,
                              ),
                            ),
                            if (isSelected) ...[
                              SizedBox(height: spacing * 0.4),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spacing * 0.75,
                                  vertical: spacing * 0.25,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "Selected",
                                  style: GoogleFonts.poppins(
                                    fontSize: fontSize * 0.6,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Selected Category Content
            if (_selectedCategoryIndex != null && _tabController != null) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: spacing,
                  vertical: spacing * 0.5,
                ),
                color: Colors.grey[50],
                child: Row(
                  children: [
                    Icon(
                      categories[_selectedCategoryIndex!]["icon"],
                      size: isDesktop ? 24 : (isTablet ? 22 : 20),
                      color: const Color(0xFF10B981),
                    ),
                    SizedBox(width: spacing * 0.5),
                    Text(
                      categories[_selectedCategoryIndex!]["name"],
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 20 : (isTablet ? 18 : 16),
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedCategoryIndex = null;
                          _tabController?.dispose();
                          _tabController = null;
                        });
                      },
                      icon: const Icon(Icons.close, size: 18),
                      label: Text(
                        "Close",
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 16 : (isTablet ? 14 : 12),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),

              // Category Tabs
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: const Color(0xFF10B981),
                  unselectedLabelColor: Colors.grey[600],
                  indicatorColor: const Color(0xFF10B981),
                  indicatorWeight: 3,
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                  ),
                  tabs: getSubCategories(_selectedCategoryIndex!)
                      .map((category) => Tab(text: category))
                      .toList(),
                ),
              ),

              // Products Grid
              Expanded(
                flex: 3,
                child: TabBarView(
                  controller: _tabController,
                  children: getSubCategories(_selectedCategoryIndex!).map((subCategory) {
                    final products = getProducts(
                      categories[_selectedCategoryIndex!]["name"],
                      subCategory,
                    );

                    return products.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox,
                            size: isDesktop ? 96 : (isTablet ? 80 : 64),
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: spacing),
                          Text(
                            "No products found",
                            style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontSize: isDesktop ? 20 : (isTablet ? 18 : 16),
                            ),
                          ),
                          SizedBox(height: spacing * 0.5),
                          Text(
                            "in $subCategory",
                            style: GoogleFonts.poppins(
                              color: Colors.grey[500],
                              fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                            ),
                          ),
                        ],
                      ),
                    )
                        : GridView.builder(
                      padding: EdgeInsets.all(spacing),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: productAspectRatio,
                        crossAxisSpacing: spacing,
                        mainAxisSpacing: spacing,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        // Calculate discount for some products
                        final discount = index % 3 == 0 ? 20.0 : null;
                        return ProductCard(
                          product: product,
                          discountPercentage: discount,
                          onAddToCart: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} added to cart'),
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
                    );
                  }).toList(),
                ),
              ),
            ] else ...[
              // Empty state when no category selected
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.category,
                        size: isDesktop ? 96 : (isTablet ? 80 : 64),
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: spacing),
                      Text(
                        "Select a category",
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 24 : (isTablet ? 22 : 18),
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: spacing * 0.5),
                      Text(
                        "Tap on any category to view products",
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Product Card Widget - Simplified version that matches your Product model
class ProductCard extends StatelessWidget {
  final Product product;
  final double? discountPercentage;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.discountPercentage,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive sizing
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    final hasDiscount = discountPercentage != null && discountPercentage! > 0;
    final originalPrice = hasDiscount
        ? product.price * 100 / (100 - discountPercentage!)
        : product.price;

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(isDesktop ? 20 : (isTablet ? 18 : 16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: isDesktop ? 16 : (isTablet ? 14 : 12),
              spreadRadius: 0,
              offset: Offset(0, isDesktop ? 6 : (isTablet ? 5 : 4)),
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
                  height: isDesktop ? 160 : (isTablet ? 145 : 130),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(isDesktop ? 20 : (isTablet ? 18 : 16)),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: isDesktop ? 100 : (isTablet ? 90 : 80),
                      height: isDesktop ? 100 : (isTablet ? 90 : 80),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        size: 36,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ),
                ),

                // Product Info
                Padding(
                  padding: EdgeInsets.all(isDesktop ? 16 : (isTablet ? 14 : 12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 15 : (isTablet ? 14 : 13),
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),

                      SizedBox(height: isDesktop ? 10 : (isTablet ? 8 : 6)),

                      // Price Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Price Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Current Price
                              Text(
                                'Rs ${_formatPrice(product.price)}',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop ? 18 : (isTablet ? 17 : 16),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF10B981),
                                ),
                              ),

                              // Original Price (if discounted)
                              if (hasDiscount)
                                Text(
                                  'Rs ${_formatPrice(originalPrice)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: isDesktop ? 13 : (isTablet ? 12 : 11),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),

                          // Add to Cart Button
                          GestureDetector(
                            onTap: onAddToCart,
                            child: Container(
                              width: isDesktop ? 40 : (isTablet ? 36 : 32),
                              height: isDesktop ? 40 : (isTablet ? 36 : 32),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981),
                                borderRadius: BorderRadius.circular(isDesktop ? 10 : (isTablet ? 9 : 8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF10B981).withOpacity(0.3),
                                    blurRadius: isDesktop ? 8 : (isTablet ? 7 : 6),
                                    offset: Offset(0, isDesktop ? 3 : (isTablet ? 2.5 : 2)),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.add,
                                size: isDesktop ? 22 : (isTablet ? 20 : 18),
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
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 12 : (isTablet ? 10 : 8),
                    vertical: isDesktop ? 6 : (isTablet ? 5 : 4),
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(isDesktop ? 14 : (isTablet ? 13 : 12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: isDesktop ? 10 : (isTablet ? 9 : 8),
                      ),
                    ],
                  ),
                  child: Text(
                    '${discountPercentage!.toInt()}% OFF',
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 12 : (isTablet ? 11 : 10),
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
    final priceString = price.toStringAsFixed(
      price.truncateToDouble() == price ? 0 : 2,
    );

    final parts = priceString.split('.');
    final wholePart = parts[0];

    final buffer = StringBuffer();
    for (int i = 0; i < wholePart.length; i++) {
      if (i > 0 && (wholePart.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(wholePart[i]);
    }

    if (parts.length > 1 && parts[1] != '00' && parts[1] != '0') {
      buffer.write('.${parts[1]}');
    }

    return buffer.toString();
  }
}