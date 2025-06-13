import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 200,
              width: double.infinity,
              color: const Color(0xFFE8F5E9), // Light green background
              child: Center(
                child: Image.asset(
                  'assets/images/tent_dome.png', // Replace with your image path
                  fit: BoxFit.contain,
                  height: 180,
                ),
              ),
            ),
            
            // Product Title and Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  const Text(
                    'Tenda Dome 4 Orang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  // Price
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Rp 150.000/hari',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  // Rating Stars
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        // Yellow Stars
                        Row(
                          children: List.generate(
                            4,
                            (index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ),
                        ),
                        // Half Star
                        const Icon(
                          Icons.star_half,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        // Reviews Count
                        const Text(
                          '(120 Ulasan)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Divider
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(),
                  ),
                  
                  // Description Title
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Description Points
                  const Text(
                    'Tenda Dome kapasitas 4 orang',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Bahan : Waterproof',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Dimensi : 220 × 220 × 130 cm',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Berat : 2.5 kg',
                    style: TextStyle(fontSize: 14),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Feature list with icons
                  _buildFeatureRow(
                    Icons.family_restroom,
                    'Cocok untuk keluarga kecil atau grup teman saat berkemah.',
                    Colors.green,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildFeatureRow(
                    Icons.air,
                    'Ventilasi udara baik dan pemasangan mudah hanya dalam beberapa menit.',
                    Colors.blue,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildFeatureRow(
                    Icons.luggage,
                    'Ringan dan praktis dibawa ke berbagai lokasi camping.',
                    Colors.orange,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Bottom buttons
                  Row(
                    children: [
                      // Add to cart button
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Keranjang'),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      
                      // Rent now button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
      ),
    );
  }
  
  Widget _buildFeatureRow(IconData icon, String text, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}