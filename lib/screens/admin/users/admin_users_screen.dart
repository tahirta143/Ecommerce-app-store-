import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Move User class outside the AdminUsersScreen class
enum Role { admin, user, moderator }

class User {
  final String name;
  final String email;
  final Role role;

  User({
    required this.name,
    required this.email,
    required this.role,
  });
}

class AdminUsersScreen extends StatelessWidget {
  AdminUsersScreen({super.key});

  // Sample users data for UI demonstration
  final List<User> _users = [
    User(name: 'John Doe', email: 'john.doe@example.com', role: Role.admin),
    User(name: 'Jane Smith', email: 'jane.smith@example.com', role: Role.user),
    User(name: 'Bob Johnson', email: 'bob.johnson@example.com', role: Role.moderator),
    User(name: 'Alice Williams', email: 'alice.williams@example.com', role: Role.user),
    User(name: 'Charlie Brown', email: 'charlie.brown@example.com', role: Role.user),
    User(name: 'Diana Prince', email: 'diana.prince@example.com', role: Role.admin),
    User(name: 'Eve Adams', email: 'eve.adams@example.com', role: Role.moderator),
    User(name: 'Frank Miller', email: 'frank.miller@example.com', role: Role.user),
  ];

  // Color theme
  static const Color _primaryColor = Color(0xFF6366F1);
  static const Color _surfaceColor = Color(0xFFF8FAFC);
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textSecondary = Color(0xFF64748B);
  static const Color _white = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    return Scaffold(
      backgroundColor: _surfaceColor,
      appBar: AppBar(
        title: Text(
          "Manage Users",
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
          // Search button
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              // Implement search functionality
            },
          ),
          // Filter button
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              // Implement filter functionality
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Stats Section
          Container(
            padding: EdgeInsets.all(isDesktop ? 24 : (isTablet ? 20 : 16)),
            child: Row(
              children: [
                _buildStatCard(
                  title: "Total Users",
                  value: _users.length.toString(),
                  icon: Icons.people,
                  color: _primaryColor,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  title: "Admins",
                  value: _users.where((u) => u.role == Role.admin).length.toString(),
                  icon: Icons.admin_panel_settings,
                  color: Colors.purple,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  title: "Moderators",
                  value: _users.where((u) => u.role == Role.moderator).length.toString(),
                  icon: Icons.verified_user,
                  color: Colors.blue,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),
              ],
            ),
          ),

          // Users List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(isDesktop ? 24 : (isTablet ? 20 : 16)),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return _buildUserCard(
                  context,
                  user,
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

  Widget _buildUserCard(
      BuildContext context,
      User user,
      int index,
      bool isDesktop,
      bool isTablet,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: isDesktop ? 16 : 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to user details
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 16 : 12),
            child: Row(
              children: [
                // User Avatar
                Container(
                  width: isDesktop ? 70 : (isTablet ? 60 : 50),
                  height: isDesktop ? 70 : (isTablet ? 60 : 50),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _getRoleColor(user.role).withOpacity(0.3),
                        _getRoleColor(user.role).withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 28 : (isTablet ? 24 : 20),
                        fontWeight: FontWeight.w600,
                        color: _getRoleTextColor(user.role),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // User Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 18 : (isTablet ? 16 : 15),
                          fontWeight: FontWeight.w600,
                          color: _textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 14 : (isTablet ? 13 : 12),
                          color: _textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Role badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getRoleColor(user.role),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          user.role.name.toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop ? 12 : 11,
                            fontWeight: FontWeight.w600,
                            color: _getRoleTextColor(user.role),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Action buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit_rounded,
                          color: Colors.blue,
                          size: isDesktop ? 22 : 20,
                        ),
                        onPressed: () {
                          _showEditUserDialog(context, user);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
                          size: isDesktop ? 22 : 20,
                        ),
                        onPressed: () {
                          _showDeleteUserDialog(context, user);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(Role role) {
    switch (role) {
      case Role.admin:
        return Colors.purple.withOpacity(0.15);
      case Role.moderator:
        return Colors.blue.withOpacity(0.15);
      case Role.user:
        return Colors.green.withOpacity(0.15);
    }
  }

  Color _getRoleTextColor(Role role) {
    switch (role) {
      case Role.admin:
        return Colors.purple.shade800;
      case Role.moderator:
        return Colors.blue.shade800;
      case Role.user:
        return Colors.green.shade800;
    }
  }

  void _showEditUserDialog(BuildContext context, User user) {
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
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_rounded,
                color: Colors.blue,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Edit User',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          'Edit functionality for ${user.name} will be implemented here.',
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
              'Close',
              style: GoogleFonts.poppins(
                color: _textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteUserDialog(BuildContext context, User user) {
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
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Delete User',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete ${user.name}? This action cannot be undone.',
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
              Navigator.pop(context);
              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${user.name} has been deleted.',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
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
}