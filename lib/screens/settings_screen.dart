import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Settings', 
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Account Settings Section
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'ACCOUNT SETTINGS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            _buildSettingTile(
              context, 
              icon: Icons.person_outline, 
              title: 'Edit Profile', 
              subtitle: 'Change username, email, and password', 
              onTap: () {
                // TODO: Navigasi ke halaman Edit Profil
                _showSnackbar(context, 'Go to Edit Profile');
              }
            ),
            _buildSettingTile(
              context, 
              icon: Icons.location_on_outlined, 
              title: 'Shipping Addresses', 
              subtitle: 'Manage saved delivery locations', 
              onTap: () {
                // TODO: Navigasi ke halaman Alamat Pengiriman
                _showSnackbar(context, 'Go to Shipping Addresses');
              }
            ),

            // 2. Notification Settings Section
            const Divider(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'NOTIFICATIONS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            _buildToggleSetting(
              context, 
              icon: Icons.message_outlined, 
              title: 'Message Notifications', 
              initialValue: true, 
              onChanged: (bool value) {
                // TODO: Simpan status notifikasi ke Firebase
                _showSnackbar(context, 'Messages: $value');
              }
            ),
            _buildToggleSetting(
              context, 
              icon: Icons.favorite_border, 
              title: 'Wishlist/Sale Alerts', 
              initialValue: false, 
              onChanged: (bool value) {
                // TODO: Simpan status notifikasi ke Firebase
                _showSnackbar(context, 'Sales Alerts: $value');
              }
            ),
            
            // 3. Legal & Support Section
            const Divider(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'LEGAL & SUPPORT',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            _buildSettingTile(
              context, 
              icon: Icons.policy_outlined, 
              title: 'Privacy Policy', 
              onTap: () {
                // TODO: Buka tautan kebijakan privasi
                _showSnackbar(context, 'Open Privacy Policy');
              }
            ),
            _buildSettingTile(
              context, 
              icon: Icons.gavel_outlined, 
              title: 'Terms of Service', 
              onTap: () {
                // TODO: Buka tautan ketentuan layanan
                _showSnackbar(context, 'Open Terms of Service');
              }
            ),
            _buildSettingTile(
              context, 
              icon: Icons.help_outline, 
              title: 'Help Center', 
              onTap: () {
                // TODO: Navigasi ke halaman pusat bantuan
                _showSnackbar(context, 'Go to Help Center');
              }
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Helper function untuk menampilkan Snackbar
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Helper Widget: ListTile Biasa
  Widget _buildSettingTile(BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  // Helper Widget: ListTile dengan Toggle Switch
  Widget _buildToggleSetting(BuildContext context, {
    required IconData icon,
    required String title,
    required bool initialValue,
    required ValueChanged<bool> onChanged,
  }) {
    return StatefulBuilder( // Menggunakan StatefulBuilder untuk mengelola state Switch secara lokal
      builder: (context, setState) {
        bool currentValue = initialValue;
        return ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          trailing: Switch(
            value: currentValue,
            onChanged: (bool value) {
              setState(() {
                currentValue = value;
              });
              onChanged(value); // Panggil fungsi utama saat nilai berubah
            },
            activeColor: Colors.black, // Warna aktif
          ),
          onTap: () {
            // Membalikkan nilai saat tap pada seluruh tile
            onChanged(!currentValue);
            setState(() {
              currentValue = !currentValue;
            });
          },
        );
      },
    );
  }
}