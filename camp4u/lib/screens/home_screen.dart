// screens/home_screen.dart
import 'package:flutter/material.dart';
// Import all the required screens
import 'panduan1.dart';
import 'notif.dart';
import 'profil.dart';
import 'cart.dart';
import 'chat.dart';
import 'package:provider/provider.dart';
import '../ViewModel/category_view_model.dart';

class CampingHomePage extends StatefulWidget {
  const CampingHomePage({Key? key}) : super(key: key);

  @override
  State<CampingHomePage> createState() => _CampingHomePageState();
}

class _CampingHomePageState extends State<CampingHomePage> {
  int _selectedIndex = 0;

  // List of screens to navigate to
  final List<Widget> _screens = [
    const CampingHomeContent(), // This will be our home content
    const PanduanInfoPage(),
    const NotifScreen(),
    const ProfilScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Definisikan warna hijau khusus sesuai spesifikasi
    Color customGreen = const Color(0xFF3C7846);

    // If we're on a screen other than home, show that screen
    if (_selectedIndex != 0) {
      return _screens[_selectedIndex];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: customGreen, // Menggunakan warna hijau #3c7846
        title: Row(
          children: [
            Text(
              'Camp4U',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Cari gear...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              ),
            ),
            // Cart icon with navigation
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              child: Icon(Icons.shopping_cart, color: Colors.black87),
            ),
            SizedBox(width: 10),
            // Chat icon with navigation
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              },
              child: Icon(Icons.message_outlined, color: Colors.black87),
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex], // Show the current screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF3C7846),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Panduan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Saya',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Create a separate widget for the home content
class CampingHomeContent extends StatefulWidget {
  const CampingHomeContent({Key? key}) : super(key: key);

  @override
  State<CampingHomeContent> createState() => _CampingHomeContentState();
}

class _CampingHomeContentState extends State<CampingHomeContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryViewModel>().fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promo Banner (Sekarang menggunakan Image)
          Image.asset(
            'assets/images/promo.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder:
                (context, error, stackTrace) => Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.green.shade400,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PROMO CAMPING',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Diskon 25% untuk peralatan baru. Nikmati liburan petualangan dengan set gear terbaik!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Lihat Semua',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.landscape,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
          ),

          // Kategori Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kategori',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 16),
                Consumer<CategoryViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (viewModel.error.isNotEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Text(
                              'Error: ${viewModel.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                            ElevatedButton(
                              onPressed: () => viewModel.fetchCategories(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (viewModel.categories.isEmpty) {
                      return const Center(
                        child: Text('No categories available'),
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                          viewModel.categories.map((category) {
                            return _buildCategoryItem(
                              imageUrl: category.imageUrl,
                              label: category.name,
                              color: Colors.amber.shade100,
                            );
                          }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),

          // Paket Lengkap Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paket Lengkap',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildPackageItem(
                        title: 'Paket Pemula',
                        price: 'Rp 848.000/mln',
                        icon: Icons.hiking,
                        color: Colors.amber.shade100,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildPackageItem(
                        title: 'Paket Keluarga',
                        price: 'Rp 1.462.000/mln',
                        icon: Icons.family_restroom,
                        color: Colors.amber.shade100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Rekomendasi Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rekomendasi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildRecommendationItem(
                        image: Icons.home_work,
                        title: 'Tenda Dome',
                        rating: 5,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildRecommendationItem(
                        image: Icons.outdoor_grill,
                        title: 'Kompor Kapar',
                        rating: 4,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildRecommendationItem(
                        image: Icons.backpack,
                        title: 'Tas Carrier',
                        rating: 5,
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

  Widget _buildCategoryItem({
    required String imageUrl,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildPackageItem({
    required String title,
    required String price,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(price, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem({
    required IconData image,
    required String title,
    required int rating,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            alignment: Alignment.center,
            child: Icon(image, size: 50),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
