import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    // default value for 'weeks' HERE
    home: PaymentPage(weeks: 1),
  ));
}

class PaymentPage extends StatefulWidget {
  final int weeks;

  const PaymentPage({super.key, required this.weeks});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool showCoupons = false;
  String selectedMethod = 'Master Card 5055';

  final List<String> coupons = [
    'Fast Meal 10% - Rp. 100,000',
    'Healthy Plan 5% - Rp. 50,000',
    'First Order - Rp. 70,000',
  ];

  final List<Map<String, dynamic>> paymentMethods = [
    {'name': 'OVO', 'image': 'Assets/ovo.png'},
    {'name': 'Master Card 5055', 'image': 'Assets/mastercard.png'},
    {'name': 'LinkAja', 'image': 'Assets/Linkaja.png'},
    {'name': 'Go Pay', 'image': 'Assets/gopay.png'},
  ];

  @override
  Widget build(BuildContext context) {
    // price calculation HERE
    final int pricePerWeek = 400000;
    final int subTotal = pricePerWeek * widget.weeks;
    final int couponDiscount = 100000; 
    final int totalExpenses = subTotal - couponDiscount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Complete Payment',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),

              // Order Summary
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F6A8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'ORDER SUMMARY',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // order summary view HERE
                    rowItem('Muscle Meal [${widget.weeks} Week(s)]', 'Rp. $subTotal'),
                    rowItem('Coupon Fast Meal 10%', '-Rp. $couponDiscount'),
                    const SizedBox(height: 8),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Expenses'),
                        Text(
                          'Rp. $totalExpenses',
                          style: const TextStyle(
                            backgroundColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // View Coupon Offer Dropdown
              GestureDetector(
                onTap: () {
                  setState(() {
                    showCoupons = !showCoupons;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'View Coupon Offer',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        showCoupons
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              if (showCoupons)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green.shade900),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: coupons
                        .map((c) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                c,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ))
                        .toList(),
                  ),
                ),

              const SizedBox(height: 20),
              const Text('Choose your payment method :'),
              const SizedBox(height: 10),

              // Payment Methods
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: paymentMethods.map((method) {
                    final bool isSelected = method['name'] == selectedMethod;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMethod = method['name'];
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFFFECF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              method['image'],
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                method['name'],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 30),

              // Pay Now Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // handle pay action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade900,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(title)),
          Text(value),
        ],
      ),
    );
  }
}