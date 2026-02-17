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
            _dominantColor = Colors.grey.shade300;
          });
        }
        return;
      }

      final imageProvider = NetworkImage(widget.product.primaryImageUrl);
      final PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
        imageProvider,
        size: const Size(200, 200),
        maximumColorCount: 16,
      ).timeout(const Duration(seconds: 3), onTimeout: () => throw TimeoutException());

      if (!mounted) return;

      final Color? picked =
          palette.vibrantColor?.color ??
              palette.dominantColor?.color ??
              palette.mutedColor?.color ??
              (palette.colors.isNotEmpty ? palette.colors.first.color : Colors.grey.shade300);

      setState(() {
        _dominantColor = picked;
        _isLoadingColor = false;
        _hasError = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _dominantColor = Colors.grey.shade300;
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
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;
    final isLargeDesktop = size.width >= 1200;

    final hasDiscount = widget.discountPercentage != null && widget.discountPercentage! > 0;
    final discountedPrice = hasDiscount
        ? widget.product.price * (1 - widget.discountPercentage! / 100)
        : null;

    // Responsive font sizes (all as double)
    final titleFontSize = isLargeDesktop ? 16.0 : (isDesktop ? 15.0 : (isTablet ? 14.0 : 13.0));
    final priceFontSize = isLargeDesktop ? 18.0 : (isDesktop ? 17.0 : (isTablet ? 16.0 : 15.0));
    final oldPriceFontSize = isLargeDesktop ? 14.0 : (isDesktop ? 13.0 : (isTablet ? 12.0 : 11.0));
    final badgeFontSize = isLargeDesktop ? 12.0 : (isDesktop ? 11.0 : (isTablet ? 10.0 : 9.0));
    final stockFontSize = isLargeDesktop ? 11.0 : (isDesktop ? 10.0 : (isTablet ? 9.0 : 8.0));
    final cartButtonSize = isLargeDesktop ? 24.0 : (isDesktop ? 22.0 : (isTablet ? 20.0 : 18.0));

    // Responsive paddings (all as double)
    final contentPadding = isLargeDesktop ? 14.0 : (isDesktop ? 12.0 : (isTablet ? 10.0 : 8.0));
    final borderRadius = isLargeDesktop ? 20.0 : (isDesktop ? 18.0 : (isTablet ? 16.0 : 14.0));
    final badgeHorizontalPadding = isLargeDesktop ? 10.0 : 8.0;
    final badgeVerticalPadding = isLargeDesktop ? 6.0 : 4.0;
    final positionOffset = isLargeDesktop ? 12.0 : (isDesktop ? 10.0 : (isTablet ? 8.0 : 6.0));

    // Shadow values
    final shadowBlur = isLargeDesktop ? 16.0 : (isDesktop ? 14.0 : (isTablet ? 12.0 : 10.0));
    final shadowOffset = isLargeDesktop ? 6.0 : (isDesktop ? 5.0 : (isTablet ? 4.0 : 3.0));
    final badgeShadowBlur = isLargeDesktop ? 10.0 : 8.0;
    final badgeShadowOffset = isLargeDesktop ? 3.0 : 2.0;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailScreen(product: widget.product)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: shadowBlur,
              offset: Offset(0, shadowOffset),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE AREA
              Expanded(
                flex: 6,
                child: _buildImageArea(
                  hasDiscount,
                  positionOffset,
                  badgeHorizontalPadding,
                  badgeVerticalPadding,
                  badgeFontSize,
                  badgeShadowBlur,
                  badgeShadowOffset,
                ),
              ),

              // PRODUCT DETAILS
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(contentPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style: GoogleFonts.poppins(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      _buildPriceRow(
                        hasDiscount,
                        discountedPrice,
                        priceFontSize,
                        oldPriceFontSize,
                        badgeFontSize,
                        stockFontSize,
                        badgeHorizontalPadding,
                        badgeVerticalPadding,
                        cartButtonSize,
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

  Widget _buildImageArea(
      bool hasDiscount,
      double positionOffset,
      double badgeHorizontalPadding,
      double badgeVerticalPadding,
      double badgeFontSize,
      double badgeShadowBlur,
      double badgeShadowOffset,
      ) {
    final bgColor = _dominantColor ?? Colors.grey.shade200;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Dominant color background
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          color: _isLoadingColor ? Colors.grey.shade200 : bgColor,
        ),

        // Subtle gradient overlay
        if (!_isLoadingColor && _dominantColor != null)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.5, 1.0],
                  colors: [
                    Colors.transparent,
                    bgColor.withOpacity(0.55),
                  ],
                ),
              ),
            ),
          ),

        // Product image
        Positioned.fill(
          child: _buildProductImage(),
        ),

        // Out of Stock badge
        if (!widget.product.inStock)
          Positioned(
            top: positionOffset,
            left: positionOffset,
            child: _buildBadge(
              label: 'Out of Stock',
              colors: [Colors.red.shade600, Colors.red.shade400],
              shadowColor: Colors.red,
              fontSize: badgeFontSize,
              horizontalPadding: badgeHorizontalPadding,
              verticalPadding: badgeVerticalPadding,
              shadowBlur: badgeShadowBlur,
              shadowOffset: badgeShadowOffset,
            ),
          ),

        // Discount badge
        if (hasDiscount && widget.product.inStock)
          Positioned(
            top: positionOffset,
            left: positionOffset,
            child: _buildBadge(
              label: '${widget.discountPercentage!.toInt()}% OFF',
              colors: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              shadowColor: const Color(0xFF6366F1),
              fontSize: badgeFontSize,
              horizontalPadding: badgeHorizontalPadding,
              verticalPadding: badgeVerticalPadding,
              shadowBlur: badgeShadowBlur,
              shadowOffset: badgeShadowOffset,
            ),
          ),
      ],
    );
  }

  Widget _buildProductImage() {
    if (_hasError || widget.product.primaryImageUrl.isEmpty) {
      return Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Colors.white54,
          size: 32,
        ),
      );
    }

    return Image.network(
      widget.product.primaryImageUrl,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              color: Colors.white70,
              strokeWidth: 2.5,
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) => Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Colors.white54,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildPriceRow(
      bool hasDiscount,
      double? discountedPrice,
      double priceFontSize,
      double oldPriceFontSize,
      double badgeFontSize,
      double stockFontSize,
      double badgeHorizontalPadding,
      double badgeVerticalPadding,
      double cartButtonSize,
      ) {
    return Row(
      children: [
        // Price Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.product.inStock)
                Text(
                  'Out of Stock',
                  style: GoogleFonts.poppins(
                    fontSize: stockFontSize,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                )
              else if (hasDiscount) ...[
                Row(
                  children: [
                    Text(
                      '${widget.product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: oldPriceFontSize,
                        color: const Color(0xFF64748B),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: badgeHorizontalPadding * 0.8,
                        vertical: badgeVerticalPadding * 0.5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${widget.discountPercentage!.toInt()}%',
                        style: GoogleFonts.poppins(
                          fontSize: badgeFontSize * 0.9,
                          color: const Color(0xFF6366F1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${discountedPrice!.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: priceFontSize,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF6366F1),
                  ),
                ),
              ] else ...[
                Text(
                  '${widget.product.price.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: priceFontSize,
                    fontWeight: FontWeight.w700,
                    color: widget.product.inStock ? const Color(0xFF1E293B) : Colors.grey,
                  ),
                ),
              ],
              if (widget.product.inStock && widget.product.stock < 10)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Only ${widget.product.stock} left',
                    style: GoogleFonts.poppins(
                      fontSize: stockFontSize,
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Add to Cart Button
        if (widget.product.inStock)
          Container(
            margin: EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
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
                  padding: EdgeInsets.all(cartButtonSize * 0.4),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: cartButtonSize * 0.7,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBadge({
    required String label,
    required List<Color> colors,
    required Color shadowColor,
    required double fontSize,
    required double horizontalPadding,
    required double verticalPadding,
    required double shadowBlur,
    required double shadowOffset,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.35),
            blurRadius: shadowBlur,
            offset: Offset(0, shadowOffset),
          ),
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

extension on Color {
  Null get color => null;
}

// Custom Timeout Exception class
class TimeoutException implements Exception {}