import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;

import 'package:myapp/ui/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return material.MaterialApp(
      theme: material.ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}
