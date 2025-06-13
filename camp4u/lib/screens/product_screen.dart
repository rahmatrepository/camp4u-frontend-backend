// screens/category_screen.dart
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 35,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 238, 238, 238),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Category tabs
          Container(
            color: const Color(0xFFFFF9C4), // Yellow background color
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryTab('Terkait', true),
                _buildCategoryTab('Kategori', false),
                _buildCategoryTab('Harga', false),
                _buildCategoryTab('Rating', false),
              ],
            ),
          ),
          
          // Products grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildProductCard(
                  'Tenda Family',
                  'Rp 250.000/hari',
                  '4.8',
                  'assets/images/tent_family.png',
                ),
                _buildProductCard(
                  'Tenda Premium',
                  'Rp 200.000/hari',
                  '4.9',
                  'assets/images/tent_premium.png',
                ),
                _buildProductCard(
                  'Tenda Dome 4 Orang',
                  'Rp 150.000/hari',
                  '4.7',
                  'assets/images/tent_dome.png',
                ),
                _buildProductCard(
                  'Tenda Ultralight',
                  'Rp 200.000/hari',
                  '4.6',
                  'assets/images/tent_ultralight.png',
                ),
                _buildProductCard(
                  'Tenda Tunnel',
                  'Rp 180.000/hari',
                  '4.7',
                  'assets/images/tent_tunnel.png',
                ),
                _buildProductCard(
                  'Tenda Ridge',
                  'Rp 170.000/hari',
                  '4.5',
                  'assets/images/tent_ridge.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryTab(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        color: isSelected ? const Color(0xFF6B9B37) : const Color(0xFFFFF9C4), // Green if selected, yellow otherwise
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
  
  Widget _buildProductCard(String title, String price, String rating, String imagePath) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: const Color(0xFFE8F5E9), // Light green background for the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFF4C9A53), // Darker green background for image area
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(
                  imagePath,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  price,
                  style: const TextStyle(fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 14),
                          Text(
                            " $rating",
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Detail',
                        style: TextStyle(color: Colors.white, fontSize: 12),
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
  }
