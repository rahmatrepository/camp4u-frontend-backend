import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Model/product_model.dart';

class ProductViewModel with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
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
        Uri.parse('$_baseUrl/products/$categoryId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('products')) {
          _products =
              (data['products'] as List)
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
}
