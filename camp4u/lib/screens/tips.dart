
import 'package:flutter/material.dart';
// Import the other pages you want to navigate to
import 'panduan1.dart';
import 'faq.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  int _selectedTabIndex = 1; // Starting with Tips tab selected as shown in the image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              color: const Color.fromRGBO(122, 151, 72, 1),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Text(
                    'Panduan & Info',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Tab Selector
            Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 243, 163, 1), // Light yellow
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Panduan Tab
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = 0;
                        });
                        // Navigate to panduan1.dart
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PanduanInfoPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 0
                              ? const Color.fromRGBO(122, 151, 72, 1)
                              : const Color.fromRGBO(255, 243, 163, 1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            bottomLeft: Radius.circular(12.0),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Panduan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedTabIndex == 0 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Tips Tab
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = 1;
                        });
                        // We're already on the Tips page, so no navigation needed
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 1
                              ? const Color.fromRGBO(122, 151, 72, 1)
                              : const Color.fromRGBO(255, 243, 163, 1),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Tips',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedTabIndex == 1 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // FAQ Tab
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = 2;
                        });
                        // Navigate to faq.dart
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const FAQPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 2
                              ? const Color.fromRGBO(122, 151, 72, 1)
                              : const Color.fromRGBO(255, 243, 163, 1),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'FAQ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedTabIndex == 2 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content for Tips page
            Expanded(
              child: _buildTipsContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Tips Untuk Pemula',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildTipCard(
            'Persiapan sebelum camping cek perkiraan cuaca dan siapkan pakaian yang sesuai',
          ),
          const SizedBox(height: 12.0),
          _buildTipCard(
            'Pemilihan lokasi tenda pilih lokasi yang datar hindari area cekungan yang bisa menampung air saat hujan',
          ),
          const SizedBox(height: 12.0),
          _buildTipCard(
            'Makanan dan minuman bawa makanan yang mudah',
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(String tip) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          tip,
          style: const TextStyle(fontSize: 14.0),
        ),
      ),
    );
  }
}