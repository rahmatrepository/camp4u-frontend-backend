import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Model/product_model.dart';

class ProductViewModel with ChangeNotifier {
  List<Product> _products = [];
  Product? _selectedProduct;
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  String get error => _error;

  String get _baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000';
    } else {
      return 'http://10.0.2.2:8000';
    }
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final response = await http.get(
        Uri.parse('$_baseUrl/category/$categoryId/products'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('products')) {
          _products = (data['products'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
        } else {
          _error = 'Invalid response format';
        }
      } else {
        _error = 'Failed to load products: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductDetail(int productId) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      print('Fetching product details for ID: $productId');
      final response = await http.get(
        Uri.parse('$_baseUrl/products/$productId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('product')) {
          _selectedProduct = Product.fromJson(data['product']);
          print('Product loaded successfully: ${_selectedProduct?.name}');
        } else {
          _error = 'Invalid response format';
          print('Error: Invalid response format');
        }
      } else {
        _error = 'Failed to load product details: ${response.statusCode}';
        print('Error: Failed to load product details: ${response.statusCode}');
      }
    } catch (e) {
      _error = 'Error: ${e.toString()}';
      print('Error: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSelectedProduct() {
    _selectedProduct = null;
    notifyListeners();
  }
}
