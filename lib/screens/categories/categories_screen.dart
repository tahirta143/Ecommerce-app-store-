import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/product_detail/product_detail_screen.dart';
import 'package:ecommerce_app/screens/shop/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/product_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin {

  // Single cohesive color theme - Professional Indigo/Purple mix
  static const Color _primaryColor = Color(0xFF6366F1); // Indigo
  static const Color _secondaryColor = Color(0xFF8B5CF6); // Purple accent
  static const Color _surfaceColor = Color(0xFFF8FAFC); // Light background
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _accentLight = Color(0xFFEEF2FF); // Light indigo for backgrounds

  final List<Map<String, dynamic>> categories = const [
    {"name": "Electronics", "icon": Icons.electrical_services, "count": 245},
    {"name": "Fashion", "icon": Icons.checkroom, "count": 189},
    {"name": "Home", "icon": Icons.home, "count": 156},
    {"name": "Beauty", "icon": Icons.face, "count": 134},
    {"name": "Sports", "icon": Icons.sports_soccer, "count": 98},
    {"name": "Toys", "icon": Icons.toys, "count": 87},
    {"name": "Books", "icon": Icons.menu_book, "count": 112},
    {"name": "Automotive", "icon": Icons.directions_car, "count": 76},
    {"name": "Grocery", "icon": Icons.shopping_cart, "count": 203},
    {"name": "Health", "icon": Icons.health_and_safety, "count": 145},
  ];

  int? _selectedCategoryIndex;
  String? _selectedSubCategory;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Subcategories based on main category
  List<String> getSubCategories(int index) {
    switch(categories[index]["name"]) {
      case "Electronics":
        return ["All", "Phones", "Laptops", "Accessories", "Audio", "Wearables"];
      case "Fashion":
        return ["All", "Men", "Women", "Kids", "Footwear", "Accessories"];
      case "Home":
        return ["All", "Furniture", "Decor", "Kitchen", "Bedding", "Storage"];
      case "Beauty":
        return ["All", "Makeup", "Skincare", "Haircare", "Fragrance", "Tools"];
      case "Sports":
        return ["All", "Gym", "Outdoor", "Athletic", "Cycling", "Swimming"];
      case "Toys":
        return ["All", "Action Figures", "Dolls", "Games", "Educational", "Outdoor"];
      case "Books":
        return ["All", "Fiction", "Non-Fiction", "Children", "Academic", "Comics"];
      case "Automotive":
        return ["All", "Parts", "Accessories", "Tools", "Car Care", "Electronics"];
      case "Grocery":
        return ["All", "Fruits", "Vegetables", "Dairy", "Snacks", "Beverages"];
      case "Health":
        return ["All", "Vitamins", "Personal Care", "Medical", "Fitness", "Wellness"];
      default:
        return ["All", "Featured", "New", "Popular", "Sale", "Limited"];
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(int index) {
    setState(() {
      if (_selectedCategoryIndex == index) {
        _selectedCategoryIndex = null;
        _selectedSubCategory = null;
      } else {
        _selectedCategoryIndex = index;
        _selectedSubCategory = "All";
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  void _selectSubCategory(String subCategory) {
    setState(() {
      _selectedSubCategory = subCategory;
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive sizing
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;
    final isLargeDesktop = size.width >= 1200;
    final padding = MediaQuery.of(context).padding;
    final screenHeight = size.height - padding.top - padding.bottom;
    final screenWidth = size.width;

    // Responsive grid settings
    final crossAxisCount = isLargeDesktop ? 5 : (isDesktop ? 4 : (isTablet ? 3 : 2));
    final productAspectRatio = isLargeDesktop ? 0.85 : (isDesktop ? 0.8 : (isTablet ? 0.75 : 0.7));
    final spacing = isDesktop ? 20.0 : (isTablet ? 18.0 : 16.0);
    final fontSize = isDesktop ? 16.0 : (isTablet ? 15.0 : 14.0);

    return Scaffold(
      backgroundColor: _surfaceColor,
      appBar: AppBar(
        title: Text(
          "Categories",
          style: GoogleFonts.poppins(
            color: _textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: isDesktop ? 24 : (isTablet ? 22 : 20),
          ),
        ),
        backgroundColor: _white,
        elevation: 0,
        iconTheme: IconThemeData(color: _textPrimary),
        toolbarHeight: isDesktop ? 80 : (isTablet ? 70 : 56),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[200],
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Horizontal Scrollable Categories Row
            Container(
              height: isDesktop ? 140 : (isTablet ? 130 : 120),
              color: _white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: spacing,
                  vertical: spacing * 0.5,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () => _selectCategory(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: isDesktop ? 120 : (isTablet ? 110 : 100),
                      margin: EdgeInsets.only(right: spacing * 0.75),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [_primaryColor, _secondaryColor],
                        )
                            : null,
                        color: isSelected ? null : _white,
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected
                            ? null
                            : Border.all(color: Colors.grey[200]!, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? _primaryColor.withOpacity(0.3)
                                : Colors.grey.withOpacity(0.1),
                            blurRadius: isSelected ? 12 : 8,
                            offset: Offset(0, isSelected ? 4 : 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Category Icon
                          Container(
                            padding: EdgeInsets.all(isDesktop ? 16 : (isTablet ? 14 : 12)),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? _white.withOpacity(0.2)
                                  : _accentLight,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              categories[index]["icon"],
                              size: isDesktop ? 32 : (isTablet ? 28 : 24),
                              color: isSelected
                                  ? _white
                                  : _primaryColor,
                            ),
                          ),
                          SizedBox(height: spacing * 0.5),
                          // Category Name
                          Text(
                            categories[index]["name"],
                            style: GoogleFonts.poppins(
                              fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? _white : _textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Product count
                          Text(
                            "${categories[index]["count"]} items",
                            style: GoogleFonts.poppins(
                              fontSize: isDesktop ? 10 : (isTablet ? 9 : 8),
                              color: isSelected ? _white.withOpacity(0.8) : _textSecondary,
                            ),
                          ),
                          if (isSelected) ...[
                            SizedBox(height: spacing * 0.25),
                            Container(
                              width: 30,
                              height: 3,
                              decoration: BoxDecoration(
                                color: _white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Selected Category Content
            if (_selectedCategoryIndex != null) ...[
              // Category Header with Stats
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: spacing,
                  vertical: spacing * 0.75,
                ),
                decoration: BoxDecoration(
                  color: _white,
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!),
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(isDesktop ? 12 : (isTablet ? 10 : 8)),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_primaryColor, _secondaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        categories[_selectedCategoryIndex!]["icon"],
                        size: isDesktop ? 24 : (isTablet ? 22 : 20),
                        color: _white,
                      ),
                    ),
                    SizedBox(width: spacing * 0.75),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categories[_selectedCategoryIndex!]["name"],
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop ? 20 : (isTablet ? 18 : 16),
                            fontWeight: FontWeight.w600,
                            color: _textPrimary,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _accentLight,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${getSubCategories(_selectedCategoryIndex!).length} subcategories',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop ? 12 : (isTablet ? 11 : 10),
                                  color: _primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _accentLight,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${categories[_selectedCategoryIndex!]["count"]} items',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop ? 12 : (isTablet ? 11 : 10),
                                  color: _secondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: _surfaceColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedCategoryIndex = null;
                            _selectedSubCategory = null;
                          });
                        },
                        icon: const Icon(Icons.close, size: 20),
                        color: _textSecondary,
                        style: IconButton.styleFrom(
                          backgroundColor: _white,
                          padding: EdgeInsets.all(isDesktop ? 12 : (isTablet ? 10 : 8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Horizontal Scrollable Subcategory Chips
              Container(
                height: isDesktop ? 70 : (isTablet ? 65 : 60),
                color: _white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing,
                    vertical: spacing * 0.5,
                  ),
                  itemCount: getSubCategories(_selectedCategoryIndex!).length,
                  itemBuilder: (context, index) {
                    final subCategory = getSubCategories(_selectedCategoryIndex!)[index];
                    final isSelected = _selectedSubCategory == subCategory;

                    return GestureDetector(
                      onTap: () => _selectSubCategory(subCategory),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.only(right: spacing * 0.75),
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 24 : (isTablet ? 20 : 16),
                          vertical: isDesktop ? 12 : (isTablet ? 10 : 8),
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [_primaryColor, _secondaryColor],
                          )
                              : null,
                          color: isSelected ? null : _white,
                          borderRadius: BorderRadius.circular(30),
                          border: isSelected
                              ? null
                              : Border.all(color: Colors.grey[300]!, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? _primaryColor.withOpacity(0.3)
                                  : Colors.grey.withOpacity(0.1),
                              blurRadius: isSelected ? 8 : 4,
                              offset: Offset(0, isSelected ? 2 : 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getSubCategoryIcon(subCategory),
                              size: isDesktop ? 18 : (isTablet ? 16 : 14),
                              color: isSelected ? _white : _primaryColor,
                            ),
                            SizedBox(width: spacing * 0.4),
                            Text(
                              subCategory,
                              style: GoogleFonts.poppins(
                                fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected ? _white : _textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Products Grid with Animation
              Expanded(
                child: _selectedSubCategory == null
                    ? Center(
                  child: CircularProgressIndicator(
                    color: _primaryColor,
                    strokeWidth: 2,
                  ),
                )
                    : FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildProductsGrid(
                    categories[_selectedCategoryIndex!]["name"],
                    _selectedSubCategory!,
                    crossAxisCount,
                    productAspectRatio,
                    spacing,
                    isDesktop,
                    isTablet,
                    isLargeDesktop,
                  ),
                ),
              ),
            ] else ...[
              // Enhanced empty state with featured categories
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spacing * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(isDesktop ? 40 : (isTablet ? 35 : 30)),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [_primaryColor.withOpacity(0.1), _secondaryColor.withOpacity(0.1)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.category_outlined,
                            size: isDesktop ? 80 : (isTablet ? 70 : 60),
                            color: _primaryColor,
                          ),
                        ),
                        SizedBox(height: spacing * 2),
                        Text(
                          "Browse Categories",
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop ? 32 : (isTablet ? 28 : 24),
                            fontWeight: FontWeight.w700,
                            color: _textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: spacing * 0.75),
                        Text(
                          "Select a category to explore amazing products",
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                            color: _textSecondary,
                          ),
                        ),
                        SizedBox(height: spacing * 3),

                        // Popular Categories Preview
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spacing),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Popular Categories",
                                    style: GoogleFonts.poppins(
                                      fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                                      fontWeight: FontWeight.w600,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "View All",
                                      style: GoogleFonts.poppins(
                                        color: _primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spacing),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isDesktop ? 6 : (isTablet ? 4 : 3),
                                  childAspectRatio: 0.9,
                                  crossAxisSpacing: spacing * 0.75,
                                  mainAxisSpacing: spacing * 0.75,
                                ),
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => _selectCategory(index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.grey[200]!),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(isDesktop ? 16 : (isTablet ? 14 : 12)),
                                            decoration: BoxDecoration(
                                              color: _accentLight,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              categories[index]["icon"],
                                              size: isDesktop ? 28 : (isTablet ? 24 : 20),
                                              color: _primaryColor,
                                            ),
                                          ),
                                          SizedBox(height: spacing * 0.5),
                                          Text(
                                            categories[index]["name"],
                                            style: GoogleFonts.poppins(
                                              fontSize: isDesktop ? 13 : (isTablet ? 12 : 11),
                                              fontWeight: FontWeight.w500,
                                              color: _textPrimary,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper method to build products grid
  Widget _buildProductsGrid(
      String categoryName,
      String subCategory,
      int crossAxisCount,
      double productAspectRatio,
      double spacing,
      bool isDesktop,
      bool isTablet,
      bool isLargeDesktop,
      ) {
    // Sample products - replace with your actual product data
    List<Product> products = List.generate(8, (index) {
      return Product(
        id: "$categoryName-$subCategory-$index",
        title: "$categoryName ${subCategory == "All" ? "Product" : subCategory} ${index + 1}",
        price: (index + 1) * 29.99,
        description: "This is a sample product description for $categoryName in $subCategory category.",
        category: categoryName,
        imageUrl: "assets/images/product_placeholder.png",
        image: '',
      );
    });

    return products.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(isDesktop ? 40 : (isTablet ? 35 : 30)),
            decoration: BoxDecoration(
              color: _accentLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inbox_outlined,
              size: isDesktop ? 80 : (isTablet ? 70 : 60),
              color: _primaryColor.withOpacity(0.5),
            ),
          ),
          SizedBox(height: spacing),
          Text(
            "No products found",
            style: GoogleFonts.poppins(
              color: _textPrimary,
              fontSize: isDesktop ? 20 : (isTablet ? 18 : 16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spacing * 0.5),
          Text(
            "in $subCategory",
            style: GoogleFonts.poppins(
              color: _textSecondary,
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
        final discount = index % 3 == 0 ? 20.0 : (index % 5 == 0 ? 15.0 : null);
        return ProductCard(
          product: product,
          discountPercentage: discount,
          onAddToCart: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${product.title} added to cart',
                  style: GoogleFonts.poppins(),
                ),
                backgroundColor: _primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }

  // Helper method to get icon for subcategory
  IconData _getSubCategoryIcon(String subCategory) {
    switch (subCategory.toLowerCase()) {
      case "all":
        return Icons.grid_view_rounded;
      case "men":
        return Icons.man;
      case "women":
        return Icons.woman;
      case "kids":
        return Icons.child_care;
      case "phones":
        return Icons.phone_android;
      case "laptops":
        return Icons.laptop;
      case "accessories":
        return Icons.headphones;
      case "audio":
        return Icons.audio_file;
      case "wearables":
        return Icons.watch;
      case "furniture":
        return Icons.chair;
      case "decor":
        return Icons.home_repair_service;
      case "kitchen":
        return Icons.kitchen;
      case "bedding":
        return Icons.bed;
      case "makeup":
        return Icons.brush;
      case "skincare":
        return Icons.face_retouching_natural;
      case "haircare":
        return Icons.content_cut;
      case "fragrance":
        return Icons.local_florist;
      case "gym":
        return Icons.fitness_center;
      case "outdoor":
        return Icons.hiking;
      case "athletic":
        return Icons.directions_run;
      case "cycling":
        return Icons.directions_bike;
      case "swimming":
        return Icons.pool;
      case "action figures":
        return Icons.toys;
      case "games":
        return Icons.sports_esports;
      case "educational":
        return Icons.school;
      case "fiction":
        return Icons.menu_book;
      case "non-fiction":
        return Icons.library_books;
      case "academic":
        return Icons.school;
      case "comics":
        return Icons.auto_stories;
      case "parts":
        return Icons.build;
      case "tools":
        return Icons.handyman;
      case "car care":
        return Icons.local_car_wash;
      case "fruits":
        return Icons.apple;
      case "vegetables":
        return Icons.eco;
      case "dairy":
        return Icons.egg;
      case "snacks":
        return Icons.cookie;
      case "beverages":
        return Icons.local_drink;
      case "vitamins":
        return Icons.medication;
      case "personal care":
        return Icons.spa;
      case "medical":
        return Icons.medical_services;
      case "fitness":
        return Icons.fitness_center;
      case "wellness":
        return Icons.self_improvement;
      default:
        return Icons.label;
    }
  }
}