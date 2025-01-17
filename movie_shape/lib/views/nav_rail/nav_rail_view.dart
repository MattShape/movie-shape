import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/views/nav_rail/nav_rail_widget.dart';
import 'package:movie_shape/views/nav_rail/state/nav_rail_bloc.dart';
import 'package:movie_shape/views/pages/film_detail_page.dart';

class NavRailView extends StatelessWidget {
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
            Expanded(
                // TODO: Call detail page
                child: FilmDetailPage(
              film: Film(
                  title: "Phils Film",
                  year: "2025",
                  rated: "5/5",
                  released: "January",
                  runtime: "120 minutes",
                  genre: "Comedy",
                  director: "Phil",
                  writer: ["Phil", "Josh"],
                  actors: ["Jack"],
                  plot: "plot",
                  language: [],
                  country: "country",
                  awards: [],
                  poster: null,
                  ratings: [],
                  metascore: "metascore",
                  imdbRating: "imdbRating",
                  imdbVotes: "imdbVotes",
                  imdbId: "PHIL",
                  type: "type",
                  dvd: "dvd",
                  boxOffice: "boxOffice",
                  production: "production",
                  response: "response"),
            )),
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
