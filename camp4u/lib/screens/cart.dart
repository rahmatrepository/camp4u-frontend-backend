import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample cart items data
  final List<CartItem> _cartItems = [
    CartItem(
      name: 'Tenda Dome 4 Orang',
      price: 150000,
      image: 'assets/images/tent_dome.png',
      quantity: 1,
      isSelected: true,
    ),
    CartItem(
      name: 'Kompor Kembang',
      price: 75000,
      image: 'assets/images/stove.png',
      quantity: 1,
      isSelected: false,
    ),
    CartItem(
      name: 'Sleeping Bag',
      price: 125000,
      image: 'assets/images/sleeping_bag.png',
      quantity: 1,
      isSelected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B9B37), // Green background
        elevation: 0,
        title: const Text(
          'Keranjang Saya (3)',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Cart items list
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                return _buildCartItem(_cartItems[index]);
              },
            ),
          ),
          
          // Booking button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B9B37),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 12.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Booking'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 133, 235, 141), // Light green background
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          // Checkbox
          Checkbox(
            value: item.isSelected,
            onChanged: (value) {
              setState(() {
                item.isSelected = value ?? false;
              });
            },
            activeColor: Colors.green,
          ),
          
          // Product image
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color.fromARGB(255, 133, 235, 141), width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Image.asset(
              item.image,
              fit: BoxFit.contain,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Product details and quantity controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Rp ${item.price.toString()}/hari',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Quantity controls
                Row(
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove,
                      onPressed: () {
                        if (item.quantity > 1) {
                          setState(() {
                            item.quantity--;
                          });
                        }
                      },
                    ),
                    
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        item.quantity.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    _buildQuantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        setState(() {
                          item.quantity++;
                        });
                      },
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

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 244, 245, 170)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Icon(
          icon,
          size: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}

// Model class for cart items
class CartItem {
  final String name;
  final int price;
  final String image;
  int quantity;
  bool isSelected;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.isSelected,
  });
}