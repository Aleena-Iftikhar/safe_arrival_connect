import 'package:flutter/material.dart';

import 'homeScreen.dart';

void main() {
  runApp(const SafeArriveApp());
}

class SafeArriveApp extends StatelessWidget {
  const SafeArriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeArrive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B6FD4)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
      ),
      home: const HomeScreen(),
    );
  }
}