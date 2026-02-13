import 'package:ecommerce_app/screens/cart/cart_screen.dart';
import 'package:ecommerce_app/screens/categories/categories_screen.dart';
import 'package:ecommerce_app/screens/dashboard/dashboard_screen.dart';
import 'package:ecommerce_app/screens/profile/profile_screen.dart';
import 'package:ecommerce_app/screens/shop/shop_screen.dart';
import 'package:ecommerce_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  int _cartItemCount = 3;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ShopScreen(),
    const CategoriesScreen(),
    const ProfileScreen(),
  ];

  final List<String> _titles = [
    "Dashboard",
    "Shop",
    "Categories",
    "Profile",
  ];

  // Single cohesive color theme - Professional Indigo/Purple mix
  static const Color _primaryColor = Color(0xFF6366F1); // Indigo
  static const Color _secondaryColor = Color(0xFF8B5CF6); // Purple accent
  static const Color _surfaceColor = Color(0xFFF8FAFC); // Light background
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);

  // Single gradient using mixed colors
  final List<Color> _appBarGradients = [
    _primaryColor,
    _primaryColor,
    _primaryColor,
    _primaryColor,
  ];

  // Single background color
  final List<Color> _bgGradients = [
    _surfaceColor,
    _surfaceColor,
    _surfaceColor,
    _surfaceColor,
  ];

  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateCartCount(int count) {
    setState(() {
      _cartItemCount = count;
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  // Responsive sizing methods
  double _getAppBarHeight(Size size) {
    if (size.width >= 1200) return size.height * 0.10; // Large desktop
    if (size.width >= 900) return size.height * 0.11; // Desktop
    if (size.width >= 600) return size.height * 0.12; // Tablet
    return size.height * 0.13; // Mobile
  }

  double _getIconSize(Size size) {
    if (size.width >= 1200) return 28;
    if (size.width >= 900) return 26;
    if (size.width >= 600) return 24;
    return 22;
  }

  double _getTitleSize(Size size) {
    if (size.width >= 1200) return 28;
    if (size.width >= 900) return 26;
    if (size.width >= 600) return 24;
    return 22;
  }

  double _getSubtitleSize(Size size) {
    if (size.width >= 1200) return 15;
    if (size.width >= 900) return 14;
    if (size.width >= 600) return 13;
    return 12;
  }

  double _getButtonSize(Size size) {
    if (size.width >= 1200) return 50;
    if (size.width >= 900) return 48;
    if (size.width >= 600) return 46;
    return 44;
  }

  double _getLogoSize(Size size) {
    if (size.width >= 1200) return 42;
    if (size.width >= 900) return 40;
    if (size.width >= 600) return 38;
    return 36;
  }

  EdgeInsets _getPadding(Size size) {
    if (size.width >= 1200) {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
    if (size.width >= 900) {
      return const EdgeInsets.symmetric(horizontal: 28, vertical: 14);
    }
    if (size.width >= 600) {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    }
    return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // Adjust heights for landscape mode
    final appBarHeight = isLandscape ? size.height * 0.18 : _getAppBarHeight(size);
    final iconSize = _getIconSize(size);
    final titleSize = _getTitleSize(size);
    final subtitleSize = _getSubtitleSize(size);
    final buttonSize = _getButtonSize(size);
    final logoSize = _getLogoSize(size);
    final edgePadding = _getPadding(size);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: _bgGradients[_selectedIndex],
      drawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _primaryColor.withOpacity(0.95),
                _secondaryColor.withOpacity(0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: _primaryColor.withOpacity(0.3),
                blurRadius: size.width >= 1200 ? 30 : 25,
                spreadRadius: 0,
                offset: Offset(0, size.width >= 1200 ? 8 : 5),
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(size.width >= 1200 ? 40 : 30),
              bottomRight: Radius.circular(size.width >= 1200 ? 40 : 30),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: edgePadding,
              child: Row(
                children: [
                  // Menu Button
                  InkWell(
                    onTap: _openDrawer,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: buttonSize,
                      height: buttonSize,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.menu_rounded,
                        color: Colors.white.withOpacity(0.9),
                        size: iconSize * 0.8,
                      ),
                    ),
                  ),

                  SizedBox(width: size.width * 0.02),

                  // Logo & Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: logoSize * 0.6,
                              height: logoSize * 0.6,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.shopping_bag_rounded,
                                color: Colors.white,
                                size: logoSize * 0.35,
                              ),
                            ),
                            SizedBox(width: size.width * 0.015),
                            Flexible(
                              child: Text(
                                _titles[_selectedIndex],
                                style: GoogleFonts.poppins(
                                  fontSize: titleSize,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _selectedIndex == 0
                              ? "Welcome back! 👋"
                              : _selectedIndex == 1
                              ? "Explore amazing products ✨"
                              : _selectedIndex == 2
                              ? "Browse categories 🛍️"
                              : "Manage your account 👤",
                          style: GoogleFonts.poppins(
                            fontSize: subtitleSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.9),
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Action Icons
                  Row(
                    children: [
                      // Notification Button
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: buttonSize,
                            height: buttonSize,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.notifications_none_rounded,
                                size: iconSize * 0.8,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                          Positioned(
                            top: buttonSize * 0.15,
                            right: buttonSize * 0.15,
                            child: Container(
                              width: buttonSize * 0.2,
                              height: buttonSize * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red,
                                    blurRadius: 6,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: size.width * 0.015),

                      // Cart Button
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: buttonSize,
                            height: buttonSize,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.shopping_cart_rounded,
                                size: iconSize * 0.8,
                                color: _primaryColor,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartScreen(),
                                  ),
                                ).then((value) {
                                  if (value != null && value is int) {
                                    _updateCartCount(value);
                                  }
                                });
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),

                          // Cart Badge
                          if (_cartItemCount > 0)
                            Positioned(
                              top: buttonSize * 0.08,
                              right: buttonSize * 0.1,
                              child: Container(
                                width: buttonSize * 0.35,
                                height: buttonSize * 0.35,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade500,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    _cartItemCount > 9 ? '9+' : _cartItemCount.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: buttonSize * 0.18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _bgGradients[_selectedIndex],
              _bgGradients[_selectedIndex].withOpacity(0.95),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width >= 1200 ? 35 : 25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: size.width >= 1200 ? 30 : 20,
              spreadRadius: 0,
              offset: Offset(0, size.width >= 1200 ? -8 : -5),
            ),
            BoxShadow(
              color: _primaryColor.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size.width >= 1200 ? 35 : 25),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: _primaryColor,
            unselectedItemColor: Colors.grey.shade500,
            showUnselectedLabels: size.width >= 600 ? true : false,
            selectedLabelStyle: GoogleFonts.poppins(
              fontSize: size.width >= 1200 ? 13 : (size.width >= 900 ? 12 : 11),
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: size.width >= 1200 ? 12 : (size.width >= 900 ? 11 : 10),
              fontWeight: FontWeight.w500,
            ),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(size.width >= 1200 ? 12 : (size.width >= 900 ? 10 : 8)),
                  decoration: BoxDecoration(
                    gradient: _selectedIndex == 0
                        ? LinearGradient(
                      colors: [
                        _primaryColor,
                        _secondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                        : null,
                    color: _selectedIndex == 0 ? null : Colors.transparent,
                    shape: BoxShape.circle,
                    boxShadow: _selectedIndex == 0
                        ? [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                        : null,
                  ),
                  child: Icon(
                    _selectedIndex == 0 ? Icons.dashboard_rounded : Icons.dashboard_outlined,
                    size: _selectedIndex == 0
                        ? (size.width >= 1200 ? 28 : (size.width >= 900 ? 26 : 24))
                        : (size.width >= 1200 ? 26 : (size.width >= 900 ? 24 : 22)),
                    color: _selectedIndex == 0 ? Colors.white : Colors.grey.shade500,
                  ),
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(size.width >= 1200 ? 12 : (size.width >= 900 ? 10 : 8)),
                  decoration: BoxDecoration(
                    gradient: _selectedIndex == 1
                        ? LinearGradient(
                      colors: [
                        _primaryColor,
                        _secondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                        : null,
                    color: _selectedIndex == 1 ? null : Colors.transparent,
                    shape: BoxShape.circle,
                    boxShadow: _selectedIndex == 1
                        ? [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                        : null,
                  ),
                  child: Icon(
                    _selectedIndex == 1 ? Icons.storefront_rounded : Icons.storefront_outlined,
                    size: _selectedIndex == 1
                        ? (size.width >= 1200 ? 28 : (size.width >= 900 ? 26 : 24))
                        : (size.width >= 1200 ? 26 : (size.width >= 900 ? 24 : 22)),
                    color: _selectedIndex == 1 ? Colors.white : Colors.grey.shade500,
                  ),
                ),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(size.width >= 1200 ? 12 : (size.width >= 900 ? 10 : 8)),
                  decoration: BoxDecoration(
                    gradient: _selectedIndex == 2
                        ? LinearGradient(
                      colors: [
                        _primaryColor,
                        _secondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                        : null,
                    color: _selectedIndex == 2 ? null : Colors.transparent,
                    shape: BoxShape.circle,
                    boxShadow: _selectedIndex == 2
                        ? [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                        : null,
                  ),
                  child: Icon(
                    _selectedIndex == 2 ? Icons.category_rounded : Icons.category_outlined,
                    size: _selectedIndex == 2
                        ? (size.width >= 1200 ? 28 : (size.width >= 900 ? 26 : 24))
                        : (size.width >= 1200 ? 26 : (size.width >= 900 ? 24 : 22)),
                    color: _selectedIndex == 2 ? Colors.white : Colors.grey.shade500,
                  ),
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(size.width >= 1200 ? 12 : (size.width >= 900 ? 10 : 8)),
                  decoration: BoxDecoration(
                    gradient: _selectedIndex == 3
                        ? LinearGradient(
                      colors: [
                        _primaryColor,
                        _secondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                        : null,
                    color: _selectedIndex == 3 ? null : Colors.transparent,
                    shape: BoxShape.circle,
                    boxShadow: _selectedIndex == 3
                        ? [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                        : null,
                  ),
                  child: Icon(
                    _selectedIndex == 3 ? Icons.person_rounded : Icons.person_outline,
                    size: _selectedIndex == 3
                        ? (size.width >= 1200 ? 28 : (size.width >= 900 ? 26 : 24))
                        : (size.width >= 1200 ? 26 : (size.width >= 900 ? 24 : 22)),
                    color: _selectedIndex == 3 ? Colors.white : Colors.grey.shade500,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}