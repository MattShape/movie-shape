import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/views/pages/film_detail_page.dart';
import 'package:movie_shape/views/watchlist/state/watchlist_bloc/watchlist_bloc.dart';

class ListCard extends StatelessWidget {
  final FilmSummary film;
  final Function(String) onTap;

  const ListCard({super.key, required this.film, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppConstants.secondaryFgColour,
      shadowColor: AppConstants.accentColour,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      elevation: 4,
      child: ListTile(
        title: Text(
          film.title,
          style: TextStyle(color: AppConstants.textColour),
        ),
        subtitle: Text(
          film.year,
          style: TextStyle(color: AppConstants.textColour),
        ),
        leading: Image.network(
          film.poster,
        ),
        onTap: () {
          onTap(film.imdbID);
        },
      ),
    );
  }
}
