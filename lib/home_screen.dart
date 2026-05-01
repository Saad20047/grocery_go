import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Products Data
  final List<Map<String, dynamic>> allProducts = [
    {"name": "Red Apple", "price": 200, "img": "🍎", "cat": "Fruits"},
    {"name": "Fresh Milk", "price": 180, "img": "🥛", "cat": "Dairy"},
    {"name": "Egg Tray", "price": 350, "img": "🥚", "cat": "Dairy"},
    {"name": "Banana", "price": 120, "img": "🍌", "cat": "Fruits"},
    {"name": "Carrot", "price": 80, "img": "🥕", "cat": "Veggies"},
    {"name": "Chicken", "price": 600, "img": "🍗", "cat": "Meat"},
  ];

  String selectedCategory = "All"; // Default Category

  @override
  Widget build(BuildContext context) {
    // Category Filter Logic
    List filteredProducts = selectedCategory == "All"
        ? allProducts
        : allProducts.where((p) => p['cat'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("GROCERY GO", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())),
          ),
        ],
      ),
      body: Column(
        children: [
          // --- CATEGORY BUTTONS ---
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ["All", "Fruits", "Dairy", "Veggies", "Meat"].map((cat) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: selectedCategory == cat,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = cat;
                      });
                    },
                    selectedColor: Colors.green,
                    labelStyle: TextStyle(color: selectedCategory == cat ? Colors.white : Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),

          // --- PRODUCT GRID ---
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  elevation: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(product['img'], style: const TextStyle(fontSize: 40)),
                      const SizedBox(height: 10),
                      Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("Rs. ${product['price']}"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          setState(() {
                            // Smart Add Logic with Quantity
                            int existingIndex = cartItems.indexWhere((item) => item['name'] == product['name']);
                            if (existingIndex != -1) {
                              cartItems[existingIndex]['qty']++;
                            } else {
                              cartItems.add({...product, 'qty': 1});
                            }
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${product['name']} added!"), duration: const Duration(seconds: 1)),
                          );
                        },
                        child: const Text("Add to Cart", style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
