import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO: Replace with actual auth state management
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: isLoggedIn ? _buildLoggedInView() : _buildLoggedOutView(),
    );
  }

  Widget _buildLoggedOutView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login atau Register untuk mengakses Profile',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to login screen
            },
            child: Text('Login'),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // TODO: Navigate to register screen
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedInView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/default.png'),
          ),
          SizedBox(height: 16),
          Text(
            'Nama Pengguna',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('email@example.com'),
          SizedBox(height: 24),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Pesanan Saya'),
            onTap: () {
              // TODO: Navigate to orders
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Wishlist'),
            onTap: () {
              // TODO: Navigate to wishlist
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Pengaturan'),
            onTap: () {
              // TODO: Navigate to settings
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // TODO: Implement logout
              setState(() {
                isLoggedIn = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
