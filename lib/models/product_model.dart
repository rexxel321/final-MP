// lib/models/product_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String title;
  final String price;
  final String imageUrl;     // <- field gambar
  final String discount;
  final String condition;
  final String size;
  final String brand;
  final String category;
  final String description;
  final String sellerName;
  final double sellerRating;
  final int totalSales;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,   // <- wajib diisi
    this.discount = '',
    required this.condition,
    required this.size,
    required this.brand,
    required this.category,
    required this.description,
    required this.sellerName,
    required this.sellerRating,
    required this.totalSales,
  });

  /// KONVERSI DOKUMEN FIRESTORE → OBJECT PRODUCT
  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    double parseRating(dynamic value) {
      if (value is num) return value.toDouble();
      return 0.0;
    }

    int parseInt(dynamic value) {
      if (value is int) return value;
      if (value is num) return value.toInt();
      return 0;
    }

    return Product(
      id: doc.id,
      title: data['title'] ?? 'Unknown',
      price: (data['price'] ?? '').toString(),
      imageUrl: data['imageUrl'] ?? '',          // <- ambil dari Firestore
      discount: data['discount'] ?? '',
      condition: data['condition'] ?? '-',
      size: data['size'] ?? '-',
      brand: data['brand'] ?? '-',
      category: data['category'] ?? '-',
      description: data['description'] ?? '-',
      sellerName: data['sellerId'] ?? 'Unknown Seller',
      sellerRating: parseRating(data['sellerRating']),
      totalSales: parseInt(data['totalSales']),
    );
  }
}

// =============================
// KELAS LAIN (Seller, Chat, Message)
// =============================

class Seller {
  final String name;
  final double rating;
  final int reviews;
  final int sales;
  final int activeTime;
  final int responseRate;
  final String location;
  final String joinDate;
  final String bio;

  const Seller({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.sales,
    required this.activeTime,
    required this.responseRate,
    required this.location,
    required this.joinDate,
    required this.bio,
  });
}

class Chat {
  final String userName;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String userAvatar;

  const Chat({
    required this.userName,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    required this.userAvatar,
  });
}

class Message {
  final String text;
  final String time;
  final bool isMe;

  const Message({
    required this.text,
    required this.time,
    required this.isMe,
  });
}
