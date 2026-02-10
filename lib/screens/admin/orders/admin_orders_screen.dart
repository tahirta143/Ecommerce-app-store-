import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<AdminProvider>(context).orders;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
           margin: const EdgeInsets.only(bottom: 12),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
           child: ExpansionTile(
             title: Text("Order #${order.id}", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
             subtitle: Text("${order.userName} - \$${order.totalAmount}", style: GoogleFonts.poppins()),
             trailing: Chip(
               label: Text(order.status.name),
               backgroundColor: _getStatusColor(order.status).withOpacity(0.2),
             ),
             children: [
               Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("Date: ${DateFormat('yyyy-MM-dd').format(order.date)}"),
                     const SizedBox(height: 10),
                     Text("Change Status:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                     Wrap(
                       spacing: 8,
                       children: OrderStatus.values.map((status) {
                         return ActionChip(
                           label: Text(status.name),
                           onPressed: () {
                              Provider.of<AdminProvider>(context, listen: false).updateOrderStatus(order.id, status);
                           },
                           backgroundColor: order.status == status ? _getStatusColor(status) : Colors.grey[200],
                         );
                       }).toList(),
                     )
                   ],
                 ),
               )
             ],
           ),
        );
      },
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending: return Colors.orange;
      case OrderStatus.processing: return Colors.blue;
      case OrderStatus.shipped: return Colors.indigo;
      case OrderStatus.delivered: return Colors.green;
      case OrderStatus.cancelled: return Colors.red;
    }
  }
}
