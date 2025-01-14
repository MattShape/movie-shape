import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/views/widgets/nav_rail.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppConstants.primaryColour),
        home: NavRail());
    setupEmptyList();
    return materialApp;
  }
}

Future<void> setupEmptyList() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList("favourites", []);
  print("empty list set up");
}
