// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:finalmp/models/product_model.dart';
import 'package:finalmp/models/product_detail_screen.dart'; 
import 'package:finalmp/screens/app_drawer.dart'; 


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. DATA WISHLIST (DIKELOLA SEBAGAI STATE LOKAL)
  final Set<String> _wishlistIds = {'P001', 'P003'}; // Contoh ID yang sudah difavoritkan
  
  // Data Dummy Produk LENGKAP (termasuk ID baru)
  final List<Product> itemData = const [
    Product(
      id: 'P001', title: 'Vintage Denim', price: '\$24', condition: 'Like New', size: 'M', brand: 'Vintage Denim', category: 'Clothing', 
      description: 'Deskripsi Item P001', sellerName: 'Sarah Johnson', sellerRating: 4.8, totalSales: 234, discount: '30% OFF'),
    Product(
      id: 'P002', title: 'Nike Air Max', price: '\$45', condition: 'Good', size: 'US 9', brand: 'Nike', category: 'Shoes', 
      description: 'Deskripsi Item P002', sellerName: 'Rian Putra', sellerRating: 4.5, totalSales: 150, discount: ''),
    Product(
      id: 'P003', title: 'Retro Items Collection', price: '\$18', condition: 'Excellent', size: 'N/A', brand: 'Various', category: 'Accessories', 
      description: 'Deskripsi Item P003', sellerName: 'Maya Sari', sellerRating: 4.9, totalSales: 300, discount: '20% OFF'),
    Product(
      id: 'P004', title: 'Designer Leather Bag', price: '\$32', condition: 'Like New', size: 'One Size', brand: 'Luxury Brand', category: 'Bags', 
      description: 'Deskripsi Item P004', sellerName: 'Bella Anggun', sellerRating: 4.7, totalSales: 90, discount: ''),
  ];

  // 2. FUNGSI LOGIKA TOMBOL HATI
  void _toggleWishlist(String productId) {
    setState(() {
      if (_wishlistIds.contains(productId)) {
        _wishlistIds.remove(productId); // Hapus jika sudah ada
      } else {
        _wishlistIds.add(productId); // Tambahkan jika belum ada
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: AppDrawer(
        wishlistIds: _wishlistIds,
        allProducts: itemData,
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 50), 

              // 1. Header (Icon Hati dan Menu)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Ikon Hati (Navigasi)
                  const Icon(Icons.favorite_border, size: 28),
                  
                  Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(Icons.menu, size: 28),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer(); 
                        },
                      );
                    }
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ... (Search Bar, Kategori, Banner, Hot Items Title tetap sama) ...
              
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for items...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildCategoryPill('All', true),
                    _buildCategoryPill('Clothing', false),
                    _buildCategoryPill('Shoes', false),
                    _buildCategoryPill('Bags', false),
                    _buildCategoryPill('Accessories', false),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300], 
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                    image: AssetImage('assets/banner_image.png'), 
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Buy & Sell Preloved Items',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _buildBannerButton('Start Selling', Colors.black, Colors.white, () {}),
                          const SizedBox(width: 10),
                          _buildBannerButton('How It Works', Colors.white, Colors.black, () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Hot Items',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // 6. Grid View Items (2 kolom)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 0.65, 
                ),
                itemCount: itemData.length, // Menggunakan itemData.length
                itemBuilder: (context, index) {
                  return _buildGridItem(context, itemData[index]); 
                },
              ),
              const SizedBox(height: 15), 
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget: Item Grid yang DAPAT DIKLIK dan menavigasi
  Widget _buildGridItem(BuildContext context, Product data) {
    // Cek apakah item ini ada di wishlist
    bool isFavorite = _wishlistIds.contains(data.id);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: data),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Gambar Produk
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300], 
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                  ),
                  child: Center(child: Text(data.title.split(' ')[0], style: const TextStyle(color: Colors.black))), 
                ),
                
                // Label Diskon
                if (data.discount.isNotEmpty)
                  Positioned(
                    top: 10,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                      ),
                      child: Text(
                        data.discount,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                
                // 3. Ikon Hati yang Interaktif
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      _toggleWishlist(data.id); // Panggil fungsi toggle
                    },
                  ),
                ),
              ],
            ),
            
            // Detail Produk
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.price,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(data.size, style: const TextStyle(color: Colors.grey)),
                      const Text(' • ', style: TextStyle(color: Colors.grey)),
                      Text(data.condition, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets Lain (tetap sama) ---
  Widget _buildCategoryPill(String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Chip(
        label: Text(
          title, 
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: isSelected ? Colors.black : Colors.white,
        side: BorderSide(color: Colors.grey.shade300), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildBannerButton(
      String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: textColor == Colors.black ? Colors.white : Colors.black, width: 1.5), 
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        child: Text(text, style: TextStyle(color: textColor, fontSize: 14)),
      ),
    );
  }
}