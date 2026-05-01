import 'package:flutter/material.dart';
import 'login_screen.dart';

// Global Cart List jo poori app mein share hogi
List<Map<String, dynamic>> cartItems = [];

void main() {
  runApp(const GroceryGo());
}

class GroceryGo extends StatelessWidget {
  const GroceryGo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Go',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}