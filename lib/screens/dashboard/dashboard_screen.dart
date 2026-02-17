import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/products_provider/products_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // ✅ Correct: delay fetch until after the first frame so the widget tree
    // is fully built before the provider calls notifyListeners().
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeProducts();
    });
  }

  Future<void> _initializeProducts() async {
    if (!mounted) return;
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    await productProvider.fetchProducts(refresh: true);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final productProvider =
      Provider.of<ProductProvider>(context, listen: false);
      if (!productProvider.isLoading &&
          productProvider.hasMorePages &&
          _searchController.text.isEmpty) {
        productProvider.fetchProducts();
      }
    }
  }

  Future<void> _onSearch(String query) async {
    final productProvider =
    Provider.of<ProductProvider>(context, listen: false);
    if (query.isEmpty) {
      setState(() => _isSearching = false);
      await productProvider.fetchProducts(refresh: true);
    } else {
      setState(() => _isSearching = true);
      await productProvider.searchProducts(query);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearch('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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
                  controller: _searchController,
                  onChanged: _onSearch,
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    prefixIcon:
                    const Icon(Icons.search_rounded, color: Colors.grey),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon:
                      const Icon(Icons.clear, color: Colors.grey),
                      onPressed: _clearSearch,
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                  ),
                ),
              ),

              SizedBox(height: isDesktop ? 32.0 : isTablet ? 24.0 : 20.0),

              // Title row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isSearching ? "Search Results" : "New Arrivals",
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 24.0 : isTablet ? 22.0 : 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  if (_isSearching)
                    TextButton(
                      onPressed: _clearSearch,
                      child: Text(
                        "Clear Search",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF6366F1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(height: isDesktop ? 24.0 : isTablet ? 20.0 : 16.0),

              // Products grid
              Expanded(
                child: Consumer<ProductProvider>(
                  builder: (context, productProvider, _) {
                    // Initial load
                    if (productProvider.isLoading &&
                        productProvider.products.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFF6366F1)),
                      );
                    }

                    // Error state
                    if (productProvider.errorMessage != null &&
                        productProvider.products.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 60, color: Colors.red[300]),
                            const SizedBox(height: 16),
                            Text(
                              productProvider.errorMessage!,
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  productProvider.fetchProducts(refresh: true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6366F1),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text('Try Again',
                                  style: GoogleFonts.poppins()),
                            ),
                          ],
                        ),
                      );
                    }

                    // Empty state
                    if (productProvider.products.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox_outlined,
                                size: 60, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              _isSearching
                                  ? "No products found for '${_searchController.text}'"
                                  : "No products available",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey[600]),
                            ),
                            if (_isSearching) ...[
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: _clearSearch,
                                child: Text('Clear Search',
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xFF6366F1))),
                              ),
                            ],
                          ],
                        ),
                      );
                    }

                    // Products grid
                    return GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 4 : isTablet ? 3 : 2,
                        childAspectRatio:
                        isDesktop ? 0.7 : isTablet ? 0.72 : 0.75,
                        crossAxisSpacing:
                        isDesktop ? 24.0 : isTablet ? 20.0 : 16.0,
                        mainAxisSpacing:
                        isDesktop ? 24.0 : isTablet ? 20.0 : 16.0,
                      ),
                      itemCount: productProvider.products.length,
                      itemBuilder: (context, index) {
                        final product = productProvider.products[index];
                        return ProductCard(
                          product: product,
                          discountPercentage: index % 3 == 0 ? 20.0 : null,
                          onAddToCart: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Added ${product.title} to cart',
                                    style: GoogleFonts.poppins()),
                                backgroundColor: const Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              // Pagination loading indicator
              Consumer<ProductProvider>(
                builder: (context, productProvider, _) {
                  if (productProvider.isLoading &&
                      productProvider.products.isNotEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFF6366F1))),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}