import 'package:flutter/material.dart';

class PengirimanScreen extends StatelessWidget {
  const PengirimanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define colors based on RGB values
    final lightGreen = Color.fromRGBO(204, 255, 153, 1);
    final lightYellow = Color.fromRGBO(255, 243, 163, 1);
    
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
                    'Pengiriman',
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
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Order status card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Pesanan #12345',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Status : Dalam pengiriman',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Estimasi Tiba : 12 April 2025, 13.00',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Order progress tracker
                    Card(
                      elevation: 2,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Order confirmed
                            _buildProgressStep(
                              icon: Icons.check_circle,
                              iconColor: Colors.green,
                              text: 'Pesanan Dikonfirmasi',
                              showLine: true,
                              isCompleted: true,
                            ),
                            
                            // Order processed
                            _buildProgressStep(
                              icon: Icons.check_circle,
                              iconColor: Colors.green,
                              text: 'Pesanan Diproses',
                              showLine: true,
                              isCompleted: true,
                            ),
                            
                            // Order shipped
                            _buildProgressStep(
                              icon: Icons.directions_car,
                              iconColor: Colors.amber,
                              text: 'Pesanan Dikirim',
                              showLine: true,
                              isCurrentStep: true,
                              isCompleted: false,
                            ),
                            
                            // Order completed
                            _buildProgressStep(
                              icon: Icons.check_circle,
                              iconColor: Colors.red,
                              text: 'Selesai',
                              showLine: false,
                              isCompleted: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Shipping details title
                    const Text(
                      'Detail Pengiriman',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Shipping details card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: lightYellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          // Address
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Alamat : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: 'Jl. GagerKalong'),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          
                          // Contact
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Kontak: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: 'Andi (+62) 82246048776'),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          
                          // Notes
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Catatan: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: 'Hubungi saat sampai di lobby'),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          
                          // Return date
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Pengembalian: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: '14 April 2025, 13:00'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProgressStep({
    required IconData icon,
    required Color iconColor,
    required String text,
    required bool showLine,
    bool isCompleted = false,
    bool isCurrentStep = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon column
        Column(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
            if (showLine)
              Container(
                width: 2,
                height: 30,
                color: Colors.green,
              ),
          ],
        ),
        
        const SizedBox(width: 12),
        
        // Text
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isCurrentStep ? FontWeight.bold : FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        
        // Current step indicator - truck icon
        if (isCurrentStep)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.local_shipping,
              color: Colors.black,
              size: 24,
            ),
          ),
      ],
    );
  }
}