import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/views/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: AppConstants.primaryColour),
      home: const HomePage()
    );
  }
}
