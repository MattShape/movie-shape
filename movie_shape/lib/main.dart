import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/views/widgets/nav_rail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: AppConstants.primaryColour),
      home: NavRail()
    );
    return materialApp;
  }
}