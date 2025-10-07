import 'package:flutter/material.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:gas_station/widgets/custom_primary_button.dart';
import 'package:gas_station/widgets/wallet%20screen.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<String> paymentMethods = [
    "assets/images/mada.png",
    "assets/images/visa.png",
    "assets/images/cash1.png",
    "assets/images/apple_pay.png",
    "assets/images/stc_pay.png",
  ];

  void onSelectMethod(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomBackButton(),
        ),
        title: const Text(
          "Card Details",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.account_balance_wallet, color: Colors.blue),
            label: const Text(
              "your wallet",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Payment Methods Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: List.generate(paymentMethods.length, (index) {
                  return GestureDetector(
                    onTap: () => onSelectMethod(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedIndex == index
                              ? primaryColor
                              : Colors.grey,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: index == 2
                          ? Row(
                              children: [
                                Image.asset(paymentMethods[index], height: 40),
                                Image.asset("assets/images/cash2.png"),
                              ],
                            )
                          : Image.asset(paymentMethods[index], height: 40),
                    ),
                  );
                }),
              ),
            ),
          ),

          // PageView to show payment details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Page 0 → Mada / Credit Card Form
                  _buildCardForm(),

                  // Page 1 → Visa
                  _buildCardForm(),

                  // Page 2 → Cash on Delivery
                  _buildCashDetails(),

                  // Page 3 → Apple Pay
                  _buildApplePayDetails(),

                  // Page 4 → STC Pay
                  _buildStcPayDetails(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF6DB944),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  Widget _buildCardForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name on Card', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _orangeTextField("Name"),
          const SizedBox(height: 16),
          Text('Card Number', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _orangeTextField(
            "1111 2222 3333 4444",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiration date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _orangeTextField(
                      "mm/yy",
                      keyboardType: TextInputType.datetime,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('CVV', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    _orangeTextField("123", keyboardType: TextInputType.number),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Total Amount",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SAR ',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2D3142), // similar dark gray tone
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '24',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF2D3142),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomPrimaryButton(label: "Place Order", onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildCashDetails() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "You will Pay after delivered your fuel .",
            textAlign: TextAlign.center,
            style: scoundryTextStyle,
          ),
          const Text(
            "Total Amount",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SAR ',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2D3142), // similar dark gray tone
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '24',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF2D3142),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(child: const SizedBox(height: 5)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomPrimaryButton(label: "Place Order", onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildApplePayDetails() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: CustomColum_apple_stc(
            'visa_apple.png',
            '5355 \*\*\*\*SNB made Masterc...',
          ),
        ),
      ),
    );
  }

  List<Widget> CustomColum_apple_stc(String visaPhoto, String labelInCard) {
    return [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0XFFD9D9D9),

          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 50,
              child: Image(image: AssetImage('assets/images/${visaPhoto}')),
            ),

            Text(
              labelInCard,
              style: TextStyle(color: primaryColor, fontSize: 12),
            ),

            Icon(Icons.arrow_forward_ios, color: primaryColor),
          ],
        ),
      ),
      Row(
        children: [
          Image.asset('assets/images/signup.png', height: 100, width: 100),
          Text(
            'Pay to Gas Station',
            style: TextStyle(color: primaryColor, fontSize: 16),
          ),
        ],
      ),
      const Text(
        "Total Amount",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SAR ',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF2D3142), // similar dark gray tone
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '24',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF2D3142),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: CustomPrimaryButton(
          label: "Place Order",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WalletScreen()),
            );
          },
        ),
      ),
    ];
  }

  Widget _buildStcPayDetails() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: CustomColum_apple_stc(
            'visa_stc.png',
            '4435 ****stc pay - classic',
          ),
        ),
      ),
    );
  }

  Widget _orangeTextField(String hint, {TextInputType? keyboardType}) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.orange,
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
