import 'package:flutter/material.dart';

import 'contacts.dart';
import 'destinationSetup.dart';
import 'homeScreen.dart';

void main() {
  runApp(const SafeArriveApp());
}

class SafeArriveApp extends StatelessWidget {
  const SafeArriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home':     (context) => HomeScreen(),
        '/setup':    (context) => SetupJourneyPage(),
        '/contacts': (context) => ContactsPage(),
        // '/history':  (context) => HistoryPage(),
        // '/settings': (context) => SettingsPage(),
      },

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