
import 'package:ecommerce_app/screens/auth/login_screen.dart';
import 'package:ecommerce_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
            ),
            accountName: Text(
              "User Name",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              "user@example.com",
              style: GoogleFonts.poppins(),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: Text("Home", style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.pop(context);
              // Navigate logic if needed, currently already on Home via Wrapper
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined),
            title: Text("Shop", style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.pop(context);
              // Switch tab logic ideally via provider or callback
            },
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: Text("Categories", style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
             leading: const Icon(FontAwesomeIcons.whatsapp),
            title: Text("Contact Support", style: GoogleFonts.poppins()),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              "Sign Out",
              style: GoogleFonts.poppins(color: Colors.red),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
