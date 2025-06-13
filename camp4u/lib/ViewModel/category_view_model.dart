import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class Category {
  final int id;
  final String name;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: "assets/images/" + (json['image_url'] ?? ''), // Assuming icon is a local asset
    );
  }
}

class CategoryViewModel with ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = false;
  String _error = '';

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get error => _error;

  String get _baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000'; // For web
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000'; // For Android emulator
    } else {
      return 'http://localhost:8000'; // For other platforms
    }
  }

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final response = await http
          .get(
            Uri.parse('$_baseUrl/home'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException('Connection timeout'),
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('categories')) {
          _categories =
              (data['categories'] as List)
                  .map((item) => Category.fromJson(item))
                  .toList();
          _error = '';
        } else {
          _error = 'Invalid response format';
        }
      } else {
        _error = 'Failed to load categories: ${response.statusCode}';
        print('Response body: ${response.body}');
      }
    } on SocketException catch (e) {
      _error = 'Network error: Please check your connection';
      print('Socket Exception: $e');
    } on TimeoutException catch (e) {
      _error = 'Connection timeout: Please try again';
      print('Timeout Exception: $e');
    } catch (e) {
      _error = 'Error: ${e.toString()}';
      print('Unexpected error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
