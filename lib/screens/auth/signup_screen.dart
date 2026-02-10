import 'package:ecommerce_app/screens/dashboard/main_wrapper.dart';
import 'package:ecommerce_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeToTerms = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.05), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 375;
    final isLargeScreen = screenWidth > 600;
    final isTablet = screenWidth > 768;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background gradient decoration
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _SignupBackgroundPainter(
                    animationValue: _controller.value,
                  ),
                );
              },
            ),
          ),

          // Top Gradient Color Section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF7C3AED),
                    const Color(0xFF8B5CF6),
                    const Color(0xFFA78BFA),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 40 : 24,
                    vertical: isSmallScreen ? 16 : 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      _buildBackButton(context),

                      SizedBox(height: isSmallScreen ? 20 : 30),

                      // Title and subtitle
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _slideAnimation.value),
                            child: Opacity(
                              opacity: _fadeAnimation.value,
                              child: child,
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create Account",
                              style: GoogleFonts.poppins(
                                fontSize: isSmallScreen ? 28 : isTablet ? 36 : 34,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 8 : 12),
                            Text(
                              "Join our community and start your shopping journey",
                              style: GoogleFonts.poppins(
                                fontSize: isSmallScreen ? 14 : 16,
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom Card-like Form (Overlay on top)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _slideAnimation.value * 0.5),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    ),
                  ),
                );
              },
              child: Container(
                height: screenHeight * 0.68, // Adjusted height
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 40,
                      spreadRadius: 5,
                      offset: const Offset(0, -10),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 40 : 24,
                    vertical: isSmallScreen ? 24 : 32,
                  ),
                  child: _buildSignupForm(context, isSmallScreen, isLargeScreen),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSignupForm(BuildContext context, bool isSmallScreen, bool isLargeScreen) {
    return Column(
      children: [
        // Full Name field
        _buildTextField(
          controller: _nameController,
          label: "Full Name",
          prefixIcon: Icons.person_rounded,
          isSmallScreen: isSmallScreen,
        ),

        SizedBox(height: isSmallScreen ? 16 : 20),

        // Email field
        _buildTextField(
          controller: _emailController,
          label: "Email Address",
          prefixIcon: Icons.email_rounded,
          keyboardType: TextInputType.emailAddress,
          isSmallScreen: isSmallScreen,
        ),

        SizedBox(height: isSmallScreen ? 16 : 20),

        // Password field
        _buildPasswordField(
          controller: _passwordController,
          label: "Password",
          isPasswordVisible: _isPasswordVisible,
          onToggleVisibility: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          isSmallScreen: isSmallScreen,
        ),

        SizedBox(height: isSmallScreen ? 16 : 20),

        // Confirm Password field
        _buildPasswordField(
          controller: _confirmPasswordController,
          label: "Confirm Password",
          isPasswordVisible: _isConfirmPasswordVisible,
          onToggleVisibility: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
          isSmallScreen: isSmallScreen,
        ),

        SizedBox(height: isSmallScreen ? 16 : 20),

        // Terms and conditions
        Row(
          children: [
            Checkbox(
              value: _agreeToTerms,
              onChanged: (value) {
                setState(() {
                  _agreeToTerms = value ?? false;
                });
              },
              activeColor: const Color(0xFF7C3AED),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _agreeToTerms = !_agreeToTerms;
                  });
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "I agree to the ",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF374151),
                          fontSize: isSmallScreen ? 13 : 15,
                        ),
                      ),
                      TextSpan(
                        text: "Terms & Conditions ",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF7C3AED),
                          fontSize: isSmallScreen ? 13 : 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "and ",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF374151),
                          fontSize: isSmallScreen ? 13 : 15,
                        ),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF7C3AED),
                          fontSize: isSmallScreen ? 13 : 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: isSmallScreen ? 24 : 32),

        // Sign Up button
        SizedBox(
          width: double.infinity,
          height: isSmallScreen ? 54 : 58,
          child: ElevatedButton(
            onPressed: _agreeToTerms ? () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                  const MainWrapper(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
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
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C3AED),
              foregroundColor: Colors.white,
              elevation: 5,
              shadowColor: const Color(0xFF7C3AED).withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 18),
              ),
              disabledBackgroundColor: const Color(0xFF7C3AED).withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(width: isSmallScreen ? 10 : 12),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: isSmallScreen ? 20 : 22,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: isSmallScreen ? 24 : 32),

        // Divider
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16),
              child: Text(
                "Or sign up with",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B7280),
                  fontSize: isSmallScreen ? 13 : 15,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 1,
              ),
            ),
          ],
        ),

        SizedBox(height: isSmallScreen ? 24 : 32),

        // Google signup button only
        // SizedBox(
        //   width: double.infinity,
        //   height: isSmallScreen ? 54 : 58,
        //   child: OutlinedButton(
        //     onPressed: () {
        //       // Google sign up logic
        //     },
        //     style: OutlinedButton.styleFrom(
        //       foregroundColor: const Color(0xFF374151),
        //       side: BorderSide(
        //         color: Colors.grey.withOpacity(0.3),
        //         width: 1,
        //       ),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 18),
        //       ),
        //     ),
        //     // child: Row(
        //     //   mainAxisAlignment: MainAxisAlignment.center,
        //     //   children: [
        //     //     Icon(
        //     //       Icons.g_mobiledata_rounded,
        //     //       color: const Color(0xFFDB4437),
        //     //       size: isSmallScreen ? 24 : 26,
        //     //     ),
        //     //     SizedBox(width: isSmallScreen ? 12 : 14),
        //     //     Text(
        //     //       "Continue with Google",
        //     //       style: GoogleFonts.poppins(
        //     //         fontSize: isSmallScreen ? 15 : 17,
        //     //         fontWeight: FontWeight.w500,
        //     //       ),
        //     //     ),
        //     //   ],
        //     // ),
        //   ),
        // ),

        // SizedBox(height: isSmallScreen ? 28 : 36),

        // Login link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: GoogleFonts.poppins(
                color: const Color(0xFF6B7280),
                fontSize: isSmallScreen ? 14 : 16,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    const LoginScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final slide = Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
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
              },
              child: Text(
                "Login",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF7C3AED),
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    required bool isSmallScreen,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFF374151),
            fontSize: isSmallScreen ? 14 : 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: isSmallScreen ? 8 : 10),
        Container(
          height: isSmallScreen ? 52 : 58,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 14),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18, right: isSmallScreen ? 12 : 14),
                child: Icon(
                  prefixIcon,
                  color: const Color(0xFF6B7280),
                  size: isSmallScreen ? 22 : 24,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF1F2937),
                    fontSize: isSmallScreen ? 15 : 17,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your $label",
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xFF9CA3AF),
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 16 : 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isPasswordVisible,
    required VoidCallback onToggleVisibility,
    required bool isSmallScreen,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFF374151),
            fontSize: isSmallScreen ? 14 : 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: isSmallScreen ? 8 : 10),
        Container(
          height: isSmallScreen ? 52 : 58,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 14),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18, right: isSmallScreen ? 12 : 14),
                child: Icon(
                  Icons.lock_rounded,
                  color: const Color(0xFF6B7280),
                  size: isSmallScreen ? 22 : 24,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: !isPasswordVisible,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF1F2937),
                    fontSize: isSmallScreen ? 15 : 17,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your $label",
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xFF9CA3AF),
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 16 : 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: onToggleVisibility,
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: const Color(0xFF6B7280),
                    size: isSmallScreen ? 22 : 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignupBackgroundPainter extends CustomPainter {
  final double animationValue;

  _SignupBackgroundPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [
        const Color(0xFF7C3AED).withOpacity(0.02),
        const Color(0xFF8B5CF6).withOpacity(0.02),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Draw animated circles
    final circlePaint = Paint()..color = const Color(0xFF7C3AED).withOpacity(0.03);

    for (int i = 0; i < 4; i++) {
      final radius = 20.0 + i * 15.0;
      final center = Offset(
        size.width * (0.8 - 0.2 * i),
        size.height * (0.1 + 0.25 * i),
      );

      canvas.drawCircle(
        center,
        radius * (0.5 + 0.5 * sin(animationValue * 2 * pi + i)),
        circlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}