import 'package:ecommerce_app/models/products_model/products_model.dart';
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
  List<String> _categories = ["All"];
  late String _selectedCategory;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  String _searchQuery = "";
  bool _isSearching = false;

  // ─── Theme ────────────────────────────────────────────────────────────────
  static const Color _primaryColor   = Color(0xFF6366F1);
  static const Color _secondaryColor = Color(0xFF8B5CF6);
  static const Color _surfaceColor   = Color(0xFFF8FAFC);
  static const Color _textPrimary    = Color(0xFF1E293B);
  static const Color _textSecondary  = Color(0xFF64748B);
  static const Color _white          = Color(0xFFFFFFFF);

  // ─── Lifecycle ────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.activeCategory;
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);

    // Fetch products after first frame so provider is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts(refresh: true);
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // ─── Scroll pagination ────────────────────────────────────────────────────
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final provider = context.read<ProductProvider>();
      if (!provider.isLoading && provider.hasMorePages) {
        provider.fetchProducts(); // load next page
      }
    }
  }

  // ─── Search ───────────────────────────────────────────────────────────────
  void _onSearchChanged() {
    setState(() => _searchQuery = _searchController.text);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _searchQuery = "");
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

  // ─── Category extraction ──────────────────────────────────────────────────
  /// Rebuilds the category list whenever the product list changes.
  /// Uses a Set comparison so it only calls setState when something actually
  /// changed (avoids infinite rebuild loops).
  void _syncCategories(List<Product> products) {
    if (products.isEmpty) return;

    final freshSet = <String>{};
    for (final p in products) {
      if (p.category.isNotEmpty) freshSet.add(p.category);
    }
    final freshList = ["All", ...freshSet.toList()..sort()];

    // Only rebuild if the list actually changed
    if (freshList.length != _categories.length ||
        !freshList.every(_categories.contains)) {
      // Use Future.microtask so we don't call setState during build
      Future.microtask(() {
        if (mounted) {
          setState(() {
            _categories = freshList;
            // If the previously selected category no longer exists, reset
            if (!_categories.contains(_selectedCategory)) {
              _selectedCategory = "All";
            }
          });
        }
      });
    }
  }

  // ─── Filtering ────────────────────────────────────────────────────────────
  List<Product> _getFilteredProducts(List<Product> allProducts) {
    var result = _selectedCategory == "All"
        ? allProducts
        : allProducts.where((p) => p.category == _selectedCategory).toList();

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result
          .where((p) =>
      p.title.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q))
          .toList();
    }
    return result;
  }

  // ─── Responsive helpers ───────────────────────────────────────────────────
  double _getTitleSize(Size s)            => s.width >= 1200 ? 36 : s.width >= 900 ? 32 : s.width >= 600 ? 30 : 28;
  double _getSubtitleSize(Size s)         => s.width >= 1200 ? 18 : s.width >= 900 ? 16 : s.width >= 600 ? 15 : 14;
  double _getCategoryChipFontSize(Size s) => s.width >= 1200 ? 16 : s.width >= 900 ? 15 : s.width >= 600 ? 14.5 : 14;
  double _getProductCountSize(Size s)     => s.width >= 1200 ? 16 : s.width >= 900 ? 15 : s.width >= 600 ? 14.5 : 14;
  double _getFilterIconSize(Size s)       => s.width >= 1200 ? 20 : s.width >= 900 ? 18 : s.width >= 600 ? 17 : 16;
  double _getFilterTextSize(Size s)       => s.width >= 1200 ? 14 : s.width >= 900 ? 13 : s.width >= 600 ? 12.5 : 12;
  double _getEmptyStateIconSize(Size s)   => s.width >= 1200 ? 120 : s.width >= 900 ? 100 : s.width >= 600 ? 90 : 80;
  double _getEmptyStateTitleSize(Size s)  => s.width >= 1200 ? 24 : s.width >= 900 ? 22 : s.width >= 600 ? 20 : 18;
  double _getEmptyStateTextSize(Size s)   => s.width >= 1200 ? 18 : s.width >= 900 ? 16 : s.width >= 600 ? 15 : 14;
  double _getButtonSize(Size s)           => s.width >= 1200 ? 56 : s.width >= 900 ? 52 : s.width >= 600 ? 48 : 44;
  double _getButtonFontSize(Size s)       => s.width >= 1200 ? 18 : s.width >= 900 ? 16 : s.width >= 600 ? 15 : 14;
  double _getSearchBarHeight(Size s)      => s.width >= 1200 ? 56 : s.width >= 900 ? 52 : s.width >= 600 ? 48 : 44;
  double _getSearchIconSize(Size s)       => s.width >= 1200 ? 28 : s.width >= 900 ? 26 : s.width >= 600 ? 24 : 22;
  double _getSearchButtonSize(Size s)     => s.width >= 1200 ? 56 : s.width >= 900 ? 52 : s.width >= 600 ? 48 : 44;
  double _getCategoryChipHeight(Size s)   => s.width >= 1200 ? 70 : s.width >= 900 ? 65 : s.width >= 600 ? 62 : 60;
  double _getCategoryChipPadding(Size s)  => s.width >= 1200 ? 24 : s.width >= 900 ? 22 : s.width >= 600 ? 20 : 16;
  double _getGridSpacing(Size s)          => s.width >= 1200 ? 24 : s.width >= 900 ? 20 : s.width >= 600 ? 18 : 16;
  int    _getGridCrossAxisCount(Size s)   => s.width >= 1200 ? 4 : s.width >= 900 ? 3 : 2;
  double _getGridChildAspectRatio(Size s) => s.width >= 1200 ? 0.68 : s.width >= 900 ? 0.7 : 0.72;
  EdgeInsets _getMainPadding(Size s)      => s.width >= 1200
      ? const EdgeInsets.fromLTRB(24, 24, 24, 12)
      : s.width >= 900
      ? const EdgeInsets.fromLTRB(20, 20, 20, 10)
      : s.width >= 600
      ? const EdgeInsets.fromLTRB(18, 18, 18, 9)
      : const EdgeInsets.fromLTRB(16, 16, 16, 8);

  // ─── Build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final titleSize            = _getTitleSize(size);
    final subtitleSize         = _getSubtitleSize(size);
    final categoryChipFontSize = _getCategoryChipFontSize(size);
    final productCountSize     = _getProductCountSize(size);
    final filterIconSize       = _getFilterIconSize(size);
    final filterTextSize       = _getFilterTextSize(size);
    final emptyStateIconSize   = _getEmptyStateIconSize(size);
    final emptyStateTitleSize  = _getEmptyStateTitleSize(size);
    final emptyStateTextSize   = _getEmptyStateTextSize(size);
    final buttonSize           = _getButtonSize(size);
    final buttonFontSize       = _getButtonFontSize(size);
    final searchBarHeight      = _getSearchBarHeight(size);
    final searchIconSize       = _getSearchIconSize(size);
    final searchButtonSize     = _getSearchButtonSize(size);
    final categoryChipHeight   = _getCategoryChipHeight(size);
    final categoryChipPadding  = _getCategoryChipPadding(size);
    final gridSpacing          = _getGridSpacing(size);
    final crossAxisCount       = _getGridCrossAxisCount(size);
    final childAspectRatio     = _getGridChildAspectRatio(size);
    final mainPadding          = _getMainPadding(size);

    return Scaffold(
      backgroundColor: _surfaceColor,
      body: SafeArea(
        child: Consumer<ProductProvider>(
          builder: (context, provider, _) {
            // Keep categories in sync with whatever the API returns
            _syncCategories(provider.products);

            final filteredProducts = _getFilteredProducts(provider.products);

            return Column(
              children: [
                // ── Header ──────────────────────────────────────────────────
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
                                  : "Results for '$_searchQuery'",
                              style: GoogleFonts.poppins(
                                fontSize: subtitleSize,
                                fontWeight: FontWeight.w400,
                                color: _textSecondary,
                              ),
                            ),
                          ],
                        ),

                      // Search bar (shown when _isSearching)
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
                                prefixIcon: Icon(Icons.search_rounded,
                                    color: _textSecondary,
                                    size: searchIconSize * 0.8),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                  icon: Icon(Icons.clear_rounded,
                                      color: _textSecondary,
                                      size: searchIconSize * 0.8),
                                  onPressed: _clearSearch,
                                )
                                    : null,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: size.width >= 1200 ? 16 : 12),
                              ),
                              style: GoogleFonts.poppins(
                                  fontSize: subtitleSize, color: _textPrimary),
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
                            _isSearching
                                ? Icons.close_rounded
                                : Icons.search_rounded,
                            color: _isSearching ? _white : _textSecondary,
                            size: searchIconSize,
                          ),
                          onPressed: _toggleSearch,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Category chips (hidden while searching) ──────────────────
                if (!_isSearching)
                  SizedBox(
                    height: categoryChipHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding:
                      EdgeInsets.symmetric(horizontal: mainPadding.left),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = category == _selectedCategory;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = category),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin:
                            EdgeInsets.only(right: gridSpacing * 0.6),
                            padding: EdgeInsets.symmetric(
                              horizontal: categoryChipPadding,
                              vertical: categoryChipPadding * 0.4,
                            ),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? LinearGradient(
                                colors: [
                                  _primaryColor,
                                  _secondaryColor
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : null,
                              color: isSelected ? null : _white,
                              borderRadius: BorderRadius.circular(
                                  size.width >= 1200 ? 30 : 25),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.grey[300]!,
                                width: 1,
                              ),
                              boxShadow: isSelected
                                  ? [
                                BoxShadow(
                                  color:
                                  _primaryColor.withOpacity(0.3),
                                  blurRadius:
                                  size.width >= 1200 ? 15 : 10,
                                  offset: Offset(
                                      0,
                                      size.width >= 1200 ? 5 : 3),
                                ),
                              ]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: GoogleFonts.poppins(
                                  color:
                                  isSelected ? _white : _textSecondary,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
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

                // ── Count & filter row ───────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mainPadding.left,
                    vertical: size.height * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.isLoading && provider.products.isEmpty
                            ? 'Loading products...'
                            : '${filteredProducts.length} ${filteredProducts.length == 1 ? 'Product' : 'Products'}',
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
                                color: Colors.grey[300]!, width: 1),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.tune_rounded,
                                  size: filterIconSize,
                                  color: _textSecondary),
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

                // ── Products grid ────────────────────────────────────────────
                Expanded(
                  child: _buildBody(
                    context: context,
                    provider: provider,
                    filteredProducts: filteredProducts,
                    size: size,
                    gridSpacing: gridSpacing,
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    emptyStateIconSize: emptyStateIconSize,
                    emptyStateTitleSize: emptyStateTitleSize,
                    emptyStateTextSize: emptyStateTextSize,
                    buttonSize: buttonSize,
                    buttonFontSize: buttonFontSize,
                  ),
                ),

                // ── Pagination loading indicator ─────────────────────────────
                if (provider.isLoading && provider.products.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: _primaryColor),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ── Body states ───────────────────────────────────────────────────────────
  Widget _buildBody({
    required BuildContext context,
    required ProductProvider provider,
    required List<Product> filteredProducts,
    required Size size,
    required double gridSpacing,
    required int crossAxisCount,
    required double childAspectRatio,
    required double emptyStateIconSize,
    required double emptyStateTitleSize,
    required double emptyStateTextSize,
    required double buttonSize,
    required double buttonFontSize,
  }) {
    // 1️⃣ Initial loading
    if (provider.isLoading && provider.products.isEmpty) {
      return Center(
        child: CircularProgressIndicator(color: _primaryColor),
      );
    }

    // 2️⃣ Error state
    if (provider.errorMessage != null && provider.products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: emptyStateIconSize, color: Colors.red[300]),
            SizedBox(height: size.height * 0.02),
            Text(
              'Error loading products',
              style: GoogleFonts.poppins(
                  fontSize: emptyStateTitleSize,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary),
            ),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gridSpacing * 2),
              child: Text(
                provider.errorMessage!,
                style: GoogleFonts.poppins(
                    fontSize: emptyStateTextSize, color: _textSecondary),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: gridSpacing),
            ElevatedButton(
              onPressed: () => provider.fetchProducts(refresh: true),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: _white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                minimumSize: Size(buttonSize * 1.5, buttonSize),
              ),
              child: Text('Try Again',
                  style: GoogleFonts.poppins(
                      fontSize: buttonFontSize,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      );
    }

    // 3️⃣ Empty filtered results
    if (filteredProducts.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(gridSpacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _searchQuery.isNotEmpty
                    ? Icons.search_off_rounded
                    : Icons.inbox_rounded,
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
                    color: _textPrimary),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                _searchQuery.isNotEmpty
                    ? "Try searching with different keywords"
                    : "Try selecting a different category",
                style: GoogleFonts.poppins(
                    fontSize: emptyStateTextSize, color: _textSecondary),
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
                          borderRadius: BorderRadius.circular(12)),
                      minimumSize: Size(buttonSize * 1.5, buttonSize),
                    ),
                    child: Text('Clear Search',
                        style: GoogleFonts.poppins(
                            fontSize: buttonFontSize,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    // 4️⃣ Grid with products
    return GridView.builder(
      controller: _scrollController, // ← enables scroll-to-load-more
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
                    borderRadius: BorderRadius.circular(10)),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}