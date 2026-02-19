import 'package:ecommerce_app/models/products_model/products_model.dart';
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
      if (widget.product.primaryImageUrl.isEmpty) {
        if (mounted) {
          setState(() {
            _hasError = true;
            _isLoadingColor = false;
            _dominantColor = Colors.grey.shade100;
          });
        }
        return;
      }

      final imageProvider = NetworkImage(widget.product.primaryImageUrl);
      final PaletteGenerator palette =
          await PaletteGenerator.fromImageProvider(
            imageProvider,
            size: const Size(200, 200),
            maximumColorCount: 16,
          ).timeout(
            const Duration(seconds: 3),
            onTimeout: () => throw TimeoutException(),
          );

      if (!mounted) return;

      final Color? picked =
          palette.vibrantColor?.color ??
          palette.dominantColor?.color ??
          palette.mutedColor?.color ??
          (palette.colors.isNotEmpty
              ? palette.colors.first.color
              : Colors.grey.shade100);

      setState(() {
        _dominantColor = picked;
        _isLoadingColor = false;
        _hasError = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _dominantColor = Colors.grey.shade100;
          _isLoadingColor = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive sizing
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 900;
    final isLargeDesktop = screenWidth >= 1200;

    // Calculate card dimensions based on screen size - slightly reduced
    final cardHeight = isLargeDesktop
        ? 290.0
        : (isDesktop ? 260.0 : (isTablet ? 240.0 : 220.0));

    final imageHeight = cardHeight * 0.7; // 60% of card height for image
    final contentHeight = cardHeight * 0.3; // 40% of card height for content

    final hasDiscount =
        widget.discountPercentage != null && widget.discountPercentage! > 0;
    final discountedPrice = hasDiscount
        ? widget.product.price * (1 - widget.discountPercentage! / 100)
        : null;

    // Responsive font sizes - slightly reduced
    final titleFontSize = isLargeDesktop
        ? 14.0
        : (isDesktop ? 13.0 : (isTablet ? 12.0 : 11.0));

    final priceFontSize = isLargeDesktop
        ? 16.0
        : (isDesktop ? 15.0 : (isTablet ? 14.0 : 13.0));

    final oldPriceFontSize = isLargeDesktop
        ? 12.0
        : (isDesktop ? 11.0 : (isTablet ? 10.0 : 9.0));

    final smallFontSize = isLargeDesktop
        ? 10.0
        : (isDesktop ? 9.0 : (isTablet ? 8.0 : 7.0));

    // Responsive paddings - slightly reduced
    final contentPadding = isLargeDesktop
        ? 10.0
        : (isDesktop ? 8.0 : (isTablet ? 6.0 : 4.0));

    final borderRadius = isLargeDesktop
        ? 16.0
        : (isDesktop ? 14.0 : (isTablet ? 12.0 : 10.0));

    // Format price with PKR
    String formatPrice(double price) {
      return 'Rs. ${price.toStringAsFixed(0)}';
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: widget.product),
        ),
      ),
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // IMAGE AREA
              Container(
                height: imageHeight,
                color: _dominantColor?.withOpacity(0.2) ?? Colors.grey.shade50,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Product image
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(contentPadding * 1.5),
                        child: _buildProductImage(),
                      ),
                    ),

                    // Out of Stock overlay
                    if (!widget.product.inStock)
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: contentPadding * 1.5,
                              vertical: contentPadding * 0.6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Out of Stock',
                              style: GoogleFonts.poppins(
                                fontSize: smallFontSize,
                                fontWeight: FontWeight.w600,
                                color: Colors.red.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // PRODUCT DETAILS
              Container(
                height: contentHeight,
                padding: EdgeInsets.all(contentPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title and Price section
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Product title
                          Text(
                            widget.product.title,
                            style: GoogleFonts.poppins(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2D3436),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6),
                          // Price with zero spacing
                          if (hasDiscount) ...[
                            Wrap(
                              spacing: 2,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  formatPrice(discountedPrice!),
                                  style: GoogleFonts.poppins(
                                    fontSize: priceFontSize,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2D3436),
                                  ),
                                ),
                                Text(
                                  formatPrice(widget.product.price),
                                  style: GoogleFonts.poppins(
                                    fontSize: oldPriceFontSize,
                                    color: Colors.grey.shade400,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ] else ...[
                            Text(
                              formatPrice(widget.product.price),
                              style: GoogleFonts.poppins(
                                fontSize: priceFontSize,
                                fontWeight: FontWeight.w600,
                                color: widget.product.inStock
                                    ? const Color(0xFF2D3436)
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ],

                          // Low stock indicator - only if needed
                          if (widget.product.inStock &&
                              widget.product.stock < 10)
                            Text(
                              'Only ${widget.product.stock} left',
                              style: GoogleFonts.poppins(
                                fontSize: smallFontSize,
                                color: Colors.orange.shade400,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Add to cart button
                    if (widget.product.inStock)
                      Container(
                        width: 28,
                        height: 28,
                        margin: EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: widget.onAddToCart,
                            borderRadius: BorderRadius.circular(14),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.grey.shade700,
                                size: priceFontSize * 1.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    if (_hasError || widget.product.primaryImageUrl.isEmpty) {
      return Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey.shade400,
        size: 32,
      );
    }

    return Image.network(
      widget.product.primaryImageUrl,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              color: Colors.grey.shade400,
              strokeWidth: 2,
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) => Icon(
        Icons.broken_image_outlined,
        color: Colors.grey.shade400,
        size: 32,
      ),
    );
  }
}

extension on Color {
  Null get color => null;
}

class TimeoutException implements Exception {}
