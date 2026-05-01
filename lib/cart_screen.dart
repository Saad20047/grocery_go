import 'package:flutter/material.dart';
import 'main.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(0, (sum, item) => sum + (item['price'] * item['qty']));

    return Scaffold(
      appBar: AppBar(
        title: const Text("MY CART"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty!", style: TextStyle(fontSize: 18)))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                var item = cartItems[index];
                return ListTile(
                  leading: Text(item['img'], style: const TextStyle(fontSize: 30)),
                  title: Text(item['name']),
                  subtitle: Text("Rs. ${item['price']} x ${item['qty']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            if (item['qty'] > 1) {
                              item['qty']--;
                            } else {
                              cartItems.removeAt(index);
                            }
                          });
                        },
                      ),
                      Text("${item['qty']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                        onPressed: () {
                          setState(() {
                            item['qty']++;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Rs. $total", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    setState(() {
                      cartItems.clear(); // Cart khali kar di
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
                  },
                  child: const Text("PLACE ORDER", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OrderSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text("ORDER PLACED!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("Thank you for shopping with Grocery Go."),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text("Back to Home"),
            )
          ],
        ),
      ),
    );
  }
}
