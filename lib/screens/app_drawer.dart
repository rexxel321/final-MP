// lib/screens/app_drawer.dart

import 'package:flutter/material.dart';
import 'package:finalmp/models/product_model.dart';
import 'package:finalmp/screens/wishlist_screen.dart';
import 'package:finalmp/screens/settings_screen.dart';
import 'package:finalmp/screens/product_detail_screen.dart';

class AppDrawer extends StatelessWidget {
  final Set<String> wishlistIds;      // ID produk yang disukai
  final List<Product> allProducts;    // Semua produk (Firestore + Dummy)

  const AppDrawer({
    super.key,
    required this.wishlistIds,
    required this.allProducts,
  });

  @override
  Widget build(BuildContext context) {
    final List<Product> wishlistItems = allProducts
        .where((item) => wishlistIds.contains(item.id))
        .toList();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // ===========================
          // 1. HEADER DRAWER
          // ===========================
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
                const Text(
                  'Dhiya Ulhaq',
                  style: TextStyle(
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

          // ===========================
          // 2. MENU UTAMA
          // ===========================
          _buildDrawerItem(
            icon: Icons.home_outlined,
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
            },
          ),

          // ===========================
          // WISHLIST NAVIGATE
          // ===========================
          _buildDrawerItem(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WishlistScreen(
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
            onTap: () {},
          ),

          const Divider(),

          // ===========================
          // SETTINGS
          // ===========================
          _buildDrawerItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),

          _buildDrawerItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),

          const Divider(),

          // ===========================
          // 3. LOGOUT
          // ===========================
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            textColor: Colors.red,
            onTap: () {
              Navigator.pop(context);
              // TODO: tambahkan logout auth
            },
          ),

          const Divider(),

          // ===========================
          // 4. DAFTAR WISHLIST DIBAWAH MENU
          // ===========================
          if (wishlistItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Your Favorites",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),

          ...wishlistItems.map((product) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: product.imageUrl.isNotEmpty
                      ? Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Text(
                              product.title.split(' ').first,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                ),
              ),
              title: Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                "Rp${_cleanPrice(product.price)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product: product),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  // ===========================
  // HELPER WIDGET
  // ===========================
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
        style: TextStyle(color: textColor, fontSize: 16),
      ),
      onTap: onTap,
    );
  }

  // ===========================
  // CLEAN PRICE
  // ===========================
  String _cleanPrice(String raw) {
    final cleaned = raw.replaceAll(RegExp(r'[^0-9]'), '');
    return cleaned.isEmpty ? raw : cleaned;
  }
}
