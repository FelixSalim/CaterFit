import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'payment.dart';

class PackageDetailScreen extends StatefulWidget {
  static final String packageName = "Muscle Meal";
  static final List<String> mealPlans = [
    "Beef steak, soft boiled eggs, sweet potatoes, steamed corn, quinoa",
    "Minced beef, steamed veggies, scrambled egg, bok choy",
    "Grilled chicken breast, avocado, baby spinach, edamame",
    "Salmon, beet salad, baked sweet potato fries, beans",
    "Beef cubes, carrots, chickpeas, spicy seasoning",
    "Roasted chicken, mashed potatoes, steamed carrots, beetroot salad",
    "Rolled grilled beef slices, roasted bell peppers, quinoa, roasted chickpeas",
  ];
  static final List<String> beefOptions = ["Turkey", "Salmon", "Tuna"];
  static final List<String> eggOptions = [
    "Tahini",
    "Edamame",
    "Hummus",
    "Nut butter"
  ];

  static bool isSubscribing = false;
  static int subscriptionWeeks = 1; //initial subscribe

  static final int stock = 3;

  static final Map<String, String?> selectedOptions = {
    'beef': null,
    'egg': null,
  };

  @override
  _PackageDetailScreenState createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  bool _isAlertVisible = false;
  Timer? _alertTimer;

  @override
  void dispose() {
    _alertTimer?.cancel();
    super.dispose();
  }

  void _showStockAlert() {
    if (_isAlertVisible) return;

    setState(() {
      _isAlertVisible = true;
    });

    // hide alert after 2 secs
    _alertTimer?.cancel();
    _alertTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isAlertVisible = false;
        });
      }
    });
  }

  void _hideAlert() {
    if (_isAlertVisible) {
      _alertTimer?.cancel();
      setState(() {
        _isAlertVisible = false;
      });
    }
  }

  ///confirmed duration function
  void _confirmSubscription() {
    // send data to payment page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PaymentPage(weeks: PackageDetailScreen.subscriptionWeeks),
      ),
    ).then((_) {
      // reset state after returning from payment page
      if (mounted) {
        setState(() {
          PackageDetailScreen.isSubscribing = false;
          PackageDetailScreen.subscriptionWeeks = 1;
        });
      }
    });
  }

  //"Subscribe Now"
  Widget _buildSubscribeButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            PackageDetailScreen.isSubscribing = true;
          });
        },
        key: const Key('subscribeButton'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D3011),
          padding: const EdgeInsets.symmetric(horizontal: 63.5, vertical: 14.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text("Subscribe Now",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            )),
      ),
    );
  }

  // Choose duration of subscribtion
  Widget _buildDurationSelector() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFF0D3011),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Minus
            IconButton(
              key: const Key('minusButton'),
              onPressed: PackageDetailScreen.subscriptionWeeks <= 1
                  ? null // deactivate button if weeks <= 1
                  : () {
                      setState(() {
                        PackageDetailScreen.subscriptionWeeks--;
                      });
                    },
              icon: Icon(Icons.remove,
                  color: PackageDetailScreen.subscriptionWeeks <= 1
                      ? Colors.white.withOpacity(0.5)
                      : Colors.white),
            ),
            const SizedBox(width: 10),
            // Duration Text
            Text(
              '${PackageDetailScreen.subscriptionWeeks} Week(s)',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              key: const Key('durationText'),
            ),
            const SizedBox(width: 10),
            // Plus
            IconButton(
              key: const Key('plusButton'),
              onPressed: () {
                if (PackageDetailScreen.subscriptionWeeks >=
                    PackageDetailScreen.stock) {
                  _showStockAlert();
                } else {
                  setState(() {
                    PackageDetailScreen.subscriptionWeeks++;
                  });
                }
              },
              icon: Icon(Icons.add,
                  color: PackageDetailScreen.subscriptionWeeks >=
                          PackageDetailScreen.stock
                      ? Colors.white.withOpacity(0.5)
                      : Colors.white),
            ),
            // Check
            IconButton(
              onPressed: _confirmSubscription,
              icon: const Icon(Icons.check, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F1),
      // GestureDetector to detect tap outside the alert
      body: GestureDetector(
        onTap: _hideAlert,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // Header image
                  Stack(
                    children: [
                      Container(
                        height: 400,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'Assets/musclemeal.jpg'), // Replace with actual asset
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Details
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(top: 250),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEFFDE),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(70)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              PackageDetailScreen
                                  .packageName, // Menggunakan variabel nama paket
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0D3011),
                              ),
                            ),
                            Text(
                              "Rp400.000",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF0D3011),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "High-protein catering package crafted to support muscle growth and post-workout recovery. Packed with premium grilled meats, eggs, quinoa, and fresh veggies, each box delivers maximum energy and balanced nutrition to fuel your active lifestyle.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 14,
                                  color: const Color(0xFF0D3011),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Meal Plan",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: const Color(0xFF0D3011),
                              ),
                            ),
                            ListView.builder(
                              itemCount: PackageDetailScreen.mealPlans.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 1),
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      // Background image
                                      Image.asset(
                                        'Assets/muscleplan${index + 1}.png', // Replace with actual assets
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),

                                      // Dark gradient overlay at bottom
                                      Positioned.fill(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.75),
                                          ),
                                        ),
                                      ),

                                      // Meal description text
                                      Positioned(
                                        left: 40,
                                        top: 20,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        child: Text(
                                          PackageDetailScreen.mealPlans[index],
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          textWidthBasis: TextWidthBasis.parent,
                                          style: GoogleFonts.nunitoSans(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            shadows: [
                                              const Shadow(
                                                blurRadius: 2,
                                                color: Colors.black54,
                                                offset: Offset(1, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            Text("Custom",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  color: const Color(0xFF0D3011),
                                )),
                            const SizedBox(height: 10),
                            Text(
                              "I want to change BEEF STEAK to...",
                              style: GoogleFonts.nunitoSans(
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                                color: const Color(0xFF0D3011),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children:
                                  PackageDetailScreen.beefOptions.map((option) {
                                final isSelected = PackageDetailScreen
                                        .selectedOptions['beef'] ==
                                    option;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      PackageDetailScreen.selectedOptions[
                                          'beef'] = PackageDetailScreen
                                                  .selectedOptions['beef'] ==
                                              option
                                          ? null
                                          : option;
                                    });
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: Image.asset(
                                              'Assets/${option.replaceAll(' ', '_').toLowerCase()}-custom.png',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          if (isSelected)
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text(option,
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 14,
                                            color: const Color(0xFF0D3011),
                                            fontStyle: FontStyle.italic,
                                          )),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "I want to change BOILED EGG to...",
                              style: GoogleFonts.nunitoSans(
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                                color: const Color(0xFF0D3011),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children:
                                  PackageDetailScreen.eggOptions.map((option) {
                                final isSelected = PackageDetailScreen
                                        .selectedOptions['egg'] ==
                                    option;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      PackageDetailScreen
                                              .selectedOptions['egg'] =
                                          PackageDetailScreen
                                                      .selectedOptions['egg'] ==
                                                  option
                                              ? null
                                              : option;
                                    });
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: Image.asset(
                                              'Assets/${option.replaceAll(' ', '_').toLowerCase()}-custom.png',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          if (isSelected)
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        option,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 14,
                                          color: const Color(0xFF0D3011),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 30),

                            // switch the button widget
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: PackageDetailScreen.isSubscribing
                                  ? _buildDurationSelector()
                                  : _buildSubscribeButton(),
                            ),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 16,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.5),
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(12),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFFFEFFDE),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Alert Widget
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedOpacity(
                key: const Key('stockAlert'),
                // opacity
                opacity: _isAlertVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                // IgnorePointer
                child: IgnorePointer(
                  ignoring: !_isAlertVisible,
                  child: Container(
                    width: double.infinity, // screen width
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    decoration: const BoxDecoration(
                      color: Color(0xFFCDE38B),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Text(
                      // alert text
                      '${PackageDetailScreen.packageName} package only has ${PackageDetailScreen.stock} left in stock.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xFF0D3011),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
