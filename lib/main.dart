import 'package:flutter/material.dart';
import 'package:grocery_list_app/pages/HomePage.dart';

void main() {
  runApp(const GroceryApp());
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      theme: ThemeData(
          primarySwatch: Colors.pink,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.pink.shade300,
            foregroundColor: Colors.black,
          )),
      darkTheme: ThemeData.light(),
    );
  }
}
