import 'package:camp4u/screens/edit_profil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/product_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'screens/cart.dart';
import 'screens/booking.dart';
import 'screens/transfer.dart';
import 'screens/bukti_transfer.dart';
import 'screens/qris.dart';
import 'screens/pembayaran_berhasil.dart';
import 'screens/profil.dart';
import 'screens/ulasan.dart';
import 'screens/tulis_ulasan.dart';
import 'screens/panduan1.dart';
import 'screens/cod.dart';
import 'screens/chat.dart';
import 'screens/notif.dart';
import 'ViewModel/category_view_model.dart';
import 'ViewModel/product_view_model.dart';
import 'ViewModel/auth_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camp4U',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Roboto'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const CampingHomePage(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/edit_profile': (context) => const EditProfilScreen(),
      },
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Aplikasi Camping'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        // Added SingleChildScrollView here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nomor Kelompok: 8',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Pilih halaman yang ingin ditampilkan:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              _buildNavigationButton(
                context: context,
                label: 'Home --> bottom navigasi bisa di klik',
                destination: const CampingHomePage(),
              ),
              _buildNavigationButton(
                context: context,
                label: 'Product',
                destination: const CategoryScreen(),
              ),
              // _buildNavigationButton(
              //   context: context,
              //   label: 'Product Detail',
              //   destination: const ProductDetailScreen(),
              // ),
              _buildNavigationButton(
                context: context,
                label: 'Ulasan',
                destination: const ReviewsPage(),
              ),
              _buildNavigationButton(
                context: context,
                label: 'Registration',
                destination: const RegistrationScreen(),
              ),
              _buildNavigationButton(
                context: context,
                label: 'Login',
                destination: const LoginScreen(),
              ),
              _buildNavigationButton(
                context: context,
                label: 'Cart',
                destination: const CartScreen(),
              ),
              _buildNavigationButton(
                context: context,
                label: 'Booking',
                destination: const BookingScreen(),
              ),
              _buildNavigationButton(
                context: context,
                label: 'Transfer',
                destination: const TransferScreen(),
              ),
              _buildNavigationButton(
                context: context,
                label: 'Bukti Transfer',
                destination: const BuktiTransfer(),
              ),

              _buildNavigationButton(
                context: context,
                label: 'COD',
                destination: const CashOnDeliveryPage(),
              ),

              _buildNavigationButton(
                context: context,
                label: 'Qris',
                destination: const QrisScreen(),
              ),

              _buildNavigationButton(
                context: context,
                label: 'Pembayaran Berhasil',
                destination: const PembayaranBerhasil(),
              ),

              _buildNavigationButton(
                context: context,
                label: 'Profil',
                destination: const ProfilScreen(),
              ),

              _buildNavigationButton(
                context: context,
                label: 'Tulis Ulasan',
                destination: const TulisUlasanPage(),
              ),

              _buildNavigationButton(
                context: context,
                label: 'Panduan',
                destination: const PanduanInfoPage(),
              ),

              _buildNavigationButton(
                context: context,
                label: 'Chat',
                destination: const ChatScreen(),
              ),

              _buildNavigationButton(
                context: context,
                label: 'Notifikasi',
                destination: const NotifScreen(),
              ),
              // Added some padding at the bottom for better scrolling experience
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to reduce repetitive button code
  Widget _buildNavigationButton({
    required BuildContext context,
    required String label,
    required Widget destination,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.purple[800],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
