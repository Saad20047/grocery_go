import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const GroceryGoApp());
}

class GroceryGoApp extends StatelessWidget {
  const GroceryGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Go',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}