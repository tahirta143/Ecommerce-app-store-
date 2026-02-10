import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ecommerce_app/screens/auth/login_screen.dart';
import 'dart:math';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  late AnimationController _mainController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;

  // Lottie animation file names from your assets/lottie folder
  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Welcome to\nShopWave",
      "description": "Discover premium products at amazing prices. Your curated shopping experience begins here.",
      "lottieAsset": "assets/lottie/Welcome.json",
      "primaryColor": const Color(0xFF7C3AED),
      "secondaryColor": const Color(0xFF8B5CF6),
      "accentColor": const Color(0xFFF59E0B),
      "gradient": [
        const Color(0xFF7C3AED),
        const Color(0xFF8B5CF6),
      ],
    },
    {
      "title": "Fast & Reliable\nDelivery",
      "description": "Get your orders delivered swiftly. We prioritize your time and convenience with express shipping.",
      "lottieAsset": "assets/lottie/fastorder.json",
      "primaryColor": const Color(0xFF2563EB),
      "secondaryColor": const Color(0xFF3B82F6),
      "accentColor": const Color(0xFF10B981),
      "gradient": [
        const Color(0xFF2563EB),
        const Color(0xFF3B82F6),
      ],
    },
    {
      "title": "Secure & Safe\nPayments",
      "description": "Shop with confidence using our encrypted payment system with multiple secure options.",
      "lottieAsset": "assets/lottie/safe.json",
      "primaryColor": const Color(0xFFDC2626),
      "secondaryColor": const Color(0xFFEF4444),
      "accentColor": const Color(0xFFEC4899),
      "gradient": [
        const Color(0xFFDC2626),
        const Color(0xFFEF4444),
      ],
    },
    {
      "title": "Personalized\nExperience",
      "description": "Get smart recommendations tailored to your unique style and preferences.",
      "lottieAsset": "assets/lottie/experience.json",
      "primaryColor": const Color(0xFF059669),
      "secondaryColor": const Color(0xFF10B981),
      "accentColor": const Color(0xFFFBBF24),
      "gradient": [
        const Color(0xFF059669),
        const Color(0xFF10B981),
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.05), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _mainController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: Curves.linear,
      ),
    );

    _mainController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _mainController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ));
          return SlideTransition(
            position: slide,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Subtle animated background pattern
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  final page = _pageController.hasClients ? _pageController.page ?? _currentPage.toDouble() : _currentPage.toDouble();
                  return CustomPaint(
                    painter: _SubtlePatternPainter(
                      pageOffset: page,
                      color: _onboardingData[_currentPage]["accentColor"]!,
                    ),
                  );
                },
              ),
            ),

            Column(
              children: [
                // Header with logo
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo with simple icon
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: _onboardingData[_currentPage]["gradient"],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "ShopWave",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1F2937),
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),

                      // Skip button
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _currentPage == _onboardingData.length - 1 ? 0 : 1,
                        child: TextButton(
                          onPressed: _navigateToLogin,
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF6B7280),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            "Skip",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Page indicators
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                          (index) => _buildPageIndicator(index),
                    ),
                  ),
                ),

                // Animated cards area with Lottie
                Expanded(
                  flex: 4,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                        _mainController.reset();
                        _mainController.forward();
                      });
                    },
                    physics: const BouncingScrollPhysics(),
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      final pageOffset = index - (_pageController.page ?? _currentPage.toDouble());
                      final scale = 1 - (pageOffset.abs() * 0.15);
                      final opacity = 1 - (pageOffset.abs() * 0.4);

                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(pageOffset * 0.08)
                              ..scale(scale),
                            alignment: Alignment.center,
                            child: Opacity(
                              opacity: opacity.clamp(0.5, 1.0),
                              child: _buildOnboardingCard(index),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Action button with simple icon
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 40,
                    top: 20,
                  ),
                  child: AnimatedBuilder(
                    animation: _mainController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _fadeAnimation.value * 10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: _currentPage == _onboardingData.length - 1
                                ? _navigateToLogin
                                : () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOutCubic,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _onboardingData[_currentPage]["primaryColor"],
                              foregroundColor: Colors.white,
                              elevation: 6,
                              shadowColor: _onboardingData[_currentPage]["primaryColor"]!.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Row(
                                key: ValueKey(_currentPage),
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _currentPage == _onboardingData.length - 1
                                        ? "Get Started"
                                        : "Continue",
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(
                                    _currentPage == _onboardingData.length - 1
                                        ? Icons.arrow_forward_rounded
                                        : Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingCard(int index) {
    final data = _onboardingData[index];

    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F2937).withOpacity(0.1),
              blurRadius: 32,
              spreadRadius: 0,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: data["primaryColor"]!.withOpacity(0.08),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            // Background gradient accent
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: CustomPaint(
                  painter: _CardGradientPainter(
                    color: data["primaryColor"]!,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Lottie animation container
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110),
                      boxShadow: [
                        BoxShadow(
                          color: data["primaryColor"]!.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Lottie.asset(
                      data["lottieAsset"],
                      width: 220,
                      height: 220,
                      fit: BoxFit.contain,
                      repeat: true,
                      animate: true,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Title
                  Text(
                    data["title"],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1F2937),
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      data["description"],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Animated progress dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 3; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: i == 0 ? 12 : 8,
                          height: i == 0 ? 12 : 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: i == 0 ? data["accentColor"] : Colors.grey.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
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

  Widget _buildPageIndicator(int index) {
    final isCurrent = index == _currentPage;
    final data = _onboardingData[index];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: isCurrent ? 32 : 8,
      curve: Curves.easeInOutCubic,
      decoration: BoxDecoration(
        gradient: isCurrent
            ? LinearGradient(
          colors: data["gradient"],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
            : null,
        color: isCurrent ? null : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _SubtlePatternPainter extends CustomPainter {
  final double pageOffset;
  final Color color;

  _SubtlePatternPainter({required this.pageOffset, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.02)
      ..style = PaintingStyle.fill;

    final gridSize = 60.0;
    for (double x = 0; x < size.width; x += gridSize) {
      for (double y = 0; y < size.height; y += gridSize) {
        final offsetX = x + sin(pageOffset + y * 0.01) * 5;
        final offsetY = y + cos(pageOffset + x * 0.01) * 5;

        canvas.drawCircle(
          Offset(offsetX, offsetY),
          1.5,
          paint..color = color.withOpacity(0.03 + sin(pageOffset + x + y) * 0.01),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _CardGradientPainter extends CustomPainter {
  final Color color;

  _CardGradientPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [
        color.withOpacity(0.03),
        color.withOpacity(0.01),
        Colors.transparent,
      ],
      stops: const [0.0, 0.3, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..shader = gradient.createShader(rect);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}