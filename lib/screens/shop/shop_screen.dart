import 'package:ecommerce_app/models/products_model/products_model.dart'; // Use new model
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider/products_provider.dart';

class ShopScreen extends StatefulWidget {
  final String activeCategory;
  const ShopScreen({super.key, this.activeCategory = "All"});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<String> _categories = ["All"]; // Will be populated from API
  late String _selectedCategory;

  // Search functionality variables
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = "";
  bool _isSearching = false;

  // Single cohesive color theme - Professional Indigo/Purple mix
  static const Color _primaryColor = Color(0xFF6366F1); // Indigo
  static const Color _secondaryColor = Color(0xFF8B5CF6); // Purple accent
  static const Color _surfaceColor = Color(0xFFF8FAFC); // Light background
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _white = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.activeCategory;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = "";
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _clearSearch();
        _searchFocusNode.unfocus();
      } else {
        _searchFocusNode.requestFocus();
      }
    });
  }

  List<Product> _getFilteredProducts(List<Product> allProducts) {
    // First filter by category
    List<Product> categoryFiltered = _selectedCategory == "All"
        ? allProducts
        : allProducts
        .where((product) => product.category == _selectedCategory)
        .toList();

    // Then filter by search query
    if (_searchQuery.isEmpty) {
      return categoryFiltered;
    }

    return categoryFiltered
        .where((product) =>
    product.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        product.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        product.category.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // Update categories when products are loaded
  void _updateCategories(List<Product> products) {
    if (products.isNotEmpty) {
      final categorySet = <String>{};
      for (var product in products) {
        categorySet.add(product.category);
      }
      final newCategories = ["All", ...categorySet.toList()..sort()];
      if (_categories.length != newCategories.length) {
        setState(() {
          _categories = newCategories;
        });
      }
    }
  }

  // Responsive sizing methods (keeping all your existing responsive methods)
  double _getTitleSize(Size size) {
    if (size.width >= 1200) return 36;
    if (size.width >= 900) return 32;
    if (size.width >= 600) return 30;
    return 28;
  }

  double _getSubtitleSize(Size size) {
    if (size.width >= 1200) return 18;
    if (size.width >= 900) return 16;
    if (size.width >= 600) return 15;
    return 14;
  }

  double _getCategoryChipFontSize(Size size) {
    if (size.width >= 1200) return 16;
    if (size.width >= 900) return 15;
    if (size.width >= 600) return 14.5;
    return 14;
  }

  double _getProductCountSize(Size size) {
    if (size.width >= 1200) return 16;
    if (size.width >= 900) return 15;
    if (size.width >= 600) return 14.5;
    return 14;
  }

  double _getFilterIconSize(Size size) {
    if (size.width >= 1200) return 20;
    if (size.width >= 900) return 18;
    if (size.width >= 600) return 17;
    return 16;
  }

  double _getFilterTextSize(Size size) {
    if (size.width >= 1200) return 14;
    if (size.width >= 900) return 13;
    if (size.width >= 600) return 12.5;
    return 12;
  }

  double _getEmptyStateIconSize(Size size) {
    if (size.width >= 1200) return 120;
    if (size.width >= 900) return 100;
    if (size.width >= 600) return 90;
    return 80;
  }

  double _getEmptyStateTitleSize(Size size) {
    if (size.width >= 1200) return 24;
    if (size.width >= 900) return 22;
    if (size.width >= 600) return 20;
    return 18;
  }

  double _getEmptyStateTextSize(Size size) {
    if (size.width >= 1200) return 18;
    if (size.width >= 900) return 16;
    if (size.width >= 600) return 15;
    return 14;
  }

  double _getButtonSize(Size size) {
    if (size.width >= 1200) return 56;
    if (size.width >= 900) return 52;
    if (size.width >= 600) return 48;
    return 44;
  }

  double _getButtonFontSize(Size size) {
    if (size.width >= 1200) return 18;
    if (size.width >= 900) return 16;
    if (size.width >= 600) return 15;
    return 14;
  }

  double _getSearchBarHeight(Size size) {
    if (size.width >= 1200) return 56;
    if (size.width >= 900) return 52;
    if (size.width >= 600) return 48;
    return 44;
  }

  double _getSearchIconSize(Size size) {
    if (size.width >= 1200) return 28;
    if (size.width >= 900) return 26;
    if (size.width >= 600) return 24;
    return 22;
  }

  double _getSearchButtonSize(Size size) {
    if (size.width >= 1200) return 56;
    if (size.width >= 900) return 52;
    if (size.width >= 600) return 48;
    return 44;
  }

  double _getCategoryChipHeight(Size size) {
    if (size.width >= 1200) return 70;
    if (size.width >= 900) return 65;
    if (size.width >= 600) return 62;
    return 60;
  }

  double _getCategoryChipPadding(Size size) {
    if (size.width >= 1200) return 24;
    if (size.width >= 900) return 22;
    if (size.width >= 600) return 20;
    return 16;
  }

  double _getGridSpacing(Size size) {
    if (size.width >= 1200) return 24;
    if (size.width >= 900) return 20;
    if (size.width >= 600) return 18;
    return 16;
  }

  int _getGridCrossAxisCount(Size size) {
    if (size.width >= 1200) return 4;
    if (size.width >= 900) return 3;
    if (size.width >= 600) return 2;
    return 2;
  }

  double _getGridChildAspectRatio(Size size) {
    if (size.width >= 1200) return 0.68;
    if (size.width >= 900) return 0.7;
    if (size.width >= 600) return 0.72;
    return 0.72;
  }

  EdgeInsets _getMainPadding(Size size) {
    if (size.width >= 1200) {
      return const EdgeInsets.fromLTRB(24, 24, 24, 12);
    }
    if (size.width >= 900) {
      return const EdgeInsets.fromLTRB(20, 20, 20, 10);
    }
    if (size.width >= 600) {
      return const EdgeInsets.fromLTRB(18, 18, 18, 9);
    }
    return const EdgeInsets.fromLTRB(16, 16, 16, 8);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final titleSize = _getTitleSize(size);
    final subtitleSize = _getSubtitleSize(size);
    final categoryChipFontSize = _getCategoryChipFontSize(size);
    final productCountSize = _getProductCountSize(size);
    final filterIconSize = _getFilterIconSize(size);
    final filterTextSize = _getFilterTextSize(size);
    final emptyStateIconSize = _getEmptyStateIconSize(size);
    final emptyStateTitleSize = _getEmptyStateTitleSize(size);
    final emptyStateTextSize = _getEmptyStateTextSize(size);
    final buttonSize = _getButtonSize(size);
    final buttonFontSize = _getButtonFontSize(size);
    final searchBarHeight = _getSearchBarHeight(size);
    final searchIconSize = _getSearchIconSize(size);
    final searchButtonSize = _getSearchButtonSize(size);
    final categoryChipHeight = _getCategoryChipHeight(size);
    final categoryChipPadding = _getCategoryChipPadding(size);
    final gridSpacing = _getGridSpacing(size);
    final crossAxisCount = _getGridCrossAxisCount(size);
    final childAspectRatio = _getGridChildAspectRatio(size);
    final mainPadding = _getMainPadding(size);

    return Scaffold(
      backgroundColor: _surfaceColor,
      body: SafeArea(
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            // Update categories when products change
            if (productProvider.products.isNotEmpty) {
              _updateCategories(productProvider.products);
            }

            final filteredProducts = _getFilteredProducts(productProvider.products);

            return Column(
              children: [
                // Header with title and search
                Padding(
                  padding: mainPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!_isSearching)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shop",
                              style: GoogleFonts.poppins(
                                fontSize: titleSize,
                                fontWeight: FontWeight.w700,
                                color: _textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              _searchQuery.isEmpty
                                  ? "Discover amazing products"
                                  : "Search results for '$_searchQuery'",
                              style: GoogleFonts.poppins(
                                fontSize: subtitleSize,
                                fontWeight: FontWeight.w400,
                                color: _textSecondary,
                              ),
                            ),
                          ],
                        ),

                      // Search Bar
                      if (_isSearching)
                        Expanded(
                          child: Container(
                            height: searchBarHeight,
                            decoration: BoxDecoration(
                              color: _white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: size.width >= 1200 ? 15 : 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _searchController,
                              focusNode: _searchFocusNode,
                              decoration: InputDecoration(
                                hintText: "Search products...",
                                hintStyle: GoogleFonts.poppins(
                                  color: _textSecondary.withOpacity(0.5),
                                  fontSize: subtitleSize,
                                ),
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: _textSecondary,
                                  size: searchIconSize * 0.8,
                                ),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color: _textSecondary,
                                    size: searchIconSize * 0.8,
                                  ),
                                  onPressed: _clearSearch,
                                )
                                    : null,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: size.width >= 1200 ? 16 : 12),
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: subtitleSize,
                                color: _textPrimary,
                              ),
                            ),
                          ),
                        ),

                      SizedBox(width: size.width * 0.02),

                      // Search toggle button
                      Container(
                        width: searchButtonSize,
                        height: searchButtonSize,
                        decoration: BoxDecoration(
                          color: _isSearching ? _primaryColor : _white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: size.width >= 1200 ? 15 : 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            _isSearching ? Icons.close_rounded : Icons.search_rounded,
                            color: _isSearching ? _white : _textSecondary,
                            size: searchIconSize,
                          ),
                          onPressed: _toggleSearch,
                        ),
                      ),
                    ],
                  ),
                ),

                // Categories horizontal list (hide when searching)
                if (!_isSearching)
                  SizedBox(
                    height: categoryChipHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: mainPadding.left),
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
                            margin: EdgeInsets.only(right: gridSpacing * 0.6),
                            padding: EdgeInsets.symmetric(
                              horizontal: categoryChipPadding,
                              vertical: categoryChipPadding * 0.4,
                            ),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? LinearGradient(
                                colors: [
                                  _primaryColor,
                                  _secondaryColor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : null,
                              color: isSelected ? null : _white,
                              borderRadius: BorderRadius.circular(size.width >= 1200 ? 30 : 25),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.grey[300]!,
                                width: 1,
                              ),
                              boxShadow: isSelected
                                  ? [
                                BoxShadow(
                                  color: _primaryColor.withOpacity(0.3),
                                  blurRadius: size.width >= 1200 ? 15 : 10,
                                  offset: Offset(0, size.width >= 1200 ? 5 : 3),
                                ),
                              ]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: GoogleFonts.poppins(
                                  color: isSelected ? _white : _textSecondary,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                  fontSize: categoryChipFontSize,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                SizedBox(height: size.height * 0.01),

                // Products count and filter
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mainPadding.left,
                    vertical: size.height * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (productProvider.isLoading && productProvider.products.isEmpty)
                        Text(
                          'Loading products...',
                          style: GoogleFonts.poppins(
                            fontSize: productCountSize,
                            fontWeight: FontWeight.w500,
                            color: _textSecondary,
                          ),
                        )
                      else
                        Text(
                          '${filteredProducts.length} ${filteredProducts.length == 1 ? 'Product' : 'Products'}',
                          style: GoogleFonts.poppins(
                            fontSize: productCountSize,
                            fontWeight: FontWeight.w500,
                            color: _textSecondary,
                          ),
                        ),
                      if (!_isSearching)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: filterTextSize * 1.2,
                            vertical: filterTextSize * 0.6,
                          ),
                          decoration: BoxDecoration(
                            color: _white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.tune_rounded,
                                size: filterIconSize,
                                color: _textSecondary,
                              ),
                              SizedBox(width: size.width * 0.005),
                              Text(
                                'Filter',
                                style: GoogleFonts.poppins(
                                  fontSize: filterTextSize,
                                  fontWeight: FontWeight.w500,
                                  color: _textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // Products grid
                Expanded(
                  child: productProvider.isLoading && productProvider.products.isEmpty
                      ? Center(
                    child: CircularProgressIndicator(
                      color: _primaryColor,
                    ),
                  )
                      : productProvider.errorMessage != null && productProvider.products.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: emptyStateIconSize,
                          color: Colors.red[300],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Error loading products',
                          style: GoogleFonts.poppins(
                            fontSize: emptyStateTitleSize,
                            fontWeight: FontWeight.w600,
                            color: _textPrimary,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          productProvider.errorMessage!,
                          style: GoogleFonts.poppins(
                            fontSize: emptyStateTextSize,
                            color: _textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: gridSpacing),
                        ElevatedButton(
                          onPressed: () {
                            productProvider.fetchProducts(refresh: true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            foregroundColor: _white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: gridSpacing * 1.5,
                              vertical: gridSpacing * 0.8,
                            ),
                            minimumSize: Size(buttonSize * 1.5, buttonSize),
                          ),
                          child: Text(
                            'Try Again',
                            style: GoogleFonts.poppins(
                              fontSize: buttonFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : filteredProducts.isEmpty
                      ? Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(gridSpacing),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _searchQuery.isNotEmpty ? Icons.search_off_rounded : Icons.inbox_rounded,
                            size: emptyStateIconSize,
                            color: _textSecondary.withOpacity(0.3),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            _searchQuery.isNotEmpty
                                ? "No products found"
                                : "No products in this category",
                            style: GoogleFonts.poppins(
                              fontSize: emptyStateTitleSize,
                              fontWeight: FontWeight.w600,
                              color: _textPrimary,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            _searchQuery.isNotEmpty
                                ? "Try searching with different keywords"
                                : "Try selecting a different category",
                            style: GoogleFonts.poppins(
                              fontSize: emptyStateTextSize,
                              color: _textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (_searchQuery.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: gridSpacing),
                              child: ElevatedButton(
                                onPressed: _clearSearch,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _primaryColor,
                                  foregroundColor: _white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: gridSpacing * 1.5,
                                    vertical: gridSpacing * 0.8,
                                  ),
                                  minimumSize: Size(buttonSize * 1.5, buttonSize),
                                ),
                                child: Text(
                                  'Clear Search',
                                  style: GoogleFonts.poppins(
                                    fontSize: buttonFontSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                      : GridView.builder(
                    padding: EdgeInsets.all(gridSpacing),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: gridSpacing,
                      mainAxisSpacing: gridSpacing,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: filteredProducts[index],
                        discountPercentage: index % 3 == 0 ? 20 : null,
                        onAddToCart: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${filteredProducts[index].title} added to cart',
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
                  ),
                ),

                // Loading indicator for pagination
                if (productProvider.isLoading && productProvider.products.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6366F1),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}