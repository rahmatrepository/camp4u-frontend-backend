import 'package:flutter/material.dart';
import 'tips.dart';
import 'faq.dart';

class PanduanDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;

  const PanduanDetailPage({
    Key? key, 
    required this.title, 
    required this.subtitle
  }) : super(key: key);

  @override
  State<PanduanDetailPage> createState() => _PanduanDetailPageState();
}

class _PanduanDetailPageState extends State<PanduanDetailPage> {
  // Selected tab index
  int _selectedTabIndex = 0;

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
                        // Navigate back to panduan1.dart
                        Navigator.pop(context);
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
                        // Import tips.dart at the top and navigate to TipsPage
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
                        // Import faq.dart at the top and navigate to FAQPage
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
            
            // YouTube Video Thumbnail
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  image: AssetImage('assets/images/ytpanduan.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              // YouTube player UI overlay
              child: Stack(
                children: [
                  // Play button overlay
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  // Video controls overlay at bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 36,
                      color: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.pause, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Container(
                              height: 4,
                              color: Colors.grey,
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "3:45/10:23",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.fullscreen, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Title - Using the passed title parameter
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Subtitle - Using the passed subtitle parameter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.subtitle,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Steps
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('1. Pilih area yang datar'),
                  SizedBox(height: 8),
                  Text('2. Bentangkan tenda'),
                  SizedBox(height: 8),
                  Text('3. Pasang tiang-tiang tenda'),
                  SizedBox(height: 8),
                  Text('4. Kencangkan dengan pasak'),
                  SizedBox(height: 8),
                  Text('5. Pasang flysheet jika hujan'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}