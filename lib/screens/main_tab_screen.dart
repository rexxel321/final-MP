import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/chat_list_page.dart';
import 'package:flutter_application_1/screens/profile_screen.dart'; 
import 'package:flutter_application_1/screens/search_screen.dart'; 
import 'package:flutter_application_1/screens/Notesing_screen.dart'; // Import Halaman Sell

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0; // Indeks tab yang aktif

  // Daftar semua halaman tab utama yang akan ditampilkan
  final List<Widget> _children = [
    const HomeScreen(),        // Index 0: Home
    const SearchScreen(),       // Index 1: Search
    const Center(child: Text("Sell Action")), // Index 2: Sell (Aksi navigasi dikelola oleh fungsi onTabTapped)
    const ChatListPage(),       // Index 3: Messages
    const ProfileScreen(),      // Index 4: Profile
  ];

  void onTabTapped(int index) {
    // Logika untuk tombol 'Sell' di tengah (Index 2)
    if (index == 2) {
      // NAVIGASI ke CreateListingScreen (Halaman Buat Listing Baru)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateListingScreen(),
          fullscreenDialog: true, // Membuat halaman muncul sebagai modal dari bawah
        ),
      );
      return; // Penting: Jangan ubah _currentIndex, biarkan tab sebelumnya tetap aktif
    }
    
    // Mengubah indeks tab yang aktif untuk tab lainnya
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menampilkan halaman yang sesuai dengan _currentIndex
      body: _children[_currentIndex], 
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        // Panggil fungsi onTabTapped saat tab ditekan
        onTap: onTabTapped, 
        
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          // Tombol tengah Sell (index 2)
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black,
              child: Icon(Icons.add, color: Colors.white, size: 30),
            ),
            label: 'Sell',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}