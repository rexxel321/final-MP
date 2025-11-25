// lib/widgets/app_drawer.dart

import 'package:flutter/material.dart';
import 'package:finalmp/models/product_model.dart';
import 'package:finalmp/screens/wishlist_screen.dart';
import 'package:finalmp/screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  final Set<String> wishlistIds;
  final List<Product> allProducts;

  const AppDrawer({
    super.key,
    required this.wishlistIds,
    required this.allProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // 1. Header Drawer (bisa diisi info user atau logo)
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black, size: 30),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dhiya Ulhaq', // Nama user
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Lihat Profil',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // 2. Item Menu Utama
          _buildDrawerItem(
            icon: Icons.home_outlined,
            title: 'Home',
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              // TODO: Navigasi ke MainTabScreen Index 0 (Home)
            },
          ),
          _buildDrawerItem(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishlistScreen(
                    currentWishlistIds: wishlistIds,
                    allProducts: allProducts,
                  ),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigasi ke halaman Orders
            },
          ),
          const Divider(),

          // 3. Item Pengaturan & Bantuan
          _buildDrawerItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigasi ke halaman Help
            },
          ),
          
          // 4. Logout
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            textColor: Colors.red,
            onTap: () {
              Navigator.pop(context);
              // TODO: Tampilkan konfirmasi Logout dan navigasi ke LoginScreen
            },
          ),
        ],
      ),
    );
  }

  // Helper Widget: Item Baris Menu
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color textColor = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: textColor),
      ),
      onTap: onTap,
    );
  }
}