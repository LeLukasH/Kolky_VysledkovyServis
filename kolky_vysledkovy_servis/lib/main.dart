import 'package:flutter/material.dart';
import 'colors.dart';
import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Výsledkový servis',
      theme: ThemeData(
        primarySwatch: primaryColorSwatch,
      ),
      home: const HomePage(),

    );
  }
}
