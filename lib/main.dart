import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/theme_constants.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: notesTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
