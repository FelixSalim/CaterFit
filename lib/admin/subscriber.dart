import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SubscriberPage(),
  ));
}

class Subscriber {
  final String name;
  final String gender;
  final int age;
  final String address;
  final String startDate;
  final String endDate;
  final int daysLeft;
  final String imageUrl;

  Subscriber({
    required this.name,
    required this.gender,
    required this.age,
    required this.address,
    required this.startDate,
    required this.endDate,
    required this.daysLeft,
    required this.imageUrl,
  });
}

class SubscriberPage extends StatefulWidget {
  const SubscriberPage({super.key});

  @override
  State<SubscriberPage> createState() => _SubscriberPageState();
}

class _SubscriberPageState extends State<SubscriberPage> {
  final List<Subscriber> allSubscribers = [
    Subscriber(
      name: 'Calvin Sentosa',
      gender: 'Male',
      age: 19,
      address: 'JL. Pakuan, No. 3',
      startDate: '1 June 2025',
      endDate: '8 June 2025',
      daysLeft: 4,
      imageUrl: 'https://randomuser.me/api/portraits/men/11.jpg',
    ),
    Subscriber(
      name: 'Ricky Gunawan',
      gender: 'Male',
      age: 21,
      address: 'JL. Bunga, Blok C No. 118A',
      startDate: '5 June 2025',
      endDate: '10 June 2025',
      daysLeft: 3,
      imageUrl: 'https://randomuser.me/api/portraits/men/33.jpg',
    ),
    Subscriber(
      name: 'Alicia Tan',
      gender: 'Female',
      age: 22,
      address: 'JL. Mawar No. 8',
      startDate: '2 June 2025',
      endDate: '12 June 2025',
      daysLeft: 5,
      imageUrl: 'https://randomuser.me/api/portraits/women/22.jpg',
    ),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Subscriber> filteredSubscribers = allSubscribers
        .where(
            (sub) => sub.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Subscribers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF11330D),
                ),
              ),
              const SizedBox(height: 16),

              // Search bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search subscriber',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0xFFF7F5C8),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // List of cards
              Expanded(
                child: ListView.builder(
                  itemCount: filteredSubscribers.length,
                  itemBuilder: (context, index) {
                    return subscriberCard(filteredSubscribers[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget subscriberCard(Subscriber sub) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF11330D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(sub.imageUrl),
          ),
          const SizedBox(height: 8),
          Text(
            sub.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),

          // Info items
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 12,
            children: [
              infoItem('Gender', sub.gender),
              infoItem('Age', sub.age.toString()),
              infoItem('Address', sub.address),
              infoItem('Start date', sub.startDate),
              infoItem('End date', sub.endDate),
              infoItem('Days left', '${sub.daysLeft}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F5C8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            value,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
            style: const TextStyle(color: Color(0xFF11330D)),
          ),
        ),
      ],
    );
  }
}
