import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/views/favourites/favourites_page.dart';
import "package:movie_shape/views/homepage/home_page.dart";
import 'package:movie_shape/views/watchlist/watchlist_page.dart';
import "package:movie_shape/views/nav_rail/nav_rail_bloc/nav_rail_bloc.dart";

class NavRail extends StatelessWidget {
  NavRail({super.key});

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
    return BlocProvider(
      create: (context) => NavRailBloc(),
      child: Scaffold(
        body: BlocBuilder<NavRailBloc, NavRailState>(
          builder: (context, state) {
            if (state is NavDestinationError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Row(
                children: [
                  NavigationRail(
                    destinations: const [
                      NavigationRailDestination(
                          icon: Icon(Icons.theaters),
                          label: Text("Movies"),
                          selectedIcon: Icon(Icons.star)),
                      NavigationRailDestination(
                        icon: Icon(Icons.bookmark_outlined),
                        label: Text("Favourites"),
                        selectedIcon: Icon(Icons.star),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.remove_red_eye),
                        label: Text("Watch List"),
                        selectedIcon: Icon(Icons.star),
                      )
                    ],
                    selectedIndex: (state as DisplaySelectedPage).pageIndex,
                    onDestinationSelected: (index) {
                      //
                      context
                          .read<NavRailBloc>()
                          .add(SelectNavRailDestination(index));
                    },
                    backgroundColor: AppConstants.secondaryColour,
                    extended: true,
                  ),
                  Expanded(
                    child: getPage((state).pageIndex),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
