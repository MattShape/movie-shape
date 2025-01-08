import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.theaters),
                  label: Text("Movies"),
                ),
                NavigationRailDestination(
                    icon: Icon(Icons.bookmark_outlined),
                    label: Text("Favourites")),
                NavigationRailDestination(
                  icon: Icon(Icons.remove_red_eye),
                  label: Text("Watch List"),
                )
              ],
              selectedIndex: selectedIndex,
              backgroundColor: AppConstants.secondaryColour,
              extended: true,
            ),
            Expanded(
              child: AppBar(
                title: Text("MovieShape"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
