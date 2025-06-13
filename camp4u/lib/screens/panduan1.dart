import 'package:flutter/material.dart';
import 'panduan2.dart'; // Import panduan2.dart file
import 'tips.dart';     // Import tips.dart file
import 'faq.dart';      // Import faq.dart file

class PanduanInfoPage extends StatefulWidget {
  const PanduanInfoPage({Key? key}) : super(key: key);

  @override
  State<PanduanInfoPage> createState() => _PanduanInfoPageState();
}

class _PanduanInfoPageState extends State<PanduanInfoPage> {
  // Selected tab index
  int _selectedTabIndex = 0;

  // List of guide items
  final List<Map<String, String>> _guideItems = [
    {
      'title': 'Cara Menggunakan Sleeping bag',
      'subtitle': 'Tips biar sleeping bag tetap hangat dan tidak basah.',
    },
    {
      'title': 'Tutorial Memakai Kompor Camping',
      'subtitle': 'Cara aman menyalakan dan mematikan kompor gas portable.',
    },
    {
      'title': 'Cara Memasang Tenda',
      'subtitle': 'Langkah - langkah memasang tenda yang kokoh.',
    },
    {
      'title': 'Cara Menyimpan Makanan',
      'subtitle': 'Supaya aman dari binatang liar dan tetap segar.',
    },
  ];

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
                color: const Color.fromRGBO(255, 243, 163, 1), // Set background color to light yellow
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
                        // Already on panduan page, no navigation needed
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
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0.0),
                            bottomLeft: Radius.circular(0.0),
                          ),
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
            // Content
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _guideItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12.0),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: const Color.fromRGBO(204, 255, 153, 1),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      title: Text(
                        _guideItems[index]['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          _guideItems[index]['subtitle']!,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 2.0,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16.0,
                          ),
                          onPressed: () {
                            // Navigate to panduan2.dart when button is clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PanduanDetailPage(
                                  title: _guideItems[index]['title']!,
                                  subtitle: _guideItems[index]['subtitle']!,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}