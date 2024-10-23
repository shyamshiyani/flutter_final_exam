import 'package:flutter/material.dart';
import 'package:flutter_final_exam/views/screens/history_screen.dart';
import 'package:flutter_final_exam/views/screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomeScreen(),
        'History_screen': (context) => const HistoryScreen(),
      },
    ),
  );
}
