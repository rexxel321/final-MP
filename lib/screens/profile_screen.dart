import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:finalmp/screens/login_screen.dart';
import 'package:finalmp/screens/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> handleLogout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("User belum login")),
      );
    }

    final uid = user!.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection("users").doc(uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return _buildScaffold(
            context,
            fullName: user!.email ?? "No Name",
            location: "Unknown location",
            rating: 0.0,
            reviews: 0,
            onLogout: handleLogout,
            onEdit: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        final fullName = (data["fullName"] ?? user!.email ?? "No Name") as String;
        final location = (data["location"] ?? "Jakarta, Indonesia") as String;

        final totalReviews = (data["totalReviews"] ?? 45) as int;
        final userRating = (data["userRating"] ?? 4.7).toDouble();

        return _buildScaffold(
          context,
          fullName: fullName,
          location: location,
          rating: userRating,
          reviews: totalReviews,
          onLogout: handleLogout,
          onEdit: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfileScreen()),
            );
          },
        );
      },
    );
  }

  Scaffold _buildScaffold(
    BuildContext context, {
    required String fullName,
    required String location,
    required double rating,
    required int reviews,
    required VoidCallback onLogout,
    required VoidCallback onEdit,
  }) {
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
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: onEdit,
            tooltip: "Edit Profile",
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // TODO: Settings screen kalau ada
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                    fullName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        ' ($reviews reviews)',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

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
                const Icon(Icons.location_on_outlined,
                    size: 20, color: Colors.black),
                const SizedBox(width: 8),
                Text(location, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 20, color: Colors.black),
                const SizedBox(width: 8),
                const Text('Joined since Mar 2022',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
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
            _buildProfileTile(Icons.logout, 'Logout', onLogout),

            const SizedBox(height: 50),
          ],
        ),
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

  Widget _buildProfileTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
