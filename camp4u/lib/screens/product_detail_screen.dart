import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/product_model.dart';
import '../ViewModel/product_view_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
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
                        viewModel.fetchProductDetail(widget.product.id),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final Product displayProduct =
              viewModel.selectedProduct ?? widget.product;
          final List<String> displayImages =
              displayProduct.images ?? [displayProduct.imageUrl];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image Slider
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      color: const Color(0xFFE8F5E9),
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemCount: displayImages.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            displayImages[index],
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              print(
                                  'Error loading image: ${displayImages[index]}');
                              return Image.asset(
                                'assets/images/products/default.png',
                                fit: BoxFit.contain,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    // Page Indicator
                    if (displayImages.length > 1)
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            displayImages.length,
                            (index) => Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index
                                    ? const Color(0xFF3C7846)
                                    : Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                // Product Details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (displayProduct.brand != null)
                        Text(
                          displayProduct.brand!,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        displayProduct.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Price and Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rp ${displayProduct.pricePerDay.toStringAsFixed(0)}/hari',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3C7846),
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    index <
                                            (displayProduct.conditionRating ??
                                                5)
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${displayProduct.conditionRating?.toStringAsFixed(1) ?? "5.0"})',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Divider(height: 32),

                      // Description
                      const Text(
                        'Deskripsi',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        displayProduct.description ?? 'Tidak ada deskripsi',
                        style: const TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 16),

                      // Specifications
                      if (displayProduct.specifications != null) ...[
                        const Text(
                          'Spesifikasi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          displayProduct.specifications!,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],

                      const SizedBox(height: 16),

                      // Additional Info
                      if (displayProduct.weight != null ||
                          displayProduct.dimensions != null)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (displayProduct.weight != null)
                                  Text('Berat: ${displayProduct.weight} kg'),
                                if (displayProduct.dimensions != null)
                                  Text('Dimensi: ${displayProduct.dimensions}'),
                              ],
                            ),
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Bottom buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.add_shopping_cart),
                              label: const Text('Keranjang'),
                              onPressed: () {
                                // TODO: Implement add to cart
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement rent now
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3C7846),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text('Sewa Sekarang'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
