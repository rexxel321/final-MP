// lib/screens/chat_page.dart

import 'package:flutter/material.dart';
import 'package:finalmp/models/product_model.dart';
import 'package:finalmp/screens/product_detail_screen.dart';

class ChatPage extends StatelessWidget {
  final Chat chatData;

  const ChatPage({super.key, required this.chatData});

  // Data Dummy Produk yang Sedang Dibicarakan
  final Product discussedProduct = const Product(
    id: 'D001',
    title: 'Vintage Denim Jacket',
    price: '24000', // akan ditampilkan jadi Rp24000 di tempat lain
    imageUrl:
        'https://via.placeholder.com/400x300?text=Vintage+Denim+Jacket', // <-- WAJIB, biar sesuai model
    condition: 'Like New',
    size: 'M',
    brand: 'Vintage Denim',
    category: 'Clothing',
    description: 'This is the item discussed in this chat.',
    sellerName: 'Sarah Johnson',
    sellerRating: 4.8,
    totalSales: 234,
    discount: '',
  );

  // Data Dummy Pesan
  final List<Message> dummyMessages = const [
    Message(
      text:
          'Hi! Thanks for your interest in the item. Let me know if you have any questions!',
      time: '10:30 AM',
      isMe: false,
    ),
    Message(
      text: 'Hello! Is this item still available?',
      time: '10:32 AM',
      isMe: true,
    ),
    Message(
      text: 'Yes, it\'s still available! 😉',
      time: '10:33 AM',
      isMe: false,
    ),
    Message(
      text: 'Great! Can you tell me more about the condition?',
      time: '10:35 AM',
      isMe: true,
    ),
    Message(
      text:
          'It\'s in excellent condition, barely worn. I can send you more photos if you\'d like!',
      time: '10:36 AM',
      isMe: false,
    ),
    Message(
      text: 'That would be perfect, thank you!',
      time: '10:38 AM',
      isMe: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatData.userName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Active now',
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.more_vert, color: Colors.black),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          // 1. List Pesan
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: dummyMessages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(
                  dummyMessages[dummyMessages.length - 1 - index],
                );
              },
            ),
          ),

          // 2. Card Produk di Bagian Bawah
          _buildProductCard(context),

          // 3. Input Text Bar
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.black),
                  onPressed: () {
                    // TODO: Logic kirim pesan
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bubble chat
  Widget _buildMessageBubble(Message message) {
    final alignment =
        message.isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color = message.isMe ? Colors.black : Colors.grey[200];
    final textColor = message.isMe ? Colors.white : Colors.black;

    return Container(
      alignment: alignment,
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            constraints: const BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: message.isMe
                    ? const Radius.circular(15)
                    : const Radius.circular(0),
                bottomRight: message.isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(15),
              ),
            ),
            child: Text(
              message.text,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 4.0,
              right: message.isMe ? 5.0 : 0,
              left: message.isMe ? 0 : 5.0,
            ),
            child: Text(
              message.time,
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  // Card produk yang dibicarakan
  Widget _buildProductCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            color: Colors.grey[300], // placeholder gambar produk
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  discussedProduct.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${discussedProduct.price} • ${discussedProduct.condition}',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailScreen(product: discussedProduct),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: const Size(100, 35),
            ),
            child: const Text(
              'View Listing',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
