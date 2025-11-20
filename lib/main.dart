import 'package:flutter/material.dart';
// Ganti 'flutter_application_1' dengan nama proyek Anda yang sebenarnya 
// (lihat di pubspec.yaml atau folder root Anda)
import 'package:flutter_application_1/screens/login_screen.dart'; 


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hapus banner "Debug" di kanan atas (opsional)
      debugShowCheckedModeBanner: false, 
      title: 'Preloved Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set LoginScreen sebagai halaman awal
      home: const LoginScreen(), 
    );
  }
}