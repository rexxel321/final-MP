import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Data Dummy Pengguna
  final String userName = "Dhiya Ulhaq";
  final String userLocation = "Jakarta, Indonesia";
  final int totalReviews = 45;
  final double userRating = 4.7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Karena ini adalah tab utama
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // TODO: Navigasi ke Settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Header Profil (Avatar & Nama)
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.person, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${userRating}',
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        ' (${totalReviews} reviews)',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // 2. Statistik Akun (Sama seperti Seller Profile)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('12', 'Items Listed'),
                _buildStatCard('5.5K', 'Followers'),
                _buildStatCard('30%', 'Sales Growth'),
              ],
            ),
            const SizedBox(height: 30),

            // 3. Detail Lokasi & Bergabung
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 20, color: Colors.black),
                const SizedBox(width: 8),
                Text(userLocation, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.black),
                const SizedBox(width: 8),
                const Text('Joined since Mar 2022', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 30),

            // 4. Menu Akun
            const Text(
              'Account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildProfileTile(Icons.shopping_bag_outlined, 'My Orders', () {}),
            _buildProfileTile(Icons.favorite_border, 'Watchlist', () {}),
            _buildProfileTile(Icons.reviews_outlined, 'My Reviews', () {}),
            
            const SizedBox(height: 20),
            
            // 5. Menu Bantuan
            const Text(
              'Help & Support',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildProfileTile(Icons.help_outline, 'Help Center', () {}),
            _buildProfileTile(Icons.logout, 'Logout', () {}),
            
            const SizedBox(height: 50),
          ],
        ),
      ),
      // Bottom Nav Bar dikelola oleh MainTabScreen
    );
  }

  // Helper Widget: Card Statistik
  Widget _buildStatCard(String value, String label) {
    return Container(
      width: 100, 
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Menu Tile
  Widget _buildProfileTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}