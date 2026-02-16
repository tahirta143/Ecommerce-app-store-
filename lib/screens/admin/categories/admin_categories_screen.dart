import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCategoriesScreen extends StatefulWidget {
  const AdminCategoriesScreen({super.key});

  @override
  State<AdminCategoriesScreen> createState() => _AdminCategoriesScreenState();
}

class _AdminCategoriesScreenState extends State<AdminCategoriesScreen> {
  // Sample categories data for UI demonstration
  List<String> _categories = [
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Beauty',
    'Sports',
    'Toys',
    'Books',
    'Automotive',
    'Grocery',
    'Health',
  ];

  final TextEditingController _controller = TextEditingController();

  // Color theme
  static const Color _primaryColor = Color(0xFF6366F1);
  static const Color _surfaceColor = Color(0xFFF8FAFC);
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _errorColor = Color(0xFFEF4444);

  void _addCategory() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _categories.add(_controller.text);
        _controller.clear();
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Category added successfully!',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: _primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _deleteCategory(String category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: _errorColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Delete Category',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "$category"?',
          style: GoogleFonts.poppins(
            color: _textSecondary,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: _textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _categories.remove(category);
              });
              Navigator.pop(context);

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Category deleted successfully!',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: _errorColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _errorColor,
              foregroundColor: _white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    return Scaffold(
      backgroundColor: _surfaceColor,
      appBar: AppBar(
        title: Text(
          "Manage Categories",
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
      ),
      body: Column(
        children: [
          // Stats Section
          Container(
            padding: EdgeInsets.all(isDesktop ? 24 : (isTablet ? 20 : 16)),
            child: Row(
              children: [
                _buildStatCard(
                  title: "Total Categories",
                  value: _categories.length.toString(),
                  icon: Icons.category,
                  color: _primaryColor,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  title: "Active",
                  value: _categories.length.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  title: "Products",
                  value: "1,234",
                  icon: Icons.inventory,
                  color: Colors.orange,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
              ],
            ),
          ),

          // Add Category Section
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: isDesktop ? 24 : (isTablet ? 20 : 16),
            ),
            padding: EdgeInsets.all(isDesktop ? 24 : (isTablet ? 20 : 16)),
            decoration: BoxDecoration(
              color: _white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Category',
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 18 : (isTablet ? 16 : 15),
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _surfaceColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "Enter category name",
                            hintStyle: GoogleFonts.poppins(
                              color: _textSecondary.withOpacity(0.5),
                              fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                            ),
                            prefixIcon: Icon(
                              Icons.category_outlined,
                              color: _primaryColor,
                              size: isDesktop ? 24 : 20,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: isDesktop ? 16 : (isTablet ? 14 : 12),
                            ),
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                          ),
                          onSubmitted: (_) => _addCategory(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: isDesktop ? 56 : (isTablet ? 52 : 48),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_primaryColor, const Color(0xFF8B5CF6)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: _primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _addCategory,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: _white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 24 : (isTablet ? 20 : 16),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: isDesktop ? 20 : 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Add',
                              style: GoogleFonts.poppins(
                                fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Categories List Header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 24 : (isTablet ? 20 : 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Categories',
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 18 : (isTablet ? 16 : 15),
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                ),
                Text(
                  '${_categories.length} items',
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                    color: _textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Categories List
          Expanded(
            child: _categories.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.category_outlined,
                      size: isDesktop ? 80 : (isTablet ? 70 : 60),
                      color: _primaryColor.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Categories Yet',
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 20 : (isTablet ? 18 : 16),
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add your first category using the form above',
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                      color: _textSecondary,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.all(isDesktop ? 24 : (isTablet ? 20 : 16)),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return _buildCategoryCard(
                  context,
                  category,
                  index,
                  isDesktop,
                  isTablet,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDesktop,
    required bool isTablet,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(isDesktop ? 20 : (isTablet ? 16 : 12)),
        decoration: BoxDecoration(
          color: _white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: isDesktop ? 24 : (isTablet ? 22 : 20),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 28 : (isTablet ? 24 : 22),
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                color: _textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context,
      String category,
      int index,
      bool isDesktop,
      bool isTablet,
      ) {
    // Sample product count for each category
    final productCount = (index + 1) * 23;

    return Container(
      margin: EdgeInsets.only(bottom: isDesktop ? 12 : 8),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to category details
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 16 : 12),
            child: Row(
              children: [
                // Category Icon
                Container(
                  width: isDesktop ? 50 : (isTablet ? 45 : 40),
                  height: isDesktop ? 50 : (isTablet ? 45 : 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getCategoryColor(index).withOpacity(0.7),
                        _getCategoryColor(index).withOpacity(0.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _getCategoryIcon(index),
                    color: _white,
                    size: isDesktop ? 24 : (isTablet ? 22 : 20),
                  ),
                ),
                const SizedBox(width: 16),

                // Category Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 16 : (isTablet ? 15 : 14),
                          fontWeight: FontWeight.w600,
                          color: _textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$productCount products',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                          color: _textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Delete Button
                Container(
                  decoration: BoxDecoration(
                    color: _errorColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_rounded,
                      color: _errorColor,
                      size: isDesktop ? 22 : 20,
                    ),
                    onPressed: () => _deleteCategory(category),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(int index) {
    final colors = [
      _primaryColor,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.amber,
      Colors.indigo,
      Colors.cyan,
      Colors.brown,
    ];
    return colors[index % colors.length];
  }

  IconData _getCategoryIcon(int index) {
    final icons = [
      Icons.devices_rounded,
      Icons.checkroom_rounded,
      Icons.home_rounded,
      Icons.face_retouching_natural_rounded,
      Icons.sports_soccer_rounded,
      Icons.toys_rounded,
      Icons.menu_book_rounded,
      Icons.directions_car_rounded,
      Icons.shopping_cart_rounded,
      Icons.health_and_safety_rounded,
    ];
    return icons[index % icons.length];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}