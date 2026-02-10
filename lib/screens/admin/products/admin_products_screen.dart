import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/screens/admin/products/add_edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminProductsScreen extends StatelessWidget {
  const AdminProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEditProductScreen()));
        },
        backgroundColor: const Color(0xFF7C3AED),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                color: Colors.grey[200],
                child: Image.asset(product.image, fit: BoxFit.cover, errorBuilder: (c,o,s) => const Icon(Icons.image)),
              ),
              title: Text(product.title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              subtitle: Text("\$${product.price}", style: GoogleFonts.poppins()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditProductScreen(product: product)));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      Provider.of<ProductProvider>(context, listen: false).deleteProduct(product.id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
