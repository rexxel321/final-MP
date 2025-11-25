import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // kalau somehow belum login
      return const Center(child: Text("Not logged in"));
    }

    final uid = user.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // optional: ke settings screen
            },
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("User data not found"));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final fullName = data["fullName"] ?? "No Name";
          final email = data["email"] ?? user.email ?? "-";
          final location = data["location"] ?? "No location";
          final photoUrl = data["photoUrl"];

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Header profile
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        backgroundImage: (photoUrl != null && photoUrl.toString().isNotEmpty)
                            ? NetworkImage(photoUrl)
                            : null,
                        child: (photoUrl == null || photoUrl.toString().isEmpty)
                            ? const Icon(Icons.person, color: Colors.white, size: 40)
                            : null,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        fullName,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        email,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10),

                      // tombol edit profile
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EditProfileScreen(userData: data)),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                        ),
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Statistik dummy tetap boleh
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard('12', 'Items Listed'),
                    _buildStatCard('5.5K', 'Followers'),
                    _buildStatCard('30%', 'Sales Growth'),
                  ],
                ),
                const SizedBox(height: 30),

                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 20, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(location, style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 15),

                const SizedBox(height: 30),

                const Text(
                  'Account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildProfileTile(Icons.shopping_bag_outlined, 'My Orders', () {}),
                _buildProfileTile(Icons.favorite_border, 'Watchlist', () {}),
                _buildProfileTile(Icons.reviews_outlined, 'My Reviews', () {}),

                const SizedBox(height: 20),

                const Text(
                  'Help & Support',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildProfileTile(Icons.help_outline, 'Help Center', () {}),

                // LOGOUT real
                _buildProfileTile(Icons.logout, 'Logout', () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  }
                }),

                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }

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
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
