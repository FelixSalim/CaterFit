import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'nosubscription.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Plan Card
            Container(
              margin: const EdgeInsets.only(top: 70),
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9D5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 10,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.green.withOpacity(0.2),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 120,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.green.withOpacity(0.2),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 60,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.green.withOpacity(0.2),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Current Plan',
                        style: GoogleFonts.montserrat(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,  
                          color: const Color(0xFF0D3011),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Paket Anak Sekolah',
                        style: GoogleFonts.montserrat(
                            fontSize: 20, 
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF0D3011),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Start date',
                                  style: GoogleFonts.montserrat(color: const Color(0xFF319F43))),
                              Text('01 June 2025'),
                            ],
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('End date',
                                  style: GoogleFonts.montserrat(color: Colors.red)),
                              Text('08 June 2025'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Days Left',
                                  style: GoogleFonts.montserrat(color: Colors.orange)),
                              Text('4 days'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Upcoming Menu',
              style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildMenuRow(),
            const SizedBox(height: 30),
            Text(
              'Recent Menu',
              style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFCDE38B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Tuesday, 3 June 2025',
                style:
                    GoogleFonts.montserrat(color: const Color(0xFF0D3011), fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _buildMenuRow(),
            // Add this at the end of the children: [] list inside the Column
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoSubscriptionPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Cancel Subscription',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ],
          
        ),
      ),
    );
  }

  Widget _buildMenuRow() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        _buildMenuItem('Salad', 'Assets/salad.jpg'),
        const SizedBox(width: 16),
        _buildMenuItem('Fried Rice', 'Assets/friedrice.jpg'),
        const SizedBox(width: 16),
        _buildMenuItem('Dessert', 'Assets/icecream.jpg'),
      ],
    ),
  );
}

  Widget _buildMenuItem(String title, String imageUrl) {
  return Column(
    children: [
      Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: 150,
              height: 175,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 15,
            left: 35,
            right: 35,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFEFFDE),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: const Color(0xFF0D3011),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

}
