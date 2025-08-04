import 'dart:async';
import 'package:caterfit/controller/accessibility_controller.dart';
import 'package:caterfit/user/navbarUser.dart';
import 'package:caterfit/user/packageMenu.dart';
import 'package:caterfit/login.dart'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';


class HomeScreen extends StatefulWidget {
  final String username;
  static String response = "Response";
  static String orderStatus = "Received";
  static String packageName = "Muscle Meal";

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  Timer? _holdTimer;

  @override
  void initState() {
    // Nanti apus yaa
    // AccessibilityController.isEnabled = true;
    // Sampe sini
    super.initState();
    welcomeToCaterfit(context);
  }


  void _handleTouchDown(TapDownDetails details) async {
    if (await AccessibilityController.getIsEnabled()) {
      _holdTimer?.cancel();
      _holdTimer = Timer(const Duration(seconds: 5), () {
        AccessibilityController.isEnabled = false;
        AccessibilityController.speak("Deactivating voice command. Logging you out.");
        _navigateToLoginPage();
      });
    }
  }


  void _handleTouchUp(TapUpDetails details) {
    _holdTimer?.cancel();
  }

  void _navigateToLoginPage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false, // Remove all previous routes
    );
  }

  void deactivateVoiceCommand() async {
    if (await AccessibilityController.getIsEnabled()) {
      await AccessibilityController.speak("Please hold your screen for 5 seconds to deactivate voice command.");
    }
  }

  void todaysOrderStatus() async {
    if (await AccessibilityController.getIsEnabled()) {
      await AccessibilityController.speak("Your have an order for " + HomeScreen.packageName + "package");
      await AccessibilityController.speak("Your menu includes Salmon Fried Rice, Chicken Wrap, and Cornflakes Bowl.");
      await AccessibilityController.speak("Your order status is: " + HomeScreen.orderStatus);
    }
  }

  void welcomeToCaterfit(BuildContext context) async {
    if (await AccessibilityController.getIsEnabled()) {
      await AccessibilityController.speak("Hi " + widget.username + ", welcome to CaterFit!");
      await AccessibilityController.speak("You're currently on the home page. What would you like to do?");
      await AccessibilityController.speak("1. Check order status.");
      await AccessibilityController.speak("2. View package menu.");
      await AccessibilityController.speak("3. Deactivate voice command. Please note that deactivating voice command will log you out, and you'll need to log in again.");
      await AccessibilityController.speak("4. Exit the app.");


      bool available = await _speech.initialize();
      if (available) {
        _speech.listen(
          onResult: (result) {
            HomeScreen.response = result.recognizedWords;
            if (HomeScreen.response.toLowerCase() == "one") {
              AccessibilityController.speak("you chose one"); 
              todaysOrderStatus();
            } else if (HomeScreen.response.toLowerCase() == "two") {
              AccessibilityController.speak("you chose two. You will be directed to the package menu"); 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CaterfitPackageScreen(),
                ),
              );
            } else if (HomeScreen.response.toLowerCase() == "three") {
              AccessibilityController.speak("you chose three. To deactivate voice command"); 
              deactivateVoiceCommand();
            } else if (HomeScreen.response.toLowerCase() == "four"){
              AccessibilityController.speak("you chose four. Exiting the app"); 
              Navigator.of(context).pop();
            } else {
              AccessibilityController.speak("Sorry, I didn't understand that. Please try again.");
            }
          },
          listenFor: const Duration(seconds: 5),
          pauseFor: const Duration(seconds: 5), // extended to avoid early stop
          partialResults: false,
        );
        
        await Future.delayed(const Duration(seconds: 6)); // wait for speech to complete
        if (_speech.isListening) {
          await _speech.stop(); // stop before starting next listen
        }
      }
    }
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _speech.stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // GestureDetector is used to detect the long press on the entire screen.
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // Ensures the entire area is tappable.
      onTapDown: _handleTouchDown,
      onTapUp: _handleTouchUp,
      onTapCancel: () {
        _holdTimer?.cancel();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // --- HEADER ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${widget.username}!",
                          style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0D3011),
                          ),
                        ),
                        Text(
                          "Let's find your healthy meal",
                          style: GoogleFonts.nunitoSans(
                            fontSize: 15,
                            color: const Color(0xFF797979),
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage('Assets/profile.png'),
                      radius: 24,
                    )
                  ],
                ),

                // --- CAROUSEL ---
                const SizedBox(height: 20),
                PromoCarousel(),
                const SizedBox(height: 32),
                Text(
                  "Today’s Package",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0D3011),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildTodayCard(
                        imagePath: 'Assets/salmon-custom.png',
                        title: "Salmon Fried Rice",
                        subtitle: "Fried Rice, Salmon, Egg, Leek, Peas, Carrot",
                      ),
                      _buildTodayCard(
                        imagePath: 'Assets/salmon-custom.png',
                        title: "Chicken Wrap",
                        subtitle: "Chicken, Sausage, Tomato, Cabbage, Egg",
                      ),
                      _buildTodayCard(
                        imagePath: 'Assets/salmon-custom.png',
                        title: "Cornflakes Bowl",
                        subtitle: "Brownies, Cornflakes, Marshmallow, Berry",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // --- Main Feedback Container ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                          20, 20, 0, 20), // Add top padding
                      decoration: BoxDecoration(
                        color: const Color(0xFFCDE38B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                right:
                                    130), // Customize as needed (top, left, etc.)
                            child: Text(
                              "How was your meal today?",
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0D3011),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.only(
                                right:
                                    150), // Change this as needed (top, bottom, left, right)
                            child: Text(
                              "Tell us what you loved or what could be better. Happy or not with your meal? We're here to listen!",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                color: const Color(0xFF0D3011),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                right:
                                    150), // Change this as needed (top, bottom, left, right)
                            child: Text(
                              "\n– CaterFit, “Healthy Catering for Your Fit Life”",
                              style: GoogleFonts.nunitoSans(
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                color: const Color(0xFF0D3011),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // --- Floating Image Positioned at Top Center ---
                    Positioned(
                      top: -30, // floats above the container
                      left: 220,
                      right: 0,
                      child: Center(
                        child: Image.asset(
                          'Assets/ChatUs.png',
                          width: 140,
                          height: 140,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PromoCarousel extends StatelessWidget {
  final PageController _pageController = PageController(viewportFraction: 1);

  PromoCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Container luar
    return SizedBox(
      height: 197,
      // margin: EdgeInsets.only(bottom: 20),
      child: PageView.builder(
        controller: _pageController,
        itemCount: 2, // jumlah item promo
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // child: _buildPromoCard(index),
            child: index == 0 ? _buildPromoCard1(context) : _buildPromoCard2(),
          );
        },
      ),
    );
  }

  // --- PROMOTION ---
  Widget _buildPromoCard1(BuildContext context) {
    final GlobalKey<HomePageState> navbarKey = GlobalKey<HomePageState>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFFDE),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // --- TEXT & BUTTON ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "50%",
                        style: GoogleFonts.montserrat(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0D3011),
                          shadows: const [
                            Shadow(
                              offset: Offset(0, 4),
                              color: Colors.black26,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Discount packages",
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF0D3011),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // --- BUTTON ---
                      const SizedBox(height: 2),
                      ElevatedButton(
                        onPressed: () {
                          Navbar.of(context)?.changeTab(1);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D3011),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          elevation: 4,
                          shadowColor: Colors.black38,
                        ),
                        child: Text(
                          "Subscribe Now",
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFFFEFFDE),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 140), // Space to make room for image
              ],
            ),
          ),

          // --- POSITIONED IMAGE ---
          Positioned(
            right: -20,
            top: -50,
            child: Image.asset(
              'Assets/promotion.png',
              height: 215,
            ),
          ),
        ],
      ),
    );
  }

  // --- HEALTH INFO ---
  Widget _buildPromoCard2() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFFDE),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // --- TEXT & LIST ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Healthy Life Tips",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0D3011),
                          shadows: const [
                            Shadow(
                              offset: Offset(0, 4),
                              color: Colors.black26,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0), // indent tips
                        child: Text(
                          "1. Eat 3 meals a day + healthy snacks\n"
                          "2. Limit fried & fast foods and sweet drinks\n"
                          "3. Drink 8 glasses of water/day\n"
                          "4. Pay attention to portion sizes\n"
                          "5. Combine with regular exercise",
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFF0D3011),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 80), // slightly smaller gap than before
              ],
            ),
          ),

          // --- POSITIONED IMAGE ---
          Positioned(
            right: -15, // move image more to the right
            top: -22,
            child: Image.asset(
              'Assets/quickTips.png',
              height: 104,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTodayCard({
  required String imagePath,
  required String title,
  required String subtitle,
}) {
  return Container(
    width: 180,
    margin: const EdgeInsets.only(right: 16),
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter, // Center the image horizontally
      children: [
        // Main Card
        Positioned(
          top: 50,
          child: Container(
            width: 180,
            decoration: BoxDecoration(
              color: const Color(0xFFFEFFDE),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(12, 60, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0D3011),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 12,
                    color: const Color(0xFF0D3011),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.local_shipping,
                        size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      HomeScreen.orderStatus,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 12,
                        color: const Color(0xFF0D3011),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Centered Floating Image without Shadow
        Positioned(
          top: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}