import 'package:flutter/material.dart';

// 1. Pehla hissa: Widget Definition
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

// 2. Doosra hissa: Actual Logic aur UI
class _CartScreenState extends State<CartScreen> {
  // --- Asli Data List ---
  List<Map<String, dynamic>> cartItems = [
    {"name": "Red Apple", "price": 200, "img": "🍎", "qty": 1},
    {"name": "Fresh Milk", "price": 180, "img": "🥛", "qty": 1},
    {"name": "Brown Bread", "price": 90, "img": "🍞", "qty": 1},
  ];

  // --- Delete Function ---
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // --- Edit (Plus/Minus) Function ---
  void updateQty(int index, bool isAdd) {
    setState(() {
      if (isAdd) {
        cartItems[index]['qty']++;
      } else {
        if (cartItems[index]['qty'] > 1) {
          cartItems[index]['qty']--;
        }
      }
    });
  }

  // --- Total Price Calculation ---
  double getTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += (item['price'] * item['qty']);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double finalTotal = getTotal();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Cart", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: cartItems.isEmpty
          ? _emptyCart()
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) => _cartCard(index),
            ),
          ),
          _checkoutSection(finalTotal),
        ],
      ),
    );
  }

  Widget _emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text("Your cart is empty!", style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _cartCard(int index) {
    var item = cartItems[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Text(item['img'], style: const TextStyle(fontSize: 40)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Rs. ${item['price']}", style: const TextStyle(color: Colors.green)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _qtyBtn(Icons.remove, () => updateQty(index, false)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text("${item['qty']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    _qtyBtn(Icons.add, () => updateQty(index, true)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
            onPressed: () => removeItem(index),
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback action) {
    return InkWell(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 18, color: Colors.green),
      ),
    );
  }

  Widget _checkoutSection(double total) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Payable", style: TextStyle(fontSize: 18)),
              Text("Rs. ${total.toStringAsFixed(0)}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderSuccessScreen())),
            child: const Text("PLACE ORDER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// --- Order Success Screen Class ---
class OrderSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Icon(Icons.check_circle, size: 120, color: Colors.green)),
          const SizedBox(height: 20),
          const Text("Order Successful!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text("BACK TO HOME"),
          )
        ],
      ),
    );
  }
}