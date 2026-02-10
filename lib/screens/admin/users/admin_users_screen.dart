import 'package:ecommerce_app/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<AdminProvider>(context).users;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Text(user.name[0].toUpperCase()),
            ),
            title: Text(user.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            subtitle: Text(user.email, style: GoogleFonts.poppins()),
            trailing: Chip(
              label: Text(user.role.name.toUpperCase()),
              backgroundColor: user.role.name == 'admin' ? Colors.purple[100] : Colors.blue[100],
            ),
          ),
        );
      },
    );
  }
}
