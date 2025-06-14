import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Model/user_model.dart'; // Pastikan path ini benar

class AuthViewModel extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String _error = '';
  String? _token;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isLoggedIn => _user != null;

  String get _baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000';
    } else {
      return 'http://10.0.2.2:8000';
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();
      print('AuthViewModel: Attempting login for username: $username');

      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print('AuthViewModel: Login response status code: ${response.statusCode}');
      print('AuthViewModel: Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token'];

        // Pastikan pabrik User.fromJson memetakan respons dengan benar.
        // Asumsi backend mengembalikan semua detail pengguna saat login.
        _user = User(
          id: data['id'],
          username: data['username'] ?? username,
          fullName: data['full_name'] ?? username,
          phoneNumber: data['phone_number'] ?? '',
          email: data['email'],
          profilePicture: data['profile_picture'],
          address: data['address'],
          city: data['city'],
          province: data['province'],
          postalCode: data['postal_code'],
          dateOfBirth: data['date_of_birth'] != null
              ? DateTime.parse(data['date_of_birth'])
              : null,
          gender: data['gender'],
          createdAt: DateTime.parse(data['created_at']),
          updatedAt: DateTime.parse(data['updated_at']),
        );
        _error = '';
        print('AuthViewModel: Login successful for user: ${_user?.username}');
        return true;
      } else {
        final data = jsonDecode(response.body);
        _error = data['detail'] ?? 'Invalid username or password';
        print('AuthViewModel: Login failed. Error: $_error');
        return false;
      }
    } catch (e) {
      _error = 'Network or parsing error: $e';
      print('AuthViewModel: Exception during login: $_error');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
      print('AuthViewModel: Login process finished. isLoading: $_isLoading');
    }
  }

  Future<bool> register({
    required String username,
    required String password,
    required String email,
    required String fullName,
    required String phoneNumber,
    String? profilePicture,
    String? address,
    String? city,
    String? province,
    String? postalCode,
    DateTime? dateOfBirth,
    String? gender,
  }) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();
      print('AuthViewModel: Attempting registration for username: $username');

      final response = await http.post(
        Uri.parse('$_baseUrl/auth/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'email': email,
          'full_name': fullName,
          'phone_number': phoneNumber,
          'profile_picture': profilePicture,
          'address': address,
          'city': city,
          'province': province,
          'postal_code': postalCode,
          'date_of_birth': dateOfBirth?.toIso8601String(),
          'gender': gender,
        }),
      );

      print('AuthViewModel: Register response status code: ${response.statusCode}');
      print('AuthViewModel: Register response body: ${response.body}');

      if (response.statusCode == 201) {
        print('AuthViewModel: Registration successful. Attempting auto-login.');
        return await login(username, password); // Coba login otomatis setelah register
      } else {
        final data = jsonDecode(response.body);
        _error = data['detail'] ?? 'Registration failed';
        print('AuthViewModel: Registration failed. Error: $_error');
        return false;
      }
    } catch (e) {
      _error = 'Network or parsing error during registration: $e';
      print('AuthViewModel: Exception during registration: $_error');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
      print('AuthViewModel: Registration process finished. isLoading: $_isLoading');
    }
  }

  void logout() {
    _user = null;
    _token = null;
    _error = '';
    notifyListeners();
    print('AuthViewModel: User logged out.');
  }
}
