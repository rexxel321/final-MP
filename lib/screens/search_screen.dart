import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Daftar kategori yang diminta
  final List<String> categories = ['Clothing', 'Shoes', 'Bags', 'Accessories', 'Other'];
  String? selectedCategory;
  String searchQuery = '';

  // Data Dummy Hasil Pencarian (Simulasi)
  final List<String> searchResults = [
    'Vintage Denim Jacket',
    'Nike Air Max 97',
    'Leather Backpack',
    'Diamond Necklace',
    'Old Book Collection',
    'Handmade Pottery',
  ];

  // Logika Filter Simulasi
  List<String> get filteredResults {
    if (searchQuery.isEmpty) return searchResults;
    
    return searchResults
        .where((item) => item.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Search', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, 
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 1. Search Input Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for items...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
            ),
          ),

          // 2. Kategori Chips (Horizontal)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ActionChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      backgroundColor: isSelected ? Colors.black : Colors.white,
                      side: BorderSide(color: isSelected ? Colors.black : Colors.grey.shade300),
                      onPressed: () {
                        setState(() {
                          selectedCategory = isSelected ? null : category;
                          // TODO: Implementasi logika filter pencarian berdasarkan kategori
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 3. Hasil Pencarian (List View)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Results (${filteredResults.length})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: filteredResults.length,
              itemBuilder: (context, index) {
                final itemTitle = filteredResults[index];
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[200], // Placeholder gambar
                  ),
                  title: Text(itemTitle),
                  subtitle: Text(selectedCategory ?? 'Various'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Navigasi ke Product Detail Screen untuk item ini
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Bottom Nav Bar dikelola oleh MainTabScreen
    );
  }
}