import 'package:ecommerce_app/data/product_data.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  ProductProvider() {
    // Initialize with dummy data
    _products = [...dummyProducts];
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final index = _products.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _products[index] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }
  
  // Filter by category
  List<Product> findByCategory(String category) {
    if (category == 'All') return _products;
    return _products.where((prod) => prod.category == category).toList();
  }
}
