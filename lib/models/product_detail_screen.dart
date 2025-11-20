import 'package:flutter/material.dart';
// Import kelas Product dan Seller
import 'package:flutter_application_1/models/product_model.dart'; 
// Import Seller Profile Screen untuk navigasi
import 'package:flutter_application_1/screens/seller_profile_screen.dart'; 

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  // Constructor yang menerima objek Product
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      // Menggunakan CustomScrollView agar konten bisa full-screen dan AppBar transparan
      body: CustomScrollView(
        slivers: <Widget>[
          // SliverAppBar untuk Carousel Gambar
          SliverAppBar(
            expandedHeight: 400.0, // Tinggi gambar/carousel
            pinned: true, // AppBar tetap di atas saat scroll
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageCarousel(), // Widget Carousel Gambar
            ),
            // Tombol Back, Share, dan Favorite
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.black),
                onPressed: () {
                  // TODO: Implementasi Share
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.black),
                onPressed: () {
                  // TODO: Implementasi Favorite
                },
              ),
            ],
          ),
          
          // Detail Konten
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Harga dan Diskon
                      Row(
                        children: [
                          Text(
                            product.price,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          if (product.discount.isNotEmpty)
                            _buildDiscountTag(product.discount),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Judul Produk
                      Text(
                        product.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),

                      // Grid Detail (Condition, Size, Brand, Category)
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 3.5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: <Widget>[
                          _buildDetailBox('Condition', product.condition),
                          _buildDetailBox('Size', product.size),
                          _buildDetailBox('Brand', product.brand),
                          _buildDetailBox('Category', product.category),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Deskripsi
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ),
                      const SizedBox(height: 30),

                      // Profil Penjual (DAPAT DIKLIK)
                      _buildSellerProfile(context, product),
                      const SizedBox(height: 30),
                      
                      // TODO: Tambahkan tombol chat/beli di sini
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // Helper Widget: Carousel Gambar
  Widget _buildImageCarousel() {
    return Stack(
      children: [
        PageView.builder(
          itemCount: 3, // Asumsi 3 gambar
          itemBuilder: (context, index) {
            return Container(
              color: Colors.grey[300], // Placeholder untuk gambar
              child: Center(child: Text("Image ${index + 1}")), 
            );
          },
        ),
      ],
    );
  }

  // Helper Widget: Tag Diskon
  Widget _buildDiscountTag(String discount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        discount,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  // Helper Widget: Kotak Detail (Condition, Size, dll.)
  Widget _buildDetailBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Profil Penjual (DAPAT DIKLIK)
  Widget _buildSellerProfile(BuildContext context, Product product) {
    // Data Seller Dummy (seharusnya diambil dari product.sellerId jika pakai API)
    const Seller sellerData = Seller(
      name: 'Sarah Johnson',
      rating: 4.8,
      reviews: 156,
      sales: 234,
      activeTime: 18,
      responseRate: 98,
      location: 'Brooklyn, New York',
      joinDate: 'Jan 2023',
      bio: "Passionate about sustainable fashion! I love finding preloved treasures and giving them new life. All items are carefully curated and cleaned before listing. Fast shipping and eco-friendly packaging guaranteed! 🌿",
    );
    
    return GestureDetector( // WRAP DENGAN GESTURE DETECTOR UNTUK KLIK
      onTap: () {
        // NAVIGASI KE SELLER PROFILE SCREEN
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SellerProfileScreen(seller: sellerData),
          ),
        );
      },
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            // Placeholder untuk foto profil
            backgroundColor: Colors.grey, 
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.sellerName,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      '${product.sellerRating}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const Text(' • '),
                    Text(
                      '${product.totalSales} sales',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        ],
      ),
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