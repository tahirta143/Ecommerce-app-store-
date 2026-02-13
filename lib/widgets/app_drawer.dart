import 'package:ecommerce_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // Single cohesive color theme - Professional Indigo/Purple mix
  static const Color _primaryColor = Color(0xFF6366F1); // Indigo
  static const Color _secondaryColor = Color(0xFF8B5CF6); // Purple accent
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _accentLight = Color(0xFFEEF2FF); // Light indigo for backgrounds

  // Responsive sizing methods
  double _getHeaderHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 240; // Large desktop
    if (width >= 900) return 220; // Desktop
    if (width >= 600) return 200; // Tablet
    return 180; // Mobile
  }

  double _getAvatarRadius(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 40;
    if (width >= 900) return 38;
    if (width >= 600) return 35;
    return 32;
  }

  double _getInnerAvatarRadius(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 37;
    if (width >= 900) return 35;
    if (width >= 600) return 32;
    return 29;
  }

  double _getIconSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 40;
    if (width >= 900) return 38;
    if (width >= 600) return 35;
    return 32;
  }

  double _getUserNameSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 22;
    if (width >= 900) return 20;
    if (width >= 600) return 19;
    return 18;
  }

  double _getUserEmailSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 15;
    if (width >= 900) return 14;
    if (width >= 600) return 13.5;
    return 13;
  }

  double _getDrawerItemIconSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 22;
    if (width >= 900) return 21;
    if (width >= 600) return 20;
    return 18;
  }

  double _getDrawerItemFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 16;
    if (width >= 900) return 15;
    if (width >= 600) return 14;
    return 13;
  }

  double _getDrawerItemTrailingSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 16;
    if (width >= 900) return 15;
    if (width >= 600) return 14;
    return 12;
  }

  double _getVersionSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 13;
    if (width >= 900) return 12;
    if (width >= 600) return 11.5;
    return 11;
  }

  EdgeInsets _getHeaderPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return const EdgeInsets.all(20);
    if (width >= 900) return const EdgeInsets.all(18);
    if (width >= 600) return const EdgeInsets.all(16);
    return const EdgeInsets.all(14);
  }

  EdgeInsets _getDrawerItemPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 6);
    }
    if (width >= 900) {
      return const EdgeInsets.symmetric(horizontal: 14, vertical: 4);
    }
    if (width >= 600) {
      return const EdgeInsets.symmetric(horizontal: 12, vertical: 2);
    }
    return const EdgeInsets.symmetric(horizontal: 10, vertical: 0);
  }

  double _getDividerIndent(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 25;
    if (width >= 900) return 22;
    if (width >= 600) return 20;
    return 16;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // Adjust drawer width for landscape
    final double drawerWidth = isLandscape ? size.width * 0.35 : size.width * 0.8;

    final headerHeight = _getHeaderHeight(context);
    final avatarRadius = _getAvatarRadius(context);
    final innerAvatarRadius = _getInnerAvatarRadius(context);
    final iconSize = _getIconSize(context);
    final userNameSize = _getUserNameSize(context);
    final userEmailSize = _getUserEmailSize(context);
    final drawerItemIconSize = _getDrawerItemIconSize(context);
    final drawerItemFontSize = _getDrawerItemFontSize(context);
    final drawerItemTrailingSize = _getDrawerItemTrailingSize(context);
    final versionSize = _getVersionSize(context);
    final headerPadding = _getHeaderPadding(context);
    final drawerItemPadding = _getDrawerItemPadding(context);
    final dividerIndent = _getDividerIndent(context);

    return Drawer(
      width: drawerWidth,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Enhanced User Account Header with Gradient
          Container(
            height: headerHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_primaryColor, _secondaryColor],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: _primaryColor.withOpacity(0.3),
                  blurRadius: size.width >= 1200 ? 25 : 20,
                  offset: Offset(0, size.width >= 1200 ? 10 : 8),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: headerPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Add this to prevent overflow
                  children: [
                    // Profile Image with Enhanced Design
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: _white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: size.width >= 1200 ? 12 : 10,
                            offset: Offset(0, size.width >= 1200 ? 5 : 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: _white,
                        child: CircleAvatar(
                          radius: innerAvatarRadius,
                          backgroundColor: _accentLight,
                          child: Icon(
                            Icons.person,
                            size: iconSize,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // User Name
                    Flexible(
                      child: Text(
                        "John Doe",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: userNameSize,
                          color: _white,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // User Email
                    Flexible(
                      child: Text(
                        "john.doe@example.com",
                        style: GoogleFonts.poppins(
                          fontSize: userEmailSize,
                          color: _white.withOpacity(0.9),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Menu Items Section
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.width >= 1200 ? 16 : 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: Icons.home_outlined,
                  title: "Home",
                  iconSize: drawerItemIconSize,
                  fontSize: drawerItemFontSize,
                  trailingSize: drawerItemTrailingSize,
                  padding: drawerItemPadding,
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to home/dashboard
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.shopping_bag_outlined,
                  title: "Shop",
                  iconSize: drawerItemIconSize,
                  fontSize: drawerItemFontSize,
                  trailingSize: drawerItemTrailingSize,
                  padding: drawerItemPadding,
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to shop
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.category_outlined,
                  title: "Categories",
                  iconSize: drawerItemIconSize,
                  fontSize: drawerItemFontSize,
                  trailingSize: drawerItemTrailingSize,
                  padding: drawerItemPadding,
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to categories
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.favorite_border,
                  title: "Wishlist",
                  iconSize: drawerItemIconSize,
                  fontSize: drawerItemFontSize,
                  trailingSize: drawerItemTrailingSize,
                  padding: drawerItemPadding,
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to wishlist
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.settings_outlined,
                  title: "Settings",
                  iconSize: drawerItemIconSize,
                  fontSize: drawerItemFontSize,
                  trailingSize: drawerItemTrailingSize,
                  padding: drawerItemPadding,
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to settings
                  },
                ),
              ],
            ),
          ),

          Divider(
            thickness: 1,
            indent: dividerIndent,
            endIndent: dividerIndent,
            color: Colors.grey.shade300,
          ),

          // Support Section
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.width >= 1200 ? 8 : 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: FontAwesomeIcons.whatsapp,
                  title: "Contact Support",
                  iconSize: drawerItemIconSize,
                  fontSize: drawerItemFontSize,
                  trailingSize: drawerItemTrailingSize,
                  padding: drawerItemPadding,
                  onTap: () {
                    Navigator.pop(context);
                    // Open WhatsApp support
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.help_outline,
                  title: "Help Center",
                  iconSize: drawerItemIconSize,
                  fontSize: drawerItemFontSize,
                  trailingSize: drawerItemTrailingSize,
                  padding: drawerItemPadding,
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to help center
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.info_outline,
                  title: "About Us",
                  iconSize: drawerItemIconSize,
                  fontSize: drawerItemFontSize,
                  trailingSize: drawerItemTrailingSize,
                  padding: drawerItemPadding,
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to about us
                  },
                ),
              ],
            ),
          ),

          Divider(
            thickness: 1,
            indent: dividerIndent,
            endIndent: dividerIndent,
            color: Colors.grey.shade300,
          ),

          // Sign Out Section
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.width >= 1200 ? 8 : 6),
            child: _buildDrawerItem(
              context: context,
              icon: Icons.logout,
              title: "Sign Out",
              isSignOut: true,
              iconSize: drawerItemIconSize,
              fontSize: drawerItemFontSize,
              trailingSize: drawerItemTrailingSize,
              padding: drawerItemPadding,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ),

          // App Version
          Padding(
            padding: EdgeInsets.all(size.width >= 1200 ? 20 : 16),
            child: Center(
              child: Text(
                "Version 2.0.0",
                style: GoogleFonts.poppins(
                  fontSize: versionSize,
                  color: _textSecondary.withOpacity(0.5),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double iconSize,
    required double fontSize,
    required double trailingSize,
    required EdgeInsets padding,
    bool isSignOut = false,
  }) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width >= 1200 ? 12 : (size.width >= 900 ? 10 : 8),
        vertical: size.width >= 1200 ? 2 : 1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width >= 1200 ? 14 : 12),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(size.width >= 1200 ? 10 : (size.width >= 900 ? 9 : 8)),
          decoration: BoxDecoration(
            color: isSignOut
                ? Colors.red.withOpacity(0.1)
                : _accentLight,
            borderRadius: BorderRadius.circular(size.width >= 1200 ? 10 : 8),
          ),
          child: Icon(
            icon,
            size: iconSize,
            color: isSignOut ? Colors.red : _primaryColor,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: isSignOut ? Colors.red : _textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: isSignOut
            ? null
            : Icon(
          Icons.arrow_forward_ios,
          size: trailingSize,
          color: _textSecondary,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width >= 1200 ? 14 : 12),
        ),
        contentPadding: padding,
        dense: size.width < 600,
        minVerticalPadding: 0, // Reduce vertical padding
      ),
    );
  }
}