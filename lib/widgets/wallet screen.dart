import 'package:flutter/material.dart';
import 'package:gas_station/widgets/custom_back_button.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomBackButton(),
        ),
        title: Row(
          children: [
            const Text(
              "Wallet",
              style: TextStyle(
                color: Color(0xFF6DB944),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 6),
            Image.asset(
              "assets/images/wallet_icon.png",
              height: 24,
              color: const Color(0xFF6DB944),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Total Balance Box
            Column(
              children: [
                const Text(
                  "Total Balance",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "SR 0",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 220,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Text(
                          "Add Balance",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shape: CircleBorder(),
                            side: BorderSide(color: Colors.white, width: 3),
                          ),

                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6DB944),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // All Operation
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "All operation",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "No transaction",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: Image.asset(
                      "assets/images/grey_wallet.png",
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Your Wallet has no balance yet",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
