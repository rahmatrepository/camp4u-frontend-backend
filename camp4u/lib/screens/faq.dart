import 'package:flutter/material.dart';
import 'tips.dart';
import 'panduan1.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  int _selectedTabIndex = 2; // FAQ tab is selected

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
                        // Navigate to tips.dart
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const TipsPage()),
                        );
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
                        // We're already on the FAQ page, so no navigation needed
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
            // Content for FAQ page
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    _buildFAQItem(
                      'Bagaimana Cara Membayar?',
                      'Kami menyediakan pembayaran via transfer bank, ovo, dan qris',
                    ),
                    const SizedBox(height: 12.0),
                    _buildFAQItem(
                      'Berapa Lama Pengiriman?',
                      'Umumnya sekitar 1-3 jam setelah pembayaran dikonfirmasi',
                    ),
                    const SizedBox(height: 12.0),
                    _buildFAQItem(
                      'Kapan Pengembalian Alat?',
                      'Alat harus di kembalikan sesuai dengan durasi sewa yang di pilih',
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

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(220, 255, 220, 1), // Light green background
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: Text(
              question,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
            child: Text(
              answer,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}