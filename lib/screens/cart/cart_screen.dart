import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Move CartItem outside the CartScreen class
class CartItem {
  final String id;
  final String title;
  final double price;
  final String? image;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    this.image,
    this.quantity = 1,
  });
}

class CartScreen extends StatelessWidget {
   CartScreen({super.key});

  // Single cohesive color theme - Professional Indigo/Purple mix
  static const Color _primaryColor = Color(0xFF6366F1); // Indigo
  static const Color _secondaryColor = Color(0xFF8B5CF6); // Purple accent
  static const Color _surfaceColor = Color(0xFFF8FAFC); // Light background
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _accentLight = Color(0xFFEEF2FF); // Light indigo for backgrounds
  static const Color _successColor = Color(0xFF10B981); // Green for success states

  // Sample cart data for UI demonstration
  final List<CartItem> _cartItems = [
    CartItem(
      id: '1',
      title: 'Modern Dresses for Girls',
      price: 2500,
      quantity: 2,
    ),
    CartItem(
      id: '2',
      title: 'Beauty Products for Women',
      price: 2000,
      quantity: 1,
    ),
    CartItem(
      id: '3',
      title: 'iPhone 14 Pro',
      price: 20455,
      quantity: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive sizing
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;
    final isLargeDesktop = size.width >= 1200;

    return Scaffold(
      backgroundColor: _surfaceColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: _white,
            size: isDesktop ? 24 : (isTablet ? 22 : 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Cart",
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
          if (_cartItems.isNotEmpty)
            TextButton.icon(
              onPressed: () => _showClearCartDialog(context),
              icon: Icon(
                Icons.delete_outline,
                size: isDesktop ? 22 : (isTablet ? 20 : 18),
                color: _white,
              ),
              label: Text(
                "Clear",
                style: GoogleFonts.poppins(
                  color: _white,
                  fontWeight: FontWeight.w500,
                  fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                ),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _cartItems.isEmpty
                ? _buildEmptyCart(context, isDesktop, isTablet, isLargeDesktop)
                : _buildCartItems(context, isDesktop, isTablet, isLargeDesktop),
          ),
          if (_cartItems.isNotEmpty)
            _buildCheckoutSection(context, isDesktop, isTablet, isLargeDesktop),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(
      BuildContext context,
      bool isDesktop,
      bool isTablet,
      bool isLargeDesktop,
      ) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(isLargeDesktop ? 32 : (isDesktop ? 28 : (isTablet ? 24 : 20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated empty cart illustration
            Container(
              width: isLargeDesktop ? 240 : (isDesktop ? 200 : (isTablet ? 180 : 160)),
              height: isLargeDesktop ? 240 : (isDesktop ? 200 : (isTablet ? 180 : 160)),
              decoration: BoxDecoration(
                color: _accentLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: isLargeDesktop ? 120 : (isDesktop ? 100 : (isTablet ? 90 : 80)),
                color: _primaryColor.withOpacity(0.5),
              ),
            ),
            SizedBox(height: isLargeDesktop ? 40 : (isDesktop ? 32 : (isTablet ? 28 : 24))),
            Text(
              "Your cart is empty",
              style: GoogleFonts.poppins(
                fontSize: isLargeDesktop ? 32 : (isDesktop ? 28 : (isTablet ? 26 : 24)),
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: isLargeDesktop ? 20 : (isDesktop ? 16 : (isTablet ? 14 : 12))),
            Text(
              "Looks like you haven't added anything to your cart yet",
              style: GoogleFonts.poppins(
                fontSize: isLargeDesktop ? 20 : (isDesktop ? 18 : (isTablet ? 16 : 14)),
                color: _textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isLargeDesktop ? 40 : (isDesktop ? 32 : (isTablet ? 28 : 24))),
            SizedBox(
              width: isLargeDesktop ? 350 : (isDesktop ? 300 : (isTablet ? 280 : 250)),
              height: isLargeDesktop ? 70 : (isDesktop ? 60 : (isTablet ? 56 : 52)),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: _white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isLargeDesktop ? 24 : (isDesktop ? 20 : (isTablet ? 18 : 16))),
                  ),
                ),
                child: Text(
                  "Start Shopping",
                  style: GoogleFonts.poppins(
                    fontSize: isLargeDesktop ? 22 : (isDesktop ? 20 : (isTablet ? 18 : 16)),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItems(
      BuildContext context,
      bool isDesktop,
      bool isTablet,
      bool isLargeDesktop,
      ) {
    return Container(
      padding: EdgeInsets.all(isLargeDesktop ? 24 : (isDesktop ? 20 : (isTablet ? 18 : 16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cart summary header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cart Items",
                style: GoogleFonts.poppins(
                  fontSize: isLargeDesktop ? 24 : (isDesktop ? 20 : (isTablet ? 18 : 16)),
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isLargeDesktop ? 16 : (isDesktop ? 12 : (isTablet ? 10 : 8)),
                  vertical: isLargeDesktop ? 8 : (isDesktop ? 6 : (isTablet ? 5 : 4)),
                ),
                decoration: BoxDecoration(
                  color: _accentLight,
                  borderRadius: BorderRadius.circular(isLargeDesktop ? 24 : (isDesktop ? 20 : (isTablet ? 18 : 16))),
                ),
                child: Text(
                  "${_cartItems.length} ${_cartItems.length == 1 ? 'item' : 'items'}",
                  style: GoogleFonts.poppins(
                    color: _primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: isLargeDesktop ? 18 : (isDesktop ? 16 : (isTablet ? 15 : 14)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isLargeDesktop ? 24 : (isDesktop ? 16 : (isTablet ? 14 : 12))),

          // Cart items list
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final cartItem = _cartItems[index];
                return _buildCartItemCard(
                  context,
                  cartItem,
                  index,
                  isDesktop,
                  isTablet,
                  isLargeDesktop,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(
      BuildContext context,
      CartItem cartItem,
      int index,
      bool isDesktop,
      bool isTablet,
      bool isLargeDesktop,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: isLargeDesktop ? 20 : (isDesktop ? 16 : (isTablet ? 14 : 12))),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(isLargeDesktop ? 28 : (isDesktop ? 24 : (isTablet ? 22 : 20))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: isLargeDesktop ? 16 : (isDesktop ? 12 : (isTablet ? 10 : 8)),
            offset: Offset(0, isLargeDesktop ? 6 : (isDesktop ? 4 : (isTablet ? 3 : 2))),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isLargeDesktop ? 20 : (isDesktop ? 16 : (isTablet ? 14 : 12))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: isLargeDesktop ? 120 : (isDesktop ? 100 : (isTablet ? 90 : 80)),
              height: isLargeDesktop ? 120 : (isDesktop ? 100 : (isTablet ? 90 : 80)),
              decoration: BoxDecoration(
                color: _surfaceColor,
                borderRadius: BorderRadius.circular(isLargeDesktop ? 22 : (isDesktop ? 18 : (isTablet ? 16 : 14))),
                border: Border.all(color: Colors.grey[100]!),
              ),
              child: Center(
                child: cartItem.image != null && cartItem.image!.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(isLargeDesktop ? 22 : (isDesktop ? 18 : (isTablet ? 16 : 14))),
                  child: Image.network(
                    cartItem.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildProductPlaceholder(isDesktop, isTablet, isLargeDesktop);
                    },
                  ),
                )
                    : _buildProductPlaceholder(isDesktop, isTablet, isLargeDesktop),
              ),
            ),
            SizedBox(width: isLargeDesktop ? 20 : (isDesktop ? 16 : (isTablet ? 14 : 12))),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and delete button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          cartItem.title,
                          style: GoogleFonts.poppins(
                            fontSize: isLargeDesktop ? 20 : (isDesktop ? 18 : (isTablet ? 16 : 15)),
                            fontWeight: FontWeight.w600,
                            color: _textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showRemoveItemDialog(context, cartItem.title),
                        icon: Icon(
                          Icons.close,
                          size: isLargeDesktop ? 24 : (isDesktop ? 22 : (isTablet ? 20 : 18)),
                          color: Colors.grey[400],
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  SizedBox(height: isLargeDesktop ? 12 : (isDesktop ? 8 : (isTablet ? 6 : 4))),

                  // Price
                  Text(
                    "\$${cartItem.price.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      fontSize: isLargeDesktop ? 24 : (isDesktop ? 20 : (isTablet ? 18 : 16)),
                      fontWeight: FontWeight.w700,
                      color: _primaryColor,
                    ),
                  ),
                  SizedBox(height: isLargeDesktop ? 16 : (isDesktop ? 12 : (isTablet ? 10 : 8))),

                  // Quantity controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity selector
                      Container(
                        decoration: BoxDecoration(
                          color: _surfaceColor,
                          borderRadius: BorderRadius.circular(isLargeDesktop ? 18 : (isDesktop ? 14 : (isTablet ? 12 : 10))),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildQuantityButton(
                              icon: Icons.remove,
                              onPressed: () {},
                              isDesktop: isDesktop,
                              isTablet: isTablet,
                              isLargeDesktop: isLargeDesktop,
                            ),
                            Container(
                              width: isLargeDesktop ? 60 : (isDesktop ? 50 : (isTablet ? 45 : 40)),
                              height: isLargeDesktop ? 60 : (isDesktop ? 50 : (isTablet ? 45 : 40)),
                              alignment: Alignment.center,
                              child: Text(
                                "${cartItem.quantity}",
                                style: GoogleFonts.poppins(
                                  fontSize: isLargeDesktop ? 22 : (isDesktop ? 18 : (isTablet ? 16 : 15)),
                                  fontWeight: FontWeight.w600,
                                  color: _textPrimary,
                                ),
                              ),
                            ),
                            _buildQuantityButton(
                              icon: Icons.add,
                              onPressed: () {},
                              isDesktop: isDesktop,
                              isTablet: isTablet,
                              isLargeDesktop: isLargeDesktop,
                            ),
                          ],
                        ),
                      ),

                      // Subtotal
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Subtotal",
                            style: GoogleFonts.poppins(
                              fontSize: isLargeDesktop ? 16 : (isDesktop ? 14 : (isTablet ? 13 : 12)),
                              color: _textSecondary,
                            ),
                          ),
                          Text(
                            "\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              fontSize: isLargeDesktop ? 22 : (isDesktop ? 18 : (isTablet ? 16 : 15)),
                              fontWeight: FontWeight.w700,
                              color: _textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isDesktop,
    required bool isTablet,
    required bool isLargeDesktop,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(isLargeDesktop ? 18 : (isDesktop ? 14 : (isTablet ? 12 : 10))),
        child: Container(
          width: isLargeDesktop ? 60 : (isDesktop ? 50 : (isTablet ? 45 : 40)),
          height: isLargeDesktop ? 60 : (isDesktop ? 50 : (isTablet ? 45 : 40)),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: isLargeDesktop ? 26 : (isDesktop ? 22 : (isTablet ? 20 : 18)),
            color: _primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildProductPlaceholder(bool isDesktop, bool isTablet, bool isLargeDesktop) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: _accentLight,
        borderRadius: BorderRadius.circular(isLargeDesktop ? 22 : (isDesktop ? 18 : (isTablet ? 16 : 14))),
      ),
      child: Icon(
        Icons.shopping_bag_outlined,
        size: isLargeDesktop ? 50 : (isDesktop ? 40 : (isTablet ? 36 : 32)),
        color: _primaryColor.withOpacity(0.5),
      ),
    );
  }

  Widget _buildCheckoutSection(
      BuildContext context,
      bool isDesktop,
      bool isTablet,
      bool isLargeDesktop,
      ) {
    // Calculate totals from sample data
    final subtotal = _cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    final shipping = subtotal > 100 ? 0.0 : 10.0;
    final tax = subtotal * 0.1; // 10% tax
    final total = subtotal + shipping + tax;

    return Container(
      padding: EdgeInsets.all(isLargeDesktop ? 40 : (isDesktop ? 32 : (isTablet ? 28 : 24))),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isLargeDesktop ? 40 : (isDesktop ? 32 : (isTablet ? 28 : 24))),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isLargeDesktop ? 30 : (isDesktop ? 20 : (isTablet ? 18 : 16)),
            offset: Offset(0, isLargeDesktop ? -8 : (isDesktop ? -5 : (isTablet ? -4 : -3))),
          ),
        ],
      ),
      child: Column(
        children: [
          // Price Breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: GoogleFonts.poppins(
                  fontSize: isLargeDesktop ? 18 : (isDesktop ? 16 : (isTablet ? 15 : 14)),
                  color: _textSecondary,
                ),
              ),
              Text(
                "\$${subtotal.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  fontSize: isLargeDesktop ? 18 : (isDesktop ? 16 : (isTablet ? 15 : 14)),
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: isLargeDesktop ? 16 : (isDesktop ? 12 : (isTablet ? 10 : 8))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping",
                style: GoogleFonts.poppins(
                  fontSize: isLargeDesktop ? 18 : (isDesktop ? 16 : (isTablet ? 15 : 14)),
                  color: _textSecondary,
                ),
              ),
              Text(
                shipping == 0 ? "Free" : "\$${shipping.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  fontSize: isLargeDesktop ? 18 : (isDesktop ? 16 : (isTablet ? 15 : 14)),
                  fontWeight: FontWeight.w500,
                  color: shipping == 0 ? _successColor : _textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: isLargeDesktop ? 16 : (isDesktop ? 12 : (isTablet ? 10 : 8))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tax (10%)",
                style: GoogleFonts.poppins(
                  fontSize: isLargeDesktop ? 18 : (isDesktop ? 16 : (isTablet ? 15 : 14)),
                  color: _textSecondary,
                ),
              ),
              Text(
                "\$${tax.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  fontSize: isLargeDesktop ? 18 : (isDesktop ? 16 : (isTablet ? 15 : 14)),
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                ),
              ),
            ],
          ),

          Divider(
            height: isLargeDesktop ? 40 : (isDesktop ? 32 : (isTablet ? 28 : 24)),
            thickness: isLargeDesktop ? 1.5 : 1,
          ),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: GoogleFonts.poppins(
                  fontSize: isLargeDesktop ? 26 : (isDesktop ? 22 : (isTablet ? 20 : 18)),
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${total.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      fontSize: isLargeDesktop ? 32 : (isDesktop ? 28 : (isTablet ? 26 : 24)),
                      fontWeight: FontWeight.w800,
                      color: _primaryColor,
                    ),
                  ),
                  Text(
                    "Including taxes",
                    style: GoogleFonts.poppins(
                      fontSize: isLargeDesktop ? 16 : (isDesktop ? 14 : (isTablet ? 13 : 12)),
                      color: _textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: isLargeDesktop ? 32 : (isDesktop ? 24 : (isTablet ? 20 : 16))),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: isLargeDesktop ? 76 : (isDesktop ? 64 : (isTablet ? 60 : 56)),
            child: ElevatedButton(
              onPressed: () => _showCheckoutDialog(context, total),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: _white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(isLargeDesktop ? 24 : (isDesktop ? 20 : (isTablet ? 18 : 16))),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: isLargeDesktop ? 26 : (isDesktop ? 22 : (isTablet ? 20 : 18)),
                  ),
                  SizedBox(width: isLargeDesktop ? 16 : (isDesktop ? 12 : (isTablet ? 10 : 8))),
                  Text(
                    "Proceed to Checkout",
                    style: GoogleFonts.poppins(
                      fontSize: isLargeDesktop ? 22 : (isDesktop ? 20 : (isTablet ? 18 : 16)),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: isLargeDesktop ? 16 : (isDesktop ? 12 : (isTablet ? 10 : 8))),

          // Payment methods
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payment,
                size: isLargeDesktop ? 24 : (isDesktop ? 20 : (isTablet ? 18 : 16)),
                color: _textSecondary,
              ),
              SizedBox(width: isLargeDesktop ? 10 : (isDesktop ? 8 : (isTablet ? 6 : 4))),
              Text(
                "Visa •••• 4242",
                style: GoogleFonts.poppins(
                  fontSize: isLargeDesktop ? 16 : (isDesktop ? 14 : (isTablet ? 13 : 12)),
                  color: _textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showClearCartDialog(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isDesktop ? 32 : (isTablet ? 28 : 24)),
        ),
        title: Column(
          children: [
            Container(
              padding: EdgeInsets.all(isDesktop ? 20 : (isTablet ? 18 : 16)),
              decoration: BoxDecoration(
                color: _accentLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: _primaryColor,
                size: isDesktop ? 40 : (isTablet ? 36 : 32),
              ),
            ),
            SizedBox(height: isDesktop ? 20 : (isTablet ? 18 : 16)),
            Text(
              "Clear Cart",
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 24 : (isTablet ? 22 : 20),
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          "Are you sure you want to remove all items from your cart?",
          style: GoogleFonts.poppins(
            fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
            color: _textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                color: _textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: _white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isDesktop ? 16 : (isTablet ? 14 : 12)),
              ),
            ),
            child: Text(
              "Clear",
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showRemoveItemDialog(
      BuildContext context,
      String productTitle,
      ) async {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isDesktop ? 32 : (isTablet ? 28 : 24)),
        ),
        title: Column(
          children: [
            Container(
              padding: EdgeInsets.all(isDesktop ? 20 : (isTablet ? 18 : 16)),
              decoration: BoxDecoration(
                color: _accentLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.remove_shopping_cart_outlined,
                color: _primaryColor,
                size: isDesktop ? 40 : (isTablet ? 36 : 32),
              ),
            ),
            SizedBox(height: isDesktop ? 20 : (isTablet ? 18 : 16)),
            Text(
              "Remove Item",
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 24 : (isTablet ? 22 : 20),
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          "Are you sure you want to remove '$productTitle' from your cart?",
          style: GoogleFonts.poppins(
            fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
            color: _textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                color: _textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: _white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isDesktop ? 16 : (isTablet ? 14 : 12)),
              ),
            ),
            child: Text(
              "Remove",
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCheckoutDialog(BuildContext context, double total) async {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isDesktop ? 40 : (isTablet ? 36 : 32)),
        ),
        title: Column(
          children: [
            Container(
              padding: EdgeInsets.all(isDesktop ? 24 : (isTablet ? 22 : 20)),
              decoration: BoxDecoration(
                color: _successColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline_rounded,
                color: _successColor,
                size: isDesktop ? 56 : (isTablet ? 52 : 48),
              ),
            ),
            SizedBox(height: isDesktop ? 24 : (isTablet ? 22 : 20)),
            Text(
              "Order Placed Successfully!",
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 26 : (isTablet ? 24 : 22),
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Thank you for your purchase!",
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                color: _textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(isDesktop ? 20 : (isTablet ? 18 : 16)),
              decoration: BoxDecoration(
                color: _accentLight,
                borderRadius: BorderRadius.circular(isDesktop ? 20 : (isTablet ? 18 : 16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Paid:",
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                      fontWeight: FontWeight.w500,
                      color: _textSecondary,
                    ),
                  ),
                  Text(
                    "\$${total.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 22 : (isTablet ? 20 : 18),
                      fontWeight: FontWeight.w700,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: _white,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 20 : (isTablet ? 18 : 16)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isDesktop ? 20 : (isTablet ? 18 : 16)),
              ),
            ),
            child: Text(
              "Continue Shopping",
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}