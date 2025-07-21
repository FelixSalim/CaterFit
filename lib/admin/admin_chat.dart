import 'package:flutter/material.dart';

class ChatDetailPageAdmin extends StatefulWidget {
  const ChatDetailPageAdmin({super.key});

  @override
  State<ChatDetailPageAdmin> createState() => _ChatDetailPageAdminState();
}

class _ChatDetailPageAdminState extends State<ChatDetailPageAdmin> {
  final TextEditingController _messageController = TextEditingController();

  // Chat message model
  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Brr Brr Patapim",
      "isSender": false,
      "type": "text",
      "time": "09:59"
    },
    {
      "text": "Tung Tung Tung Sahur",
      "isSender": true,
      "type": "text",
      "time": "10:00"
    },
    {
      "text": "Assets/friedrice.jpg",
      "isSender": true,
      "type": "image",
      "time": "10:03"
    },
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({
          "text": text,
          "isSender": true,
          "type": "text",
          "time": TimeOfDay.now().format(context)
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEFFDE),
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('Assets/profile.png'),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Carmen",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Online",
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              final isSender = message['isSender'];
              final type = message['type'];

              return Align(
                alignment:
                    isSender ? Alignment.centerRight : Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: isSender
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: type == 'text'
                          ? const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10)
                          : const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD7E893),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: type == 'text'
                          ? Text(message['text'])
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                message['text'],
                                height: 180,
                              ),
                            ),
                    ),
                    Text(
                      message['time'],
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: const Color(0xFFFEFFDE),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.black),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type Here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      // Example: Add a dummy image bubble
                      setState(() {
                        _messages.add({
                          "text": "Assets/friedrice.jpg",
                          "isSender": true,
                          "type": "image",
                          "time": TimeOfDay.now().format(context)
                        });
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
