import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/views/nav_rail/state/nav_rail_bloc.dart';

class NavRailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavRailBloc, NavRailState>(builder: (context, state) {
      if (state is NavRailError) {
        return Text(state.errorMessage);
      } else {
        return Scaffold(
            body: Row(
          children: [
            NavRailWidget(
              selectedIndex: (state as DisplaySelectedPage).selectedIndex,
            ),
            Expanded(child: state.currentPage),
          ],
        ));
      }
    });
  }
}

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
            icon: Icon(
              Icons.bookmark_border_rounded,
              size: 36,
            ),
            selectedIcon: Icon(
              Icons.bookmark_rounded,
              size: 36,
            ),
            label: Text("Watch List",
                style: TextStyle(fontSize: AppConstants.bodySize)))
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
