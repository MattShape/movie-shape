import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/views/pages/home_page.dart';
import 'package:movie_shape/views/favourites/favourites_page.dart';
import 'package:movie_shape/views/watchlist/watchlist_page.dart';

class NavRail extends StatefulWidget {
  const NavRail({super.key});

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  int selectedIndex = 0;

  getPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return HomePage();
      case 1:
        return FavouritesPage();
      case 2:
        return WatchlistPage();
      default:
        return const Text("Page not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            backgroundColor: AppConstants.secondaryColour,
            extended: true,
          ),
          Expanded(
            child: getPage(selectedIndex),
          )
        ],
      ),
    );
  }
}
