import 'package:flutter/material.dart';

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
                    children: const [
                      Text(
                        'Current Plan',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Paket Anak Sekolah',
                        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Start date', style: TextStyle(color: Colors.green)),
                              Text('01 June 2025'),
                            ],
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('End date', style: TextStyle(color: Colors.red)),
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
                              Text('Days Left', style: TextStyle(color: Colors.orange)),
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
            const Text(
              'Upcoming Menu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildMenuRow(),
            const SizedBox(height: 30),
            const Text(
              'Recent Menu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F4EA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Tuesday, 3 June 2025',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _buildMenuRow(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMenuRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMenuItem('Salad', 'Assets/salad.jpg'),
        _buildMenuItem('Fried Rice', 'Assets/friedrice.jpg'),
        _buildMenuItem('Dessert', 'Assets/icecream.jpg'),
      ],
    );
  }

  Widget _buildMenuItem(String title, String imageUrl) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F6D9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(title),
        ),
      ],
    );
  }
}