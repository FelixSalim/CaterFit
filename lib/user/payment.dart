import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:caterfit/controller/accessibility_controller.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PaymentPage(weeks: 1),
  ));
}

class PaymentPage extends StatefulWidget {
  final int weeks;
  const PaymentPage({super.key, required this.weeks});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  final SpeechToText _speech = SpeechToText();
  late AnimationController _controller;

  bool showCoupons = false;
  String selectedMethod = 'Master Card 5055';
  bool subscriptionActive = false;
  String? selectedCoupon;
  int couponDiscount = 0;
  int subTotal = 250000;
  int totalExpenses = 250000;

  final List<String> coupons = [
    'Fast Meal - Rp. 20,000',
    'Healthy Plan - Rp. 15,000',
    'First Order - Rp. 10,000',
  ];

  final List<Map<String, String>> paymentMethods = [
    {
      'name': 'Master Card 5055',
      'image': 'assets/images/mastercard.png',
    },
    {
      'name': 'Gopay',
      'image': 'assets/images/gopay.png',
    },
    {
      'name': 'Dana',
      'image': 'assets/images/dana.png',
    },
  ];

  final Map<String, int> stocks = {
    'Muscle Meal': 10,
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    Future.delayed(const Duration(seconds: 1), () async {
      await AccessibilityController.speak(
        'Please select a coupon. Available coupons are: Fast Meal, Healthy Plan, and First Order.',
      );
      _startCouponListening();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _speech.stop();
    super.dispose();
  }

  void toggleCoupons() {
    setState(() {
      showCoupons = !showCoupons;
      showCoupons ? _controller.forward() : _controller.reverse();
    });
  }

  void _startCouponListening() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        onResult: (result) {
          String voiceInput = result.recognizedWords.toLowerCase();

          if (voiceInput.contains('fast') || voiceInput.contains('first')) {
            _applyCoupon(0);
          } else if (voiceInput.contains('healthy') ||
              voiceInput.contains('second')) {
            _applyCoupon(1);
          } else if (voiceInput.contains('order') ||
              voiceInput.contains('third')) {
            _applyCoupon(2);
          } else {
            AccessibilityController.speak(
              "Sorry, I didn't understand. Please say the name or number of the coupon.",
            );
            _startCouponListening();
          }
        },
        listenFor: const Duration(seconds: 5),
        pauseFor: const Duration(seconds: 3),
        partialResults: false,
      );
    }
  }

  void _applyCoupon(int index) async {
    selectedCoupon = coupons[index];
    final match = RegExp(r'Rp\.?\s?([\d.,]+)').firstMatch(selectedCoupon!);
    couponDiscount = match != null
        ? int.parse(match.group(1)!.replaceAll(RegExp(r'[^\d]'), ''))
        : 0;

    await _speech.stop();
    await AccessibilityController.speak('${selectedCoupon!} coupon applied.');

    totalExpenses = subTotal - couponDiscount;

    await AccessibilityController.speak(
      'Your subtotal is Rp. $subTotal, and after applying the coupon discount of Rp $couponDiscount, your total expenses are Rp. $totalExpenses.',
    );

    await AccessibilityController.speak(
      'Now choose your payment method. Say Master Card, Gopay, or Dana.',
    );
    _startPaymentMethodListening();
  }

  void _startPaymentMethodListening() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        onResult: (result) {
          String voiceInput = result.recognizedWords.toLowerCase();

          if (voiceInput.contains('master')) {
            _applyPaymentMethod('Master Card 5055');
          } else if (voiceInput.contains('gopay')) {
            _applyPaymentMethod('Gopay');
          } else if (voiceInput.contains('dana')) {
            _applyPaymentMethod('Dana');
          } else {
            AccessibilityController.speak(
              "Sorry, I didn't catch that. Please say Master Card, Gopay, or Dana.",
            );
            _startPaymentMethodListening();
          }
        },
        listenFor: const Duration(seconds: 5),
        pauseFor: const Duration(seconds: 3),
        partialResults: false,
      );
    }
  }

  void _applyPaymentMethod(String method) async {
    selectedMethod = method;
    await _speech.stop();
    await AccessibilityController.speak('$selectedMethod selected.');

    await AccessibilityController.speak(
      'Do you want to proceed with the payment? Please say yes or no.',
    );
    _startConfirmListening();
  }

  void _startConfirmListening() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        onResult: (result) {
          String voiceInput = result.recognizedWords.toLowerCase();
          if (voiceInput.contains('yes')) {
            _payNow();
          } else if (voiceInput.contains('no')) {
            AccessibilityController.speak('Payment cancelled.');
          } else {
            AccessibilityController.speak("Please say yes or no.");
            _startConfirmListening();
          }
        },
        listenFor: const Duration(seconds: 4),
        pauseFor: const Duration(seconds: 3),
        partialResults: false,
      );
    }
  }

  void _payNow() {
    setState(() {
      subscriptionActive = true;
      stocks['Muscle Meal'] = (stocks['Muscle Meal'] ?? 0) - widget.weeks;
    });

    AccessibilityController.speak('Payment successful. Subscription active.');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Payment Successful. Subscription Active!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: DefaultTextStyle(
            style: const TextStyle(fontFamily: 'NunitoSans'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.green),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Complete Payment',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
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
                      rowItem('Muscle Meal [${widget.weeks} Week(s)]',
                          'Rp. $subTotal'),
                      if (selectedCoupon != null)
                        rowItem(selectedCoupon!, '-Rp. $couponDiscount'),
                      const SizedBox(height: 8),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFECF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Expenses',
                                style: TextStyle(color: Colors.black)),
                            Text(
                              'Rp. $totalExpenses',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // View Coupon Button
                GestureDetector(
                  onTap: toggleCoupons,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
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

                // Slide Down Transition for Coupons
                ClipRect(
                  child: SizeTransition(
                    sizeFactor: _controller,
                    axisAlignment: -1.0,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade900),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: coupons.map((coupon) {
                          final bool isSelected = selectedCoupon == coupon;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCoupon = coupon;
                                final match = RegExp(r'Rp\.?\s?([\d.,]+)')
                                    .firstMatch(coupon);
                                if (match != null) {
                                  couponDiscount = int.parse(
                                    match
                                        .group(1)!
                                        .replaceAll(RegExp(r'[^\d]'), ''),
                                  );
                                } else {
                                  couponDiscount = 0;
                                }
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.green.shade100
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                coupon,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
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
                            selectedMethod = method['name']!;
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
                              ClipOval(
                                child: Image.asset(
                                  method['image']!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  method['name']!,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
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
                      setState(() {
                        subscriptionActive = true;
                        stocks['Muscle Meal'] =
                            (stocks['Muscle Meal'] ?? 0) - widget.weeks;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Payment Successful. Subscription Active!'),
                      ));
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
      ),
    );
  }

  Widget rowItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(title, style: const TextStyle(color: Colors.black))),
          Text(value, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
