import 'package:flutter/material.dart';
// Import kelas Seller
import 'package:flutter_application_1/models/product_model.dart'; 

class SellerProfileScreen extends StatelessWidget {
  final Seller seller;

  const SellerProfileScreen({super.key, required this.seller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Tombol kembali (Back)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Seller Profile', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              
              // 1. Header Profil (Foto, Nama, Rating)
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey, // Placeholder foto
                    ),
                    const SizedBox(height: 10),
                    Text(
                      seller.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${seller.rating}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          ' (${seller.reviews} reviews)',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // 2. Statistik (Sales, Active, Response)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('${seller.sales}', 'Sales'),
                  _buildStatCard('${seller.activeTime}', 'Active'),
                  _buildStatCard('${seller.responseRate}%', 'Response'),
                ],
              ),
              const SizedBox(height: 25),

              // 3. Detail Lokasi & Tanggal Bergabung
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 20, color: Colors.black),
                  const SizedBox(width: 8),
                  Text(seller.location, style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.black),
                  const SizedBox(width: 8),
                  Text('Member since ${seller.joinDate}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 25),

              // 4. Bagian About
              const Text(
                'About',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                seller.bio,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 30),

              // 5. Listed Items (Judul dan Grid)
              const Text(
                'Listed Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              
              // Grid item yang sama dengan Home Screen (menggunakan placeholder)
              _buildListedItemsGrid(), 
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      // Bottom Nav Bar tetap dipertahankan
      bottomNavigationBar: _buildBottomNav(context),
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
  
  // Helper Widget: Grid Items Penjual
  Widget _buildListedItemsGrid() {
    // Data dummy untuk produk penjual
    final listedItems = [
        {'title': 'Vintage Denim', 'price': '\$24', 'condition': 'Like New', 'image': 'assets/item_denim.png'},
        {'title': 'Nike Sneakers', 'price': '\$45', 'condition': 'Good', 'image': 'assets/item_shoes.png'},
        {'title': 'Designer Bag', 'price': '\$32', 'condition': 'Like New', 'image': 'assets/item_bag.png'},
        {'title': 'Retro Items', 'price': '\$18', 'condition': 'Excellent', 'image': 'assets/item_retro.png'},
    ];
    
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 0.65, 
        ),
        itemCount: listedItems.length,
        itemBuilder: (context, index) {
          final item = listedItems[index];
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey.shade200)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                  ),
                  child: Center(child: Text(item['title']!)), // Placeholder Gambar
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item['price']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(item['title']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Text(item['condition']!, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
    );
  }

  // Helper Widget: Bottom Nav Bar
  Widget _buildBottomNav(BuildContext context) {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, 
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
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
        onTap: (index) {
          // TODO: Implementasi Navigasi Bottom Bar
        },
      );
  }
}