import 'package:flutter/material.dart';
import 'edit_profil.dart';  
import 'riwayat_sewa.dart'; 

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define button green color based on RGB value
    final buttonGreen = Color.fromRGBO(122, 151, 72, 1);

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
                    'Profil',
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
            
            const SizedBox(height: 24),
            
            // Profile picture
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFA0A0A0), // Grey color for the profile picture
                ),
                child: const Icon(
                  Icons.person_outline,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // User name
            const Center(
              child: Text(
                'Andi Maulana',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Menu options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Edit Profile button
                  _buildMenuButton(
                    context: context,
                    title: 'Edit Profile',
                    icon: Icons.arrow_circle_right_outlined,
                    iconColor: Colors.black,
                    backgroundColor: buttonGreen,
                    onTap: () {
                      // Navigate to EditProfilScreen class
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfilScreen(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Rental history button
                  _buildMenuButton(
                    context: context,
                    title: 'Riwayat penyewaan',
                    icon: Icons.arrow_circle_right_outlined,
                    iconColor: Colors.black,
                    backgroundColor: buttonGreen,
                    onTap: () {
                      // Navigate to RiwayatSewa class
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RiwayatSewa(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Logout button
                  _buildMenuButton(
                    context: context,
                    title: 'Keluar',
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    backgroundColor: buttonGreen,
                    onTap: () {
                      // Show confirmation dialog before logout
                      _showLogoutConfirmationDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMenuButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
  
  // Show logout confirmation dialog
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Navigate to MyApp class (main)
                
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}