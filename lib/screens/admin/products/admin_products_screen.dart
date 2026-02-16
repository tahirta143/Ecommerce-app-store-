
import 'package:ecommerce_app/screens/admin/products/add_edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/products_provider/products_provider.dart';

class AdminProductsScreen extends StatelessWidget {
  const AdminProductsScreen({super.key});

  // Color theme
  static const Color _primaryColor = Color(0xFF6366F1); // Indigo
  static const Color _secondaryColor = Color(0xFF8B5CF6); // Purple accent
  static const Color _surfaceColor = Color(0xFFF8FAFC); // Light background
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _errorColor = Color(0xFFEF4444);
  static const Color _successColor = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    return Scaffold(
      backgroundColor: _surfaceColor,
      appBar: AppBar(
        title: Text(
          "Manage Products",
          style: GoogleFonts.poppins(
            color: _white,
            fontWeight: FontWeight.w600,
            fontSize: isDesktop ? 24 : (isTablet ? 22 : 20),
          ),
        ),
        backgroundColor: _primaryColor,
        foregroundColor: _white,
        elevation: 0,
        centerTitle: false,
        actions: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              // Implement search functionality
            },
          ),
          // Filter button
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              // Implement filter functionality
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditProductScreen()),
          );
        },
        backgroundColor: _primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          "Add Product",
          style: GoogleFonts.poppins(
            color: _white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final products = productProvider.products;

          if (productProvider.isLoading && products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: _primaryColor,
              ),
            );
          }

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.inventory_2_outlined,
                      size: isDesktop ? 80 : (isTablet ? 70 : 60),
                      color: _primaryColor.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "No Products Yet",
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 24 : (isTablet ? 22 : 20),
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Click the + button to add your first product",
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                      color: _textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          // Stats cards
          return Column(
            children: [
              // Stats Section
              Container(
                padding: EdgeInsets.all(isDesktop ? 24 : (isTablet ? 20 : 16)),
                child: Row(
                  children: [
                    _buildStatCard(
                      title: "Total Products",
                      value: products.length.toString(),
                      icon: Icons.inventory,
                      color: _primaryColor,
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      title: "In Stock",
                      value: products.where((p) => p.stock > 0).length.toString(),
                      icon: Icons.check_circle,
                      color: _successColor,
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      title: "Out of Stock",
                      value: products.where((p) => p.stock == 0).length.toString(),
                      icon: Icons.warning,
                      color: _errorColor,
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                    ),
                  ],
                ),
              ),

              // Products List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(isDesktop ? 24 : (isTablet ? 20 : 16)),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _buildProductCard(
                      context,
                      product,
                      index,
                      isDesktop,
                      isTablet,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDesktop,
    required bool isTablet,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(isDesktop ? 20 : (isTablet ? 16 : 12)),
        decoration: BoxDecoration(
          color: _white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: isDesktop ? 24 : (isTablet ? 22 : 20),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 28 : (isTablet ? 24 : 22),
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                color: _textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
      BuildContext context,
      dynamic product,
      int index,
      bool isDesktop,
      bool isTablet,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: isDesktop ? 16 : 12),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to product details
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 16 : 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  width: isDesktop ? 100 : (isTablet ? 90 : 80),
                  height: isDesktop ? 100 : (isTablet ? 90 : 80),
                  decoration: BoxDecoration(
                    color: _surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: product.primaryImageUrl.isNotEmpty
                        ? Image.network(
                      product.primaryImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: _surfaceColor,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey[400],
                            size: 30,
                          ),
                        );
                      },
                    )
                        : Container(
                      color: _surfaceColor,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey[400],
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Stock Badge
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.title,
                              style: GoogleFonts.poppins(
                                fontSize: isDesktop ? 18 : (isTablet ? 16 : 15),
                                fontWeight: FontWeight.w600,
                                color: _textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: product.stock > 0
                                  ? _successColor.withOpacity(0.1)
                                  : _errorColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              product.stock > 0 ? 'In Stock' : 'Out of Stock',
                              style: GoogleFonts.poppins(
                                fontSize: isDesktop ? 12 : 11,
                                color: product.stock > 0
                                    ? _successColor
                                    : _errorColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Category
                      Text(
                        product.category,
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                          color: _textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Price and Stock Info
                      Row(
                        children: [
                          Text(
                            "\$${product.price.toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              fontSize: isDesktop ? 22 : (isTablet ? 20 : 18),
                              fontWeight: FontWeight.w700,
                              color: _primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (product.stock > 0 && product.stock < 10)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Only ${product.stock} left',
                                style: GoogleFonts.poppins(
                                  fontSize: isDesktop ? 12 : 11,
                                  color: Colors.orange[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit_rounded,
                          color: _primaryColor,
                          size: isDesktop ? 22 : 20,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditProductScreen(product: product),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: _errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete_rounded,
                          color: _errorColor,
                          size: isDesktop ? 22 : 20,
                        ),
                        onPressed: () => _showDeleteDialog(context, product),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, dynamic product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: _errorColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Delete Product',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${product.title}"? This action cannot be undone.',
          style: GoogleFonts.poppins(
            color: _textSecondary,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: _textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Delete product
              // Provider.of<ProductProvider>(context, listen: false).deleteProduct(product.id);
              // Navigator.pop(context);

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Product deleted successfully!',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: _errorColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _errorColor,
              foregroundColor: _white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}