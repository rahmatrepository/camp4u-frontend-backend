
import 'package:flutter/material.dart';

class BuktiTransfer extends StatelessWidget {
  const BuktiTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define colors based on RGB values
    final headerGreen = Color.fromRGBO(122, 151, 72, 1);
    final cardGreen = Color.fromRGBO(204, 255, 153, 1);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with bank name
            Container(
              color: headerGreen,
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
                    'Bank BCA',
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
            // Content area
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Account Info Card
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: cardGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // BCA logo
                            Container(
                              width: 60,
                              height: 32,
                              child: Image.asset(
                                'assets/images/bca_logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Account number
                            const Text(
                              '1234-5678-9101',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            // Copy button
                            const Icon(Icons.copy, size: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Mobile Banking Instructions
                      const Text(
                        'Via Mobile Banking BCA:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildNumberedItem('Buka aplikasi BCA Mobile, lalu pilih m-BCA'),
                      _buildNumberedItem('Masukkan kode akses Anda'),
                      _buildNumberedItem('Pilih menu m-Transfer > Antar Rekening BCA'),
                      _buildNumberedItem('Masukkan nomor rekening tujuan: 1234-5678-9101'),
                      _buildNumberedItem('Masukkan jumlah: Rp 225.000'),
                      _buildNumberedItem('Konfirmasi dan selesaikan transaksi'),
                      _buildNumberedItem('Simpan bukti transfer, lalu upload di bawah.'),
                      
                      const SizedBox(height: 16),
                      
                      // ATM Instructions
                      const Text(
                        'Via ATM BCA:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildNumberedItem('Masukkan kartu ATM & PIN Anda'),
                      _buildNumberedItem('Pilih menu Transfer > Ke Rekening BCA Lain'),
                      _buildNumberedItem('Masukkan nomor rekening tujuan: 1234-5678-9101'),
                      _buildNumberedItem('Masukkan jumlah: Rp 225.000'),
                      _buildNumberedItem('Selesaikan transaksi dan simpan struk'),
                      
                      const SizedBox(height: 24),
                      
                      // Upload section
                      const Center(
                        child: Text(
                          'Upload Bukti Pembayaran',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // File upload row
                      Row(
                        children: [
                          // Pick file button
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: cardGreen,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Pilih File',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          // File name area
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD8D8D8),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Pay button
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: headerGreen,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Bayar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberedItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_getNumbering(text)}. ',
            style: const TextStyle(fontSize: 14),
          ),
          Expanded(
            child: Text(
              text.substring(text.indexOf(' ') + 1),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  int _getNumbering(String text) {
    final numberString = text.substring(0, text.indexOf(' '));
    return int.tryParse(numberString) ?? 0;
  }
}