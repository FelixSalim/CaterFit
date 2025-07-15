import 'package:flutter/material.dart';

// void main() {
//   runApp(const ChatApp());
// }

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: const Color(0xFFD7E893),
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 7,
              itemBuilder: (context, index) => const ChatTile(),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFECB),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
             backgroundImage: AssetImage('Assets/salad.jpg'),
            radius: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'User Ganteng',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF31521F),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Hai bang',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const Text(
            '10:00',
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
