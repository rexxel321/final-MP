// lib/screens/create_listing_screen.dart

import 'package:flutter/material.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  // Global key untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Kategori yang diizinkan sesuai permintaan user
  final List<String> _categories = [
    'Clothing',
    'Shoes',
    'Bags',
    'Accessories',
    'Other',
  ];

  // List Kondisi Barang
  final List<String> _conditions = [
    'New',
    'Like New',
    'Excellent',
    'Good',
    'Fair',
  ];

  // Nilai form yang akan disimpan
  String? _selectedCategory;
  String? _selectedCondition;
  String? _title;
  double? _price;
  String? _description;

  // Fungsi yang akan dipanggil saat tombol "List Item" ditekan
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Di sini kita akan simulasi menyimpan data.
      // Nantinya, di sinilah logika Firebase akan ditempatkan.
      
      // Tampilkan notifikasi berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil mengupload item: $_title (Kategori: $_selectedCategory)'),
          backgroundColor: Colors.black,
        ),
      );
      
      // Tutup halaman setelah sukses
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Listing', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 1. Photo Upload Area
              const Text('Add Photos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400)
                ),
                child: const Center(
                  child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 30),

              // 2. Title Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Product Title (Max 50 chars)',
                  border: OutlineInputBorder(),
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title produk wajib diisi.';
                  }
                  return null;
                },
                onSaved: (value) => _title = value,
              ),
              const SizedBox(height: 20),

              // 3. Category Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                initialValue: _selectedCategory,
                hint: const Text('Select a category'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Kategori wajib dipilih.';
                  }
                  return null;
                },
                onSaved: (value) => _selectedCategory = value,
              ),
              const SizedBox(height: 20),

              // 4. Condition Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Condition',
                  border: OutlineInputBorder(),
                ),
                initialValue: _selectedCondition,
                hint: const Text('Select item condition'),
                items: _conditions.map((String condition) {
                  return DropdownMenuItem<String>(
                    value: condition,
                    child: Text(condition),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCondition = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Kondisi wajib dipilih.';
                  }
                  return null;
                },
                onSaved: (value) => _selectedCondition = value,
              ),
              const SizedBox(height: 20),
              
              // 5. Price Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price (\$)',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Harga tidak valid.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Harga harus lebih dari nol.';
                  }
                  return null;
                },
                onSaved: (value) => _price = double.tryParse(value ?? '0'),
              ),
              const SizedBox(height: 20),
              
              // 6. Description Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  hintText: 'Describe your item, condition, and any flaws.',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.length < 20) {
                    return 'Deskripsi minimal 20 karakter.';
                  }
                  return null;
                },
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 30),

              // 7. Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'List Item Now',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}