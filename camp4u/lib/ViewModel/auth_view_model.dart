import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'cart_view_model.dart';
import '../Model/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  User? _user;
  String? _token;
  bool _isLoading = false;
  String _error = '';

  User? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isLoggedIn => _token != null;

  String get _baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000';
    } else {
      return 'http://10.0.2.2:8000';
    }
  }

  Future<bool> login(
      BuildContext context, String username, String password) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      if (username.isEmpty || password.isEmpty) {
        _error = 'Username dan password harus diisi';
        return false;
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'username': username,
          'password': password,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _token = data['access_token'];
        _user = User(
          id: data['id'],
          username: data['username'],
          email: data['email'],
          fullName: data['full_name'],
          phoneNumber: data['phone_number'],
          createdAt: DateTime.parse(data['created_at']),
          updatedAt: DateTime.parse(data['updated_at']),
        );

        if (context.mounted) {
          final cartViewModel =
              Provider.of<CartViewModel>(context, listen: false);
          cartViewModel.setAuthToken(_token!);
        }

        notifyListeners();
        return true;
      } else {
        _error = data['detail'] ?? 'Username atau password salah';
        return false;
      }
    } catch (e) {
      _error = 'Terjadi kesalahan: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register({
    required String username,
    required String email,
    required String password,
    String? fullName,
    String? phoneNumber,
    String? profilePicture,
  }) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final response = await http.post(
        Uri.parse('$_baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'full_name': fullName,
          'phone_number': phoneNumber,
          'profile_picture': profilePicture,
        }),
      );

      if (response.statusCode == 201) {
        notifyListeners();
        return true;
      } else {
        final data = jsonDecode(response.body);
        _error = data['detail'] ?? 'Registration failed';
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

  Future<bool> updateProfile({
    required String fullName,
    required String username,
    required String phoneNumber,
  }) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final response = await http.put(
        Uri.parse('$_baseUrl/auth/profile/update'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({
          'full_name': fullName,
          'username': username,
          'phone_number': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _user = User(
          id: _user!.id,
          username: username,
          email: _user!.email,
          fullName: fullName,
          phoneNumber: phoneNumber,
          createdAt: _user!.createdAt,
          updatedAt: DateTime.parse(data['updated_at']),
        );
        notifyListeners();
        return true;
      } else {
        final data = jsonDecode(response.body);
        _error = data['detail'] ?? 'Failed to update profile';
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

  void logout(BuildContext context) {
    _user = null;
    _token = null;

    if (context.mounted) {
      final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
      cartViewModel.setAuthToken('');
    }

    notifyListeners();
  }
}
