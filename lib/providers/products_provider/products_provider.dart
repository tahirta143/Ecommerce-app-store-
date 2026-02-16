import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/products_model/products_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  Product? _selectedProduct;
  bool _isLoading = false;
  String? _errorMessage;
  int _currentPage = 1;
  bool _hasMorePages = true;
  final int _itemsPerPage = 10;

  // Getters
  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMorePages => _hasMorePages;

  // Base URL
  static const String baseUrl = 'https://backend-with-node-js-ueii.onrender.com/api';

  // Fetch all products
  Future<void> fetchProducts({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _products = [];
      _hasMorePages = true;
    }

    if (!_hasMorePages && !refresh) return;

    _setLoadingState(true);
    _errorMessage = null;

    try {
      final url = Uri.parse('$baseUrl/products?page=$_currentPage&limit=$_itemsPerPage');
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timeout. Please check your internet.');
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final productsResponse = ProductsResponse.fromJson(jsonResponse);

        if (refresh) {
          _products = productsResponse.data;
        } else {
          _products.addAll(productsResponse.data);
        }

        // Check if we have more pages
        _hasMorePages = productsResponse.data.length == _itemsPerPage;
        if (_hasMorePages) _currentPage++;

        notifyListeners();
      } else {
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      print('Error fetching products: $e');
    } finally {
      _setLoadingState(false);
    }
  }

  // Search products
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      await fetchProducts(refresh: true);
      return;
    }

    _setLoadingState(true);
    _errorMessage = null;

    try {
      final url = Uri.parse('$baseUrl/products?search=$query');
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timeout. Please check your internet.');
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final productsResponse = ProductsResponse.fromJson(jsonResponse);

        _products = productsResponse.data;
        _hasMorePages = false; // Disable pagination for search results
        notifyListeners();
      } else {
        throw Exception('Failed to search products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      print('Error searching products: $e');
    } finally {
      _setLoadingState(false);
    }
  }

  // Helper method to set loading state
  void _setLoadingState(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}