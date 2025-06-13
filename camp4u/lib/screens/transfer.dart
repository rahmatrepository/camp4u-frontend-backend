import 'package:flutter/material.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define colors based on RGB values
    final headerGreen = Color.fromRGBO(122, 151, 72, 1);
    final cardGreen = Color.fromRGBO(204, 255, 153, 1);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
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
                    'Transfer',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // List of transfer options
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Bank options
                  _buildTransferOption(
                    logoPath: 'assets/images/bca_logo.png',
                    accountNumber: '1234-5678-9101',
                    backgroundColor: cardGreen,
                  ),
                  const SizedBox(height: 12),
                  _buildTransferOption(
                    logoPath: 'assets/images/mandiri_logo.png',
                    accountNumber: '1234-5678-9101',
                    backgroundColor: cardGreen,
                  ),
                  const SizedBox(height: 12),
                  _buildTransferOption(
                    logoPath: 'assets/images/bri_logo.png',
                    accountNumber: '1234-5678-9101',
                    backgroundColor: cardGreen,
                  ),
                  const SizedBox(height: 12),
                  _buildTransferOption(
                    logoPath: 'assets/images/bni_logo.png',
                    accountNumber: '1234-5678-9101',
                    backgroundColor: cardGreen,
                  ),
                  const SizedBox(height: 12),
                  _buildTransferOption(
                    logoPath: 'assets/images/bsi_logo.png',
                    accountNumber: '1234-5678-9101',
                    backgroundColor: cardGreen,
                  ),
                  // E-Wallet options (added as requested)
                  const SizedBox(height: 12),
                  _buildTransferOption(
                    logoPath: 'assets/images/gopay_logo.png',
                    accountNumber: '08821913576',
                    backgroundColor: cardGreen,
                  ),
                  const SizedBox(height: 12),
                  _buildTransferOption(
                    logoPath: 'assets/images/dana_logo.png',
                    accountNumber: '08821913576',
                    backgroundColor: cardGreen,
                  ),
                  const SizedBox(height: 12),
                  _buildTransferOption(
                    logoPath: 'assets/images/shopeepay_logo.png',
                    accountNumber: '08821913576',
                    backgroundColor: cardGreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferOption({
    required String logoPath,
    required String accountNumber,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Bank logo
          Container(
            width: 80,
            height: 32,
            child: Image.asset(
              logoPath,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          // Account number
          Text(
            accountNumber,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}