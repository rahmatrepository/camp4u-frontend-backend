import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _duration = 2;
  String _selectedPaymentMethod = '';

  // Define the colors based on the RGB values provided
  final Color lightYellow = const Color.fromRGBO(255, 243, 163, 1); // For address card and Bayar button
  final Color darkGreen = const Color.fromRGBO(122, 151, 72, 1); // For header and bottom section
  final Color lightGreen = const Color.fromRGBO(204, 255, 153, 1); // For product card and payment buttons

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkGreen, // Updated to dark green
        elevation: 0,
        title: const Text(
          'Booking',
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
          // Main content area
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Address card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: lightYellow, // Updated to light yellow
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Andi Maulana (+62) 82246048776',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'Jalan Gegerkalong Girang',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Product info
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: lightGreen, // Updated to light green
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product image
                          Container(
                            width: 70,
                            height: 70,
                            child: Image.asset(
                              'assets/images/tent_dome.png', // Replace with your actual image path
                              fit: BoxFit.contain,
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // Product details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product name
                                const Text(
                                  'Tenda Dome 4 Orang',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                
                                // Price
                                const Text(
                                  'Rp 150.000/hari',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Quantity
                          const Text(
                            'x1',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Duration
                    Row(
                      children: [
                        const Text(
                          'Durasi : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 4),
                        _buildQuantityButton(
                          icon: Icons.remove,
                          onPressed: () {
                            if (_duration > 1) {
                              setState(() {
                                _duration--;
                              });
                            }
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            _duration.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        _buildQuantityButton(
                          icon: Icons.add,
                          onPressed: () {
                            setState(() {
                              _duration++;
                            });
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Rental dates
                    const Text(
                      'Tanggal Sewa : 12 April 2025',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tanggal Kembali : 14 April 2025',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Ongkir : Rp 15.000',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Rp 225.000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Payment method section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            color: darkGreen, // Updated to dark green
            child: Column(
              children: [
                // Centered "Metode Pembayaran" text
                const Center(
                  child: Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                
                const SizedBox(height: 10),
                
                // Payment options in a row
                Row(
                  children: [
                    Expanded(
                      child: _buildPaymentOption('Transfer'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildPaymentOption('COD'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildPaymentOption('QRIS'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 10),
                
                // Pay button in its own row
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightYellow, // Updated to light yellow
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                    ),
                    child: const Text(
                      'Bayar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
          border: Border.all(color: Colors.grey),
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
  
  Widget _buildPaymentOption(String method) {
    bool isSelected = _selectedPaymentMethod == method;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: lightGreen, // Updated to light green
          borderRadius: BorderRadius.circular(8.0),
          border: isSelected
              ? Border.all(color: Colors.green, width: 2.0)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          method,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}