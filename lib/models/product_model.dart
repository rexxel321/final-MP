// lib/models/product_model.dart

class Product {
  final String id; // TAMBAHKAN ID UNIK
  final String title;
  final String price;
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
    required this.id, // WAJIB DISEDIAKAN
    required this.title,
    required this.price,
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
}

// ... (Kelas Seller, Chat, Message tetap sama)
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