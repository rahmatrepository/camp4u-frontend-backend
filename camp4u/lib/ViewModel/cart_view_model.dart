import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Model/cart_model.dart';

class CartViewModel with ChangeNotifier {
  List<CartItem> _items = [];
  bool _isLoading = false;
  String _error = '';
  String? _authToken;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  String get error => _error;

  void setAuthToken(String token) {
    _authToken = token;
    if (_authToken != null && _authToken!.isNotEmpty) {
      fetchCartItems(null); // We'll get user ID from the token
    } else {
      _items.clear();
      notifyListeners();
    }
  }

  String get _baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000';
    } else {
      return 'http://10.0.2.2:8000';
    }
  }

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (_authToken != null && _authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  Future<bool> addToCart({
    required int userId,
    required int productId,
    required String name,
    required double price,
    required String image,
    required int quantity,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      if (_authToken == null || _authToken!.isEmpty) {
        _error = 'Please login first';
        notifyListeners();
        return false;
      }

      _isLoading = true;
      notifyListeners();

      final rentalDays = endDate.difference(startDate).inDays + 1;
      final subtotal = price * quantity * rentalDays;

      final response = await http.post(
        Uri.parse('$_baseUrl/cart/add'),
        headers: _headers,
        body: jsonEncode({
          'user_id': userId,
          'product_id': productId,
          'quantity': quantity,
          'start_date': startDate.toIso8601String(),
          'end_date': endDate.toIso8601String(),
          'name': name,
          'price': price,
          'image': image,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final cartItem = CartItem(
          id: data['id'],
          userId: userId,
          productId: productId,
          name: name,
          price: price,
          image: image,
          quantity: quantity,
          startDate: startDate,
          endDate: endDate,
          subtotal: subtotal,
        );

        _items.add(cartItem);
        _error = '';
        notifyListeners();
        return true;
      } else {
        final data = jsonDecode(response.body);
        _error = data['detail'] ?? 'Failed to add item to cart';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCartItems(int? userId) async {
    try {
      if (_authToken == null || _authToken!.isEmpty) {
        _error = 'Please login first';
        _items.clear();
        notifyListeners();
        return;
      }

      _isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse('$_baseUrl/cart/user/${userId ?? "me"}'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _items = data.map((json) => CartItem.fromJson(json)).toList();
        _error = '';
      } else if (response.statusCode == 401) {
        _error = 'Please login first';
        _items.clear();
      } else {
        final data = jsonDecode(response.body);
        _error = data['detail'] ?? 'Failed to fetch cart items';
      }
    } catch (e) {
      _error = e.toString();
      _items.clear();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateCartItem(CartItem item) async {
    try {
      if (_authToken == null || _authToken!.isEmpty) {
        _error = 'Please login first';
        notifyListeners();
        return false;
      }

      _isLoading = true;
      notifyListeners();

      final rentalDays = item.endDate.difference(item.startDate).inDays + 1;
      item.subtotal = item.price * item.quantity * rentalDays;

      final response = await http.put(
        Uri.parse('$_baseUrl/cart/${item.id}'),
        headers: _headers,
        body: jsonEncode(item.toJson()),
      );

      if (response.statusCode == 200) {
        final index = _items.indexWhere((i) => i.id == item.id);
        if (index >= 0) {
          _items[index] = item;
        }
        _error = '';
        notifyListeners();
        return true;
      } else {
        final data = jsonDecode(response.body);
        _error = data['detail'] ?? 'Failed to update cart item';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> removeFromCart(int itemId) async {
    try {
      if (_authToken == null || _authToken!.isEmpty) {
        _error = 'Please login first';
        notifyListeners();
        return false;
      }

      _isLoading = true;
      notifyListeners();

      final response = await http.delete(
        Uri.parse('$_baseUrl/cart/$itemId'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        _items.removeWhere((item) => item.id == itemId);
        _error = '';
        notifyListeners();
        return true;
      } else {
        final data = jsonDecode(response.body);
        _error = data['detail'] ?? 'Failed to remove item from cart';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
