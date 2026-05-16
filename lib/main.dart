import 'package:flutter/material.dart';
import 'screens/touchpad_screen.dart';

void main() {
  runApp(const GestureMouseApp());
}

class GestureMouseApp extends StatelessWidget {
  const GestureMouseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Mouse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const TouchpadScreen(),
    );
  }
}