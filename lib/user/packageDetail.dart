import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PackageDetailScreen extends StatelessWidget {
  final List<String> mealPlans = [
    "Beef steak, soft boiled eggs, sweet potatoes, steamed corn, quinoa",
    "Minced beef, steamed veggies, scrambled egg, bok choy",
    "Grilled chicken breast, avocado, baby spinach, edamame",
    "Salmon, beet salad, baked sweet potato fries, beans",
    "Beef cubes, carrots, chickpeas, spicy seasoning",
    "Roasted chicken, mashed potatoes, steamed carrots, beetroot salad",
    "Rolled grilled beef slices, roasted bell peppers, quinoa, roasted chickpeas",
  ];
  final List<String> beefOptions = ["Turkey", "Salmon", "Tuna"];
  final List<String> eggOptions = ["Tahini", "Edamame", "Hummus", "Nut butter"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F1),
      body: SingleChildScrollView(
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
                        "Muscle Meal",
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
                        padding: const EdgeInsets.symmetric(horizontal: 30),
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
                        itemCount: mealPlans.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 1),
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
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ),

                                // Meal description text
                                Positioned(
                                  left: 40,
                                  top: 20,
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: Text(
                                    mealPlans[index],
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
                      SizedBox(height: 20),
                      Text("Custom",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 10),
                      Text("I want to change BEEF STEAK to..."),
                      Wrap(
                        spacing: 8,
                        children: beefOptions
                            .map((option) => ChoiceChip(
                                  label: Text(option),
                                  selected: false,
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 16),
                      Text("I want to change BOILED EGG to..."),
                      Wrap(
                        spacing: 8,
                        children: eggOptions
                            .map((option) => ChoiceChip(
                                  label: Text(option),
                                  selected: false,
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[800],
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text("Subscribe Now",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
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
    );
  }
}
