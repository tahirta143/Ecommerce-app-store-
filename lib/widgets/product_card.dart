import 'package:ecommerce_app/models/products_model/products_model.dart'; // CHANGED THIS IMPORT
import 'package:ecommerce_app/screens/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

class ProductCard extends StatefulWidget {
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Color? _dominantColor;
  bool _isLoadingColor = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _extractDominantColor();
  }

  @override
  void dispose() {
    _dominantColor = null;
    super.dispose();
  }

  Future<void> _extractDominantColor() async {
    if (!mounted) return;

    try {
      // Check if primaryImageUrl is valid (changed from imageUrl)
      if (widget.product.primaryImageUrl.isEmpty) {
        if (mounted) {
          setState(() {
            _hasError = true;
            _isLoadingColor = false;
            _dominantColor = Colors.grey.shade400;
          });
        }
        return;
      }

      // Load image from network (since all images are from Cloudinary)
      final imageProvider = NetworkImage(widget.product.primaryImageUrl);

      final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
        imageProvider,
        size: const Size(100, 100),
        maximumColorCount: 5,
      ).timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          throw TimeoutException('Image loading timed out');
        },
      );

      if (!mounted) return;

      // Get dominant color or use a fallback
      final dominantColor = paletteGenerator.dominantColor?.color ??
          (paletteGenerator.colors.isNotEmpty
              ? paletteGenerator.colors.first.color
              : null);

      setState(() {
        _dominantColor = dominantColor ?? Colors.grey.shade400;
        _isLoadingColor = false;
        _hasError = false;
      });
    } catch (e) {
      print('Error extracting dominant color: $e');
      if (mounted) {
        setState(() {
          _dominantColor = Colors.grey.shade400;
          _isLoadingColor = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasDiscount = widget.discountPercentage != null && widget.discountPercentage! > 0;
    final discountedPrice = hasDiscount
        ? widget.product.price * (1 - widget.discountPercentage! / 100)
        : null;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: widget.product,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!_isLoadingColor && _dominantColor != null && !_hasError) ...[
              BoxShadow(
                color: _dominantColor!.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 6),
                spreadRadius: -1,
              ),
            ],
            // Always show a subtle default shadow
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Discount Badge
              Expanded(
                flex: 6,
                child: Stack(
                  children: [
                    // Product Image
                    Container(
                      width: double.infinity,
                      color: Colors.grey[100],
                      child: _buildProductImage(),
                    ),

                    // Out of Stock Badge (if stock is 0)
                    if (!widget.product.inStock)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            'Out of Stock',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                    // Discount Badge
                    if (hasDiscount && widget.product.inStock)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF6366F1),
                                const Color(0xFF8B5CF6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6366F1).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            '${widget.discountPercentage!.toInt()}% OFF',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                    // Add to Cart Button (only show if in stock)
                    if (widget.product.inStock)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF6366F1),
                                const Color(0xFF8B5CF6),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6366F1).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: widget.onAddToCart,
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Product Details
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product Title
                      Text(
                        widget.product.title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Price and Stock Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!widget.product.inStock)
                            Text(
                              'Out of Stock',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          else if (hasDiscount) ...[
                            Row(
                              children: [
                                Text(
                                  '\$${widget.product.price.toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEEF2FF),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${widget.discountPercentage!.toInt()}%',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: const Color(0xFF6366F1),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '\$${discountedPrice!.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF6366F1),
                              ),
                            ),
                          ] else ...[
                            Text(
                              '\$${widget.product.price.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: widget.product.inStock
                                    ? const Color(0xFF1E293B)
                                    : Colors.grey,
                              ),
                            ),
                          ],

                          // Show stock count if low
                          if (widget.product.inStock && widget.product.stock < 10)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                'Only ${widget.product.stock} left',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    // If there's an error or no image, show a colored container with icon
    if (_hasError || widget.product.primaryImageUrl.isEmpty) {
      return Container(
        color: Colors.grey[200],
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey[400],
            size: 30,
          ),
        ),
      );
    }

    // Load image from network (Cloudinary URL)
    return Image.network(
      widget.product.primaryImageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[100],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
              color: const Color(0xFF6366F1),
              strokeWidth: 2,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[200],
          child: Center(
            child: Icon(
              Icons.broken_image_outlined,
              color: Colors.grey[400],
              size: 30,
            ),
          ),
        );
      },
    );
  }
}

extension on Color {
  get color => null;
}

// Remove this extension - it's not needed
// extension on Color {
//   get color => null;
// }

// Timeout exception class
class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}