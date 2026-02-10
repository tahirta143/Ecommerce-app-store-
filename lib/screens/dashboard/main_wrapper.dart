import 'package:ecommerce_app/screens/cart/cart_screen.dart';
import 'package:ecommerce_app/screens/categories/categories_screen.dart';
import 'package:ecommerce_app/screens/dashboard/dashboard_screen.dart';
import 'package:ecommerce_app/screens/profile/profile_screen.dart';
import 'package:ecommerce_app/screens/shop/shop_screen.dart';
import 'package:ecommerce_app/utils/app_theme.dart';
import 'package:ecommerce_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  int _cartItemCount = 3;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _initialized = false;

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

  final List<Color> _bgGradients = [
    const Color(0xFFF8FAFF), // Light blue gradient
    const Color(0xFFF8FAFF),
    const Color(0xFFF8FAFF),
    const Color(0xFFF8FAFF),
  ];

  final List<Color> _appBarGradients = [
    const Color(0xFF7C3AED), // Purple gradient
    const Color(0xFF3B82F6), // Blue gradient
    const Color(0xFF10B981), // Green gradient
    const Color(0xFFEC4899), // Pink gradient
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.05), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
    _initialized = true;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_initialized) {
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  void _updateCartCount(int count) {
    setState(() {
      _cartItemCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Show loading while animations initialize
    if (!_initialized) {
      return Scaffold(
        backgroundColor: _bgGradients[_selectedIndex],
        body: Center(
          child: CircularProgressIndicator(
            color: _appBarGradients[_selectedIndex],
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: _bgGradients[_selectedIndex],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.12),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _appBarGradients[_selectedIndex].withOpacity(0.95),
                        _appBarGradients[_selectedIndex].withOpacity(0.85),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _appBarGradients[_selectedIndex].withOpacity(0.3),
                        blurRadius: 25,
                        spreadRadius: 0,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        children: [
                          // Animated Menu Button
                          InkWell(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            borderRadius: BorderRadius.circular(15),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 46,
                              height: 46,
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
                                size: 24,
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Animated Logo & Title
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 36,
                                      height: 36,
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
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 400),
                                      transitionBuilder: (child, animation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(0, -0.3),
                                              end: Offset.zero,
                                            ).animate(
                                              CurvedAnimation(
                                                parent: animation,
                                                curve: Curves.easeOutCubic,
                                              ),
                                            ),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        _titles[_selectedIndex],
                                        key: ValueKey(_selectedIndex),
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
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
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    _selectedIndex == 0
                                        ? "Welcome back! 👋"
                                        : _selectedIndex == 1
                                        ? "Explore amazing products ✨"
                                        : _selectedIndex == 2
                                        ? "Browse categories 🛍️"
                                        : "Manage your account 👤",
                                    key: ValueKey(_selectedIndex),
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.9),
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Action Icons
                          Row(
                            children: [
                              // Notification Button
                              Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 46,
                                    height: 46,
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
                                        size: 24,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Positioned(
                                    top: 14,
                                    right: 14,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
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

                              const SizedBox(width: 12),

                              // Cart Button
                              Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 46,
                                    height: 46,
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
                                        size: 24,
                                        color: _appBarGradients[_selectedIndex],
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) =>
                                            const CartScreen(),
                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                              final slide = Tween<Offset>(
                                                begin: const Offset(1.0, 0.0),
                                                end: Offset.zero,
                                              ).animate(
                                                CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves.easeOutCubic,
                                                ),
                                              );
                                              final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
                                                CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves.easeIn,
                                                ),
                                              );
                                              return FadeTransition(
                                                opacity: fade,
                                                child: SlideTransition(
                                                  position: slide,
                                                  child: child,
                                                ),
                                              );
                                            },
                                            transitionDuration: const Duration(milliseconds: 500),
                                          ),
                                        ).then((value) {
                                          if (value != null && value is int) {
                                            _updateCartCount(value);
                                          }
                                        });
                                      },
                                    ),
                                  ),

                                  // Cart Badge
                                  if (_cartItemCount > 0)
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 300),
                                        transitionBuilder: (child, animation) {
                                          return ScaleTransition(
                                            scale: animation,
                                            child: RotationTransition(
                                              turns: Tween<double>(begin: 0.5, end: 1.0).animate(
                                                CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves.elasticOut,
                                                ),
                                              ),
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          key: ValueKey(_cartItemCount),
                                          width: 22,
                                          height: 22,
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
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                              ),
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
            );
          },
        ),
      ),
      drawer: const AppDrawer(),
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
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -5),
            ),
            BoxShadow(
              color: _appBarGradients[_selectedIndex].withOpacity(0.1),
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
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: _appBarGradients[_selectedIndex],
            unselectedItemColor: Colors.grey.shade500,
            showUnselectedLabels: false,
            selectedLabelStyle: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: _selectedIndex == 0
                        ? LinearGradient(
                      colors: [
                        _appBarGradients[0],
                        _appBarGradients[0].withOpacity(0.8),
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
                        color: _appBarGradients[0].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                        : null,
                  ),
                  child: Icon(
                    _selectedIndex == 0 ? Icons.dashboard_rounded : Icons.dashboard_outlined,
                    size: _selectedIndex == 0 ? 24 : 22,
                    color: _selectedIndex == 0 ? Colors.white : Colors.grey.shade500,
                  ),
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: _selectedIndex == 1
                        ? LinearGradient(
                      colors: [
                        _appBarGradients[1],
                        _appBarGradients[1].withOpacity(0.8),
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
                        color: _appBarGradients[1].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                        : null,
                  ),
                  child: Icon(
                    _selectedIndex == 1 ? Icons.storefront_rounded : Icons.storefront_outlined,
                    size: _selectedIndex == 1 ? 24 : 22,
                    color: _selectedIndex == 1 ? Colors.white : Colors.grey.shade500,
                  ),
                ),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: _selectedIndex == 2
                        ? LinearGradient(
                      colors: [
                        _appBarGradients[2],
                        _appBarGradients[2].withOpacity(0.8),
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
                        color: _appBarGradients[2].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                        : null,
                  ),
                  child: Icon(
                    _selectedIndex == 2 ? Icons.category_rounded : Icons.category_outlined,
                    size: _selectedIndex == 2 ? 24 : 22,
                    color: _selectedIndex == 2 ? Colors.white : Colors.grey.shade500,
                  ),
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: _selectedIndex == 3
                        ? LinearGradient(
                      colors: [
                        _appBarGradients[3],
                        _appBarGradients[3].withOpacity(0.8),
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
                        color: _appBarGradients[3].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                        : null,
                  ),
                  child: Icon(
                    _selectedIndex == 3 ? Icons.person_rounded : Icons.person_outline,
                    size: _selectedIndex == 3 ? 24 : 22,
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