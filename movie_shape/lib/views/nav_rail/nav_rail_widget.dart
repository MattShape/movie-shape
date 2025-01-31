import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/views/nav_rail/state/nav_rail_bloc.dart';

class NavRailWidget extends StatelessWidget {
  const NavRailWidget({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIconTheme: IconThemeData(color: AppConstants.secondaryColour),
      unselectedIconTheme: IconThemeData(color: AppConstants.secondaryColour),
      useIndicator: false,
      // logo
      leading: Padding(
        padding: const EdgeInsets.all(28),
        child: SizedBox(
          width: 220,
          child: const Image(
            image: AssetImage('assets/shape_logo.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),

      destinations: const [
        NavigationRailDestination(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 36),
            child: Icon(
              Icons.theaters_outlined,
              size: 36,
            ),
          ),
          selectedIcon: Padding(
            padding: EdgeInsets.only(bottom: 36),
            child: Icon(
              Icons.theaters_rounded,
              size: 36,
            ),
          ),
          label: Padding(
            padding: EdgeInsets.only(bottom: 36),
            child:
                Text("Home", style: TextStyle(fontSize: AppConstants.bodySize)),
          ),
        ),
        NavigationRailDestination(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 36),
            child: Icon(
              Icons.favorite_outline_rounded,
              size: 36,
            ),
          ),
          selectedIcon: Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Icon(
                Icons.favorite_rounded,
                size: 36,
              )),
          label: Padding(
            padding: EdgeInsets.only(bottom: 36),
            child: Text("Favourites",
                style: TextStyle(fontSize: AppConstants.bodySize)),
          ),
        ),
        NavigationRailDestination(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Icon(
                Icons.bookmark_border_rounded,
                size: 36,
              ),
            ),
            selectedIcon: Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Icon(
                Icons.bookmark_rounded,
                size: 36,
              ),
            ),
            label: Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Text("Watch List",
                  style: TextStyle(fontSize: AppConstants.bodySize)),
            )),
        NavigationRailDestination(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Icon(
                Icons.add_to_photos_outlined,
                size: 36,
              ),
            ),
            selectedIcon: Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Icon(
                Icons.add_to_photos_rounded,
                size: 36,
              ),
            ),
            label: Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Text("Add film",
                  style: TextStyle(
                    fontSize: AppConstants.bodySize,
                  )),
            )),
        NavigationRailDestination(
            disabled: true,
            icon: Icon(
              Icons.movie_creation_outlined,
              size: 36,
              color: AppConstants.primaryColour,
            ),
            selectedIcon: Icon(
              Icons.movie,
              size: 36,
              color: AppConstants.primaryColour,
            ),
            label: Text("Film",
                style: TextStyle(
                  fontSize: AppConstants.bodySize,
                  color: AppConstants.primaryColour,
                )))
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        context.read<NavRailBloc>().add(DestinationSelected(index));
      },
      backgroundColor: AppConstants.primaryColour,
      extended: true,
    );
  }
}
