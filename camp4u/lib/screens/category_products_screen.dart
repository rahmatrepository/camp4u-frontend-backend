import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/product_view_model.dart';
import '../Model/product_model.dart';
import 'product_detail_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryProductsScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late ProductViewModel _productViewModel;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
      _productViewModel.fetchProductsByCategory(widget.categoryId);
      _isInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _navigateToProductDetail(
      BuildContext context, Product product) async {
    final navigator = Navigator.of(context); // simpan sebelum async
    final messenger = ScaffoldMessenger.of(context); // simpan sebelum async

    try {
      print('Tapped product: ${product.id} - ${product.name}');
      await _productViewModel.fetchProductDetail(product.id);

      if (!mounted) return;

      if (_productViewModel.error.isNotEmpty) {
        messenger.showSnackBar(
          SnackBar(content: Text(_productViewModel.error)),
        );
        return;
      }

      if (_productViewModel.selectedProduct != null) {
        await navigator.push(
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: _productViewModel.selectedProduct!,
            ),
          ),
        );

        if (mounted) {
          _productViewModel.clearSelectedProduct();
        }
      }
    } catch (e) {
      print('Error navigating to product detail: $e');
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Failed to load product details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: const Color(0xFF3C7846),
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${viewModel.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        viewModel.fetchProductsByCategory(widget.categoryId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.products.isEmpty) {
            return const Center(
              child: Text('No products available in this category'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: viewModel.products.length,
            itemBuilder: (context, index) {
              final product = viewModel.products[index];
              return _buildProductCard(context, product);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return InkWell(
      onTap: () => _navigateToProductDetail(context, product),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                product.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: ${product.imageUrl}');
                  return Image.asset(
                    'assets/images/products/default.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.brand != null)
                    Text(
                      product.brand!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${product.pricePerDay.toStringAsFixed(0)}/hari',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF3C7846),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
