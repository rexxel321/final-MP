// lib/screens/wishlist_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_model.dart';


class WishlistScreen extends StatelessWidget {
  final Set<String> currentWishlistIds; // Daftar ID favorit dari HomeScreen
  final List<Product> allProducts; // Daftar semua produk

  const WishlistScreen({
    super.key, 
    required this.currentWishlistIds,
    required this.allProducts,
  });

  // Ambil produk yang sesuai dengan ID di wishlist
  List<Product> get wishlistItems {
    return allProducts
        .where((product) => currentWishlistIds.contains(product.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> items = wishlistItems;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Wishlist', 
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                'Your Wishlist is empty!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _buildWishlistItem(context, item);
              },
            ),
    );
  }
  
  // Widget untuk menampilkan satu item di Wishlist
  Widget _buildWishlistItem(BuildContext context, Product item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Area Gambar
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(item.title.split(' ').first, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 15),

            // Detail Produk
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Condition: ${item.condition}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.price,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
            
            // Tombol Aksi (Hapus dan Beli)
            Column(
              children: <Widget>[
                // Tombol Hapus/Un-save
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    // Logika menghapus harus dipanggil kembali ke HomeScreen melalui State Management
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Hapus dari Wishlist memerlukan State Management!')),
                    );
                  },
                ),
                // Tombol Beli (Simulasi)
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Navigasi ke Checkout...')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    child: const Text('Buy', style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}