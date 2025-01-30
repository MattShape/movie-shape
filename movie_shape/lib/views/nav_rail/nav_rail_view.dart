import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/views/nav_rail/nav_rail_widget.dart';
import 'package:movie_shape/views/nav_rail/state/nav_rail_bloc.dart';
import 'package:movie_shape/views/film_detail_page/film_detail_page.dart';

class NavRailView extends StatelessWidget {
  const NavRailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavRailBloc, NavRailState>(builder: (context, state) {
      if (state is DisplaySelectedPage) {
        return Scaffold(
            body: Row(
          children: [
            NavRailWidget(
              selectedIndex: state.selectedIndex,
            ),
            Expanded(child: state.currentPage),
          ],
        ));
      }

      if (state is DisplayFilmDetailPage) {
        return Scaffold(
            body: Row(
          children: [
            NavRailWidget(
              selectedIndex: 3,
            ),
            //Expanded(child: FilmDetailPage(filmId: state.id)),
          ],
        ));
      }

      if (state is NavRailError) {
        return Text(state.errorMessage);
      }

      return Container();
    });
  }
}
