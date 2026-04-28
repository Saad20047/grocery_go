import 'package:flutter/material.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> allProducts = [
    {"name": "Red Apple", "price": 200, "img": "🍎", "cat": "Fruits", "desc": "Fresh organic red apples from northern areas."},
    {"name": "Fresh Milk", "price": 180, "img": "🥛", "cat": "Dairy", "desc": "Pure farm milk, pasteurized and healthy."},
    {"name": "Egg Tray", "price": 350, "img": "🥚", "cat": "Dairy", "desc": "Farm fresh brown eggs, pack of 12."},
    {"name": "Banana", "price": 120, "img": "🍌", "cat": "Fruits", "desc": "Sweet and ripe bananas full of energy."},
    {"name": "Carrot", "price": 80, "img": "🥕", "cat": "Veggies", "desc": "Crunchy orange carrots, rich in Vitamin A."},
    {"name": "Chicken", "price": 600, "img": "🍗", "cat": "Meat", "desc": "Freshly cut chicken, clean and hygienic."},
  ];

  List<Map<String, dynamic>> displayedProducts = [];
  String selectedCat = "All";

  @override
  void initState() {
    displayedProducts = allProducts;
    super.initState();
  }

  void filterItems(String query, String category) {
    setState(() {
      selectedCat = category;
      displayedProducts = allProducts.where((item) {
        final matchesQuery = item['name']!.toLowerCase().contains(query.toLowerCase());
        final matchesCat = category == "All" || item['cat'] == category;
        return matchesQuery && matchesCat;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery Go", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  onChanged: (val) => filterItems(val, selectedCat),
                  decoration: InputDecoration(
                    hintText: "Search groceries...",
                    prefixIcon: const Icon(Icons.search),
                    fillColor: Colors.white, filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: ["All", "Fruits", "Veggies", "Dairy", "Meat"].map((cat) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: selectedCat == cat,
                        onSelected: (bool selected) => filterItems("", cat),
                        selectedColor: Colors.orange,
                        labelStyle: TextStyle(color: selectedCat == cat ? Colors.white : Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: displayedProducts.length,
        itemBuilder: (context, index) {
          final prod = displayedProducts[index];
          return InkWell(
            // --- Yahan click karne se Detail Screen khulegi ---
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: prod)));
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(prod['img'], style: const TextStyle(fontSize: 40)),
                  Text(prod['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Rs. ${prod['price']}"),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: const StadiumBorder()),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())),
                    child: const Text("Add", style: TextStyle(color: Colors.white, fontSize: 11)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// --- PRODUCT DETAIL SCREEN (Ye Screen proposal ke liye zaroori hai) ---
class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name']), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(child: Text(product['img'], style: const TextStyle(fontSize: 120))),
            const SizedBox(height: 20),
            Text(product['name'], style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Text("Rs. ${product['price']}", style: const TextStyle(fontSize: 24, color: Colors.green)),
            const SizedBox(height: 20),
            Text(product['desc'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 55)),
              onPressed: () => Navigator.pop(context),
              child: const Text("BACK TO MARKET", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}