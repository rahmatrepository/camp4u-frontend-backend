import 'package:flutter/material.dart';
import 'pengiriman.dart'; // Import file pengiriman.dart

class RiwayatSewa extends StatelessWidget {
  const RiwayatSewa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define colors based on RGB values
    final cardGreen = Color.fromRGBO(204, 255, 153, 1);
    final buttonGreen = Color.fromRGBO(122, 151, 72, 1);
    final completedButtonGray = Color.fromRGBO(151, 161, 136, 1);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Riwayat Penyewaan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            
            // Rental history list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Tent rental item - in shipping status
                  _buildRentalItem(
                    context: context,
                    title: 'Tenda untuk 4 orang',
                    date: '12 - 14 April 2025 . 2 hari',
                    price: 'Rp 105.000',
                    status: 'Pengiriman',
                    backgroundColor: cardGreen,
                    buttonColor: buttonGreen, // Green button for shipping
                    isNavigable: true, // Enable navigation for shipping status
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Sleeping bag rental item - completed
                  _buildRentalItem(
                    context: context,
                    title: 'Sleeping Bag',
                    date: '5 - 6 Maret 2025 . 2 hari',
                    price: 'Rp 150.000',
                    status: 'Selesai',
                    backgroundColor: cardGreen,
                    buttonColor: completedButtonGray, // Gray button for completed
                    isNavigable: false, // Disable navigation for completed status
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Carrier Gol rental item - completed
                  _buildRentalItem(
                    context: context,
                    title: 'Carrier Gol',
                    date: '20 - 22 Februari 2025 . 2 hari',
                    price: 'Rp 300.000',
                    status: 'Selesai',
                    backgroundColor: cardGreen,
                    buttonColor: completedButtonGray, // Gray button for completed
                    isNavigable: false, // Disable navigation for completed status
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRentalItem({
    required BuildContext context,
    required String title,
    required String date,
    required String price,
    required String status,
    required Color backgroundColor,
    required Color buttonColor,
    required bool isNavigable,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item title
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Rental details row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date and price information
              Expanded(
                child: Text(
                  '$date . $price',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              
              // Status button with conditional navigation
              GestureDetector(
                onTap: isNavigable ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PengirimanScreen(),
                    ),
                  );
                } : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}