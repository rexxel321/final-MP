import 'package:flutter/material.dart';
// Import model Chat
import 'package:finalmp/models/product_model.dart'; 
// Import ChatPage untuk navigasi saat item diklik
import 'package:finalmp/screens/chat_page.dart'; 

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  // Data Dummy Chat List
  final List<Chat> dummyChats = const [
    Chat(
      userName: 'Sarah Johnson',
      lastMessage: 'That would be perfect, thank you!',
      time: '10:38 AM',
      unreadCount: 0,
      userAvatar: 'assets/avatar_sarah.png', // Placeholder
    ),
    Chat(
      userName: 'Mike Chen',
      lastMessage: 'Is this still available?',
      time: 'Yesterday',
      unreadCount: 2,
      userAvatar: 'assets/avatar_mike.png', // Placeholder
    ),
    Chat(
      userName: 'Emma Wilsor',
      lastMessage: 'Thanks for the quick response!',
      time: '2 days ago',
      unreadCount: 0,
      userAvatar: 'assets/avatar_emma.png', // Placeholder
    ),
    Chat(
      userName: 'David Lee',
      lastMessage: 'Can you do \$40?',
      time: '3 days ago',
      unreadCount: 1,
      userAvatar: 'assets/avatar_david.png', // Placeholder
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Messages', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, 
      ),
      body: Column(
        children: <Widget>[
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          
          // Chat List
          Expanded(
            child: ListView.builder(
              itemCount: dummyChats.length,
              itemBuilder: (context, index) {
                final chat = dummyChats[index];
                return _buildChatListItem(context, chat);
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: DIHAPUS karena dikelola oleh MainTabScreen
    );
  }

  // Helper Widget: Item dalam List Chat
  Widget _buildChatListItem(BuildContext context, Chat chat) {
    return ListTile(
      onTap: () {
        // NAVIGASI KE CHAT PAGE
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(chatData: chat),
          ),
        );
      },
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            // Ganti dengan Image.asset untuk foto profil
            // backgroundImage: AssetImage(chat.userAvatar), 
          ),
          // Indikator Pesan Belum Dibaca
          if (chat.unreadCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black, // Warna hitam untuk notifikasi
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '${chat.unreadCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        chat.userName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        chat.time,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}