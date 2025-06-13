import 'package:flutter/material.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({Key? key}) : super(key: key);

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  bool isAllSelected = true;

  // Define notification data by category
  final Map<String, List<Map<String, dynamic>>> notifications = {
    'all': [
      {
        'title': 'Pesanan diproses',
        'icon': Icons.local_shipping,
        'message': 'Pesanan Anda sedang diproses dan akan segera dikirim'
      },
      {
        'title': 'Promo baru!',
        'icon': Icons.discount,
        'message': 'Dapatkan diskon 25% untuk pembelian pertama Anda'
      },
      {
        'title': 'Pembayaran Berhasil',
        'icon': Icons.payment,
        'message': 'Pembayaran Anda telah berhasil diproses'
      },
      {
        'title': 'Promo Camping!',
        'icon': Icons.forest,
        'message': 'Diskon 30% untuk perlengkapan camping bulan ini'
      },
      {
        'title': 'Promo Keluarga!',
        'icon': Icons.family_restroom,
        'message': 'Paket khusus untuk liburan keluarga'
      },
    ],
    'promo': [
      {
        'title': 'Promo baru!',
        'icon': Icons.discount,
        'message': 'Dapatkan diskon 25% untuk pembelian pertama Anda'
      },
      {
        'title': 'Promo Camping!',
        'icon': Icons.forest,
        'message': 'Diskon 30% untuk perlengkapan camping bulan ini'
      },
      {
        'title': 'Promo Keluarga!',
        'icon': Icons.family_restroom,
        'message': 'Paket khusus untuk liburan keluarga'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Define colors
    Color headerColor = const Color.fromRGBO(122, 151, 72, 1);
    Color activeTabColor = const Color.fromRGBO(255, 243, 163, 1); // Yellow for active tab
    Color inactiveTabColor = const Color.fromRGBO(122, 151, 72, 1); // Green for inactive tab
    Color cardColor = const Color.fromRGBO(204, 255, 153, 1);

    // Get current notifications based on selected tab
    List<Map<String, dynamic>> currentNotifications = 
        isAllSelected ? notifications['all']! : notifications['promo']!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab selector - now below the app bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: headerColor,
            child: Row(
              children: [
                // "Semua" Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAllSelected = true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isAllSelected ? activeTabColor : inactiveTabColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Semua',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // "Promo" Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAllSelected = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !isAllSelected ? activeTabColor : inactiveTabColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Promo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Notifications list
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: currentNotifications.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          currentNotifications[index]['icon'],
                          color: headerColor,
                        ),
                      ),
                      title: Text(
                        currentNotifications[index]['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        currentNotifications[index]['message'],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}