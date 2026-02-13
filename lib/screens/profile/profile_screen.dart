import 'package:ecommerce_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Single cohesive color theme - Professional Indigo/Purple mix
  static const Color _primaryColor = Color(0xFF6366F1); // Indigo
  static const Color _secondaryColor = Color(0xFF8B5CF6); // Purple accent
  static const Color _surfaceColor = Color(0xFFF8FAFC); // Light background
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _accentLight = Color(0xFFEEF2FF); // Light indigo for backgrounds

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive sizing
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final viewInsets = MediaQuery.of(context).viewInsets;
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    // Responsive breakpoints
    final bool isMobile = size.width < 600;
    final bool isTablet = size.width >= 600 && size.width < 900;
    final bool isDesktop = size.width >= 900 && size.width < 1200;
    final bool isLargeDesktop = size.width >= 1200;

    // Dynamic sizing
    final double horizontalPadding = isLargeDesktop ? 48 : (isDesktop ? 40 : (isTablet ? 32 : (isLandscape ? 40 : 20)));
    final double verticalPadding = isLargeDesktop ? 32 : (isDesktop ? 28 : (isTablet ? 24 : (isLandscape ? 16 : 20)));
    final double spacing = isLargeDesktop ? 24 : (isDesktop ? 20 : (isTablet ? 18 : (isLandscape ? 12 : 16)));

    return Scaffold(
      backgroundColor: _surfaceColor,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _primaryColor.withOpacity(0.03),
              _surfaceColor,
              _surfaceColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              top: verticalPadding,
              bottom: verticalPadding + viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeader(context, isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, spacing),
                SizedBox(height: spacing),

                // Profile Card
                _buildProfileCard(context, isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, spacing),
                SizedBox(height: spacing),

                // Stats Row
                _buildStatsRow(context, isLargeDesktop, isDesktop, isTablet, isLandscape, spacing),
                SizedBox(height: spacing),

                // Account Settings Header
                _buildSectionHeader(context, "Account Settings", isLargeDesktop, isDesktop, isTablet, isLandscape),
                SizedBox(height: spacing * 0.75),

                // Account Settings Grid
                _buildAccountSettingsGrid(context, isLargeDesktop, isDesktop, isTablet, isLandscape, spacing),
                SizedBox(height: spacing),

                // Help & Support Header
                _buildSectionHeader(context, "Help & Support", isLargeDesktop, isDesktop, isTablet, isLandscape),
                SizedBox(height: spacing * 0.75),

                // Help & Support Options
                _buildHelpSupport(context, isLargeDesktop, isDesktop, isTablet, isLandscape, spacing),
                SizedBox(height: spacing),

                // Sign Out Button
                _buildSignOutButton(context, isLargeDesktop, isDesktop, isTablet, isLandscape, spacing),
                SizedBox(height: spacing * 0.5),

                // App Version

              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header Section
  Widget _buildHeader(
      BuildContext context,
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      bool isMobile,
      double spacing,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Greeting
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Welcome back,",
              style: GoogleFonts.poppins(
                fontSize: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 16, 15, 14, 13),
                color: _textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: spacing * 0.25),
            Text(
              "John Doe",
              style: GoogleFonts.poppins(
                fontSize: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 28, 26, 24, 22),
                fontWeight: FontWeight.w700,
                color: _textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),

        // Settings Button
        Container(
          decoration: BoxDecoration(
            color: _white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
            color: _primaryColor,
            iconSize: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 28, 26, 24, 22),
            padding: EdgeInsets.all(spacing * 0.5),
            constraints: const BoxConstraints(),
          ),
        ),
      ],
    );
  }

  // Profile Card
  Widget _buildProfileCard(
      BuildContext context,
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      bool isMobile,
      double spacing,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spacing * 1.2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _primaryColor,
            _secondaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(spacing * 1.5),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: _white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 50, 45, 40, 35),
              backgroundColor: _white,
              child: CircleAvatar(
                radius: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 47, 42, 37, 32),
                backgroundColor: _accentLight,
                child: Icon(
                  Icons.person,
                  size: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 40, 38, 35, 30),
                  color: _primaryColor.withOpacity(0.6),
                ),
              ),
            ),
          ),
          SizedBox(width: spacing),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "John Doe",
                  style: GoogleFonts.poppins(
                    fontSize: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 24, 22, 20, 18),
                    fontWeight: FontWeight.w700,
                    color: _white,
                    letterSpacing: -0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spacing * 0.25),
                Text(
                  "john.doe@example.com",
                  style: GoogleFonts.poppins(
                    fontSize: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 16, 15, 14, 13),
                    color: _white.withOpacity(0.95),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spacing * 0.5),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing * 0.8,
                    vertical: spacing * 0.3,
                  ),
                  decoration: BoxDecoration(
                    color: _white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(spacing * 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified,
                        size: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 18, 16, 15, 14),
                        color: _white,
                      ),
                      SizedBox(width: spacing * 0.3),
                      Flexible(
                        child: Text(
                          "Verified Account",
                          style: GoogleFonts.poppins(
                            fontSize: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 14, 13, 12, 11),
                            fontWeight: FontWeight.w600,
                            color: _white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Edit Button
          if (!isLandscape || !isMobile)
            Container(
              decoration: BoxDecoration(
                color: _white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                color: _primaryColor,
                iconSize: _getFontSize(isLargeDesktop, isDesktop, isTablet, isLandscape, isMobile, 24, 22, 20, 18),
                padding: EdgeInsets.all(spacing * 0.4),
                constraints: const BoxConstraints(),
              ),
            ),
        ],
      ),
    );
  }

  // Stats Row
  Widget _buildStatsRow(
      BuildContext context,
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      double spacing,
      ) {
    return Row(
      children: [
        _buildStatCard("Orders", "24", Icons.shopping_bag_outlined, isLargeDesktop, isDesktop, isTablet, isLandscape, spacing),
        SizedBox(width: spacing),
        _buildStatCard("Wishlist", "12", Icons.favorite_border, isLargeDesktop, isDesktop, isTablet, isLandscape, spacing),
        SizedBox(width: spacing),
        _buildStatCard("Reviews", "8", Icons.star_border, isLargeDesktop, isDesktop, isTablet, isLandscape, spacing),
      ],
    );
  }

  Widget _buildStatCard(
      String title,
      String value,
      IconData icon,
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      double spacing,
      ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spacing * 0.8),
        decoration: BoxDecoration(
          color: _white,
          borderRadius: BorderRadius.circular(spacing),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spacing * 0.6),
              decoration: BoxDecoration(
                color: _accentLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: _primaryColor,
                size: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 28, 26, 24, 22),
              ),
            ),
            SizedBox(height: spacing * 0.4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 28, 26, 24, 22),
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: spacing * 0.2),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 14, 13, 12, 11),
                color: _textSecondary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Section Header
  Widget _buildSectionHeader(
      BuildContext context,
      String title,
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 22, 20, 18, 17),
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        SizedBox(height: 4),
        Container(
          width: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 70, 60, 50, 45),
          height: 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_primaryColor, _secondaryColor],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  // Account Settings Grid
  Widget _buildAccountSettingsGrid(
      BuildContext context,
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      double spacing,
      ) {
    final int crossAxisCount = isLargeDesktop ? 4 : (isDesktop ? 3 : (isTablet ? 2 : 1));

    final List<Map<String, dynamic>> options = [
      {"title": "My Orders", "icon": Icons.shopping_bag_outlined, "subtitle": "Track, return, or buy again"},
      {"title": "Shipping Addresses", "icon": Icons.location_on_outlined, "subtitle": "Manage your addresses"},
      {"title": "Payment Methods", "icon": Icons.credit_card, "subtitle": "Add or remove payment methods"},
      {"title": "Promocodes", "icon": Icons.local_offer_outlined, "subtitle": "Redeem your vouchers"},
      {"title": "My Reviews", "icon": Icons.star_border, "subtitle": "Products you've reviewed"},
      {"title": "Settings", "icon": Icons.settings_outlined, "subtitle": "App preferences"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        childAspectRatio: 5.2,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return _buildOptionCard(
          context,
          options[index]["title"],
          options[index]["icon"],
          options[index]["subtitle"],
          isLargeDesktop,
          isDesktop,
          isTablet,
          isLandscape,
          spacing,
        );
      },
    );
  }

  Widget _buildOptionCard(
      BuildContext context,
      String title,
      IconData icon,
      String subtitle,
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      double spacing,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(spacing * 0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(spacing * 0.9),
          child: Padding(
            padding: EdgeInsets.all(spacing * 0.7),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spacing * 0.5),
                  decoration: BoxDecoration(
                    color: _accentLight,
                    borderRadius: BorderRadius.circular(spacing * 0.6),
                  ),
                  child: Icon(
                    icon,
                    color: _primaryColor,
                    size: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 24, 22, 20, 18),
                  ),
                ),
                SizedBox(width: spacing * 0.6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 16, 15, 14, 13),
                          fontWeight: FontWeight.w600,
                          color: _textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spacing * 0.2),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 13, 12, 11, 10),
                          color: _textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 16, 15, 14, 13),
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Help & Support Section
  Widget _buildHelpSupport(
      BuildContext context,
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      double spacing,
      ) {
    final List<Map<String, dynamic>> options = [
      {"title": "Help Center", "icon": Icons.help_outline},
      {"title": "About Us", "icon": Icons.info_outline},
      {"title": "Terms & Conditions", "icon": Icons.description_outlined},
      {"title": "Privacy Policy", "icon": Icons.privacy_tip_outlined},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spacing),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(spacing),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHelpOption(
                context,
                option["title"],
                option["icon"],
                isLargeDesktop,
                isDesktop,
                isTablet,
                isLandscape,
                spacing,
              ),
              if (index < options.length - 1)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: spacing * 0.5),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[200],
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHelpOption(
      BuildContext context,
      String title,
      IconData icon,
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      double spacing,
      ) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(spacing * 0.5),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing * 0.5,
          vertical: spacing * 0.4,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spacing * 0.4),
              decoration: BoxDecoration(
                color: _accentLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: _primaryColor,
                size: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 22, 20, 18, 16),
              ),
            ),
            SizedBox(width: spacing * 0.8),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 16, 15, 14, 13),
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 16, 15, 14, 13),
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  // Sign Out Button
  Widget _buildSignOutButton(
      BuildContext context,
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      double spacing,
      ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: spacing * 0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(spacing),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.logout_rounded,
              size: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 24, 22, 20, 18),
              // color: Colors.white,
            ),
            SizedBox(width: spacing * 0.5),
            Text(
              "Sign Out",
              style: GoogleFonts.poppins(
                fontSize: _getFontSizeSimple(isLargeDesktop, isDesktop, isTablet, isLandscape, 18, 16, 15, 14),
                fontWeight: FontWeight.w600,
                // color: ,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // App Version


  // Helper function for consistent font sizing (with isMobile parameter)
  double _getFontSize(
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      bool isMobile,
      double largeDesktop,
      double desktop,
      double tablet,
      double mobile,
      ) {
    if (isLargeDesktop) return largeDesktop;
    if (isDesktop) return desktop;
    if (isTablet) return tablet;
    if (isLandscape && isMobile) return mobile * 0.9;
    return mobile;
  }

  // Helper function for consistent font sizing (without isMobile parameter)
  double _getFontSizeSimple(
      bool isLargeDesktop,
      bool isDesktop,
      bool isTablet,
      bool isLandscape,
      double largeDesktop,
      double desktop,
      double tablet,
      double mobile,
      ) {
    if (isLargeDesktop) return largeDesktop;
    if (isDesktop) return desktop;
    if (isTablet) return tablet;
    if (isLandscape) return mobile * 0.95;
    return mobile;
  }
}