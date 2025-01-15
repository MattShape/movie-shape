import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/models/rating.dart';
import 'package:movie_shape/reusable/favourite_button/favourite_button.dart';
import 'package:movie_shape/reusable/watchlist_button/watchlist_button.dart';

class FilmDetailPage extends StatelessWidget {
  const FilmDetailPage({super.key, required this.film});

  final Film film;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // page
        body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 35,
          ),

          // film title card
          FilmHeading(film: film),

          SizedBox(
            height: 35,
          ),

          // detail container
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 924,
              height: 445,
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // poster
                    Expanded(flex: 1, child: Poster()),

                    // detail information
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Container(
                            width: 420,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Film detail information column
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    YearFavouriteWatchlistRow(context),
                                    SizedBox(height: 11),
                                    DirectorRow(context),
                                    SizedBox(height: 20),
                                    RuntimeRow(context),
                                  ],
                                ),

                                SizedBox(height: 20),

                                RatingColumn(),

                                SizedBox(height: 12),

                                PlotBox(film: film),

                                SizedBox(height: 32),

                                ActorsWritersRow(context),

                                SizedBox(height: 56),

                                LanguagesRow(context),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Column RatingColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: film.ratings
          .map(
            (rating) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Text(
                    rating.source,
                    style: AppConstants.fontFamily(
                      color: AppConstants.textColour,
                      fontSize: AppConstants.bodySize,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    rating.value,
                    style: AppConstants.fontFamily(
                      color: AppConstants.textColour,
                      fontSize: AppConstants.bodySize,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  ClipRRect Poster() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        film.poster,
        // width: 424,
        // height: 629,
        fit: BoxFit.cover,
      ),
    );
  }

  Wrap LanguagesRow(BuildContext context) {
    return Wrap(
      children: [
        Text('Languages: ',
            style: AppConstants.fontFamily(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 14,
            )),
        Text(
          film.language.join(', '),
          style: AppConstants.fontFamily(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Row ActorsWritersRow(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Actors column
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actors',
              style: AppConstants.fontFamily(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: AppConstants.bodySize,
              ),
            ),
            // Mapping the actors list into Text widgets using spread operator
            ...film.actors.map((item) => Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    item.trim(),
                    style: AppConstants.fontFamily(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: AppConstants.bodySize,
                    ),
                  ),
                ))
          ],
        ),

        Spacer(),

        // Writers column
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Writers',
              style: AppConstants.fontFamily(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: AppConstants.bodySize,
              ),
            ),
            ...film.writer.map((item) => Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    item.trim(),
                    style: AppConstants.fontFamily(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: AppConstants.bodySize,
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }

  Row RuntimeRow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Run Time: ${film.runtime}',
          style: AppConstants.fontFamily(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: AppConstants.bodySize,
          ),
        ),
      ],
    );
  }

  Wrap DirectorRow(BuildContext context) {
    return Wrap(
      children: [
        Text(
          'Director: ${film.director}',
          style: AppConstants.fontFamily(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: AppConstants.bodySize,
          ),
        ),
      ],
    );
  }

  Row YearFavouriteWatchlistRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Release date: ${film.year}',
          style: AppConstants.fontFamily(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: AppConstants.bodySize,
          ),
        ),
        Spacer(),
        FavouriteButton(
          film: FilmSummary(
            title: film.title,
            year: film.year,
            imdbID: film.imdbId,
            type: film.type,
            poster: film.poster,
          ),
        ),
        SizedBox(width: 20),
        WatchlistButton(
          film: FilmSummary(
            title: film.title,
            year: film.year,
            imdbID: film.imdbId,
            type: film.type,
            poster: film.poster,
          ),
        ),
      ],
    );
  }
}

class PlotBox extends StatelessWidget {
  const PlotBox({
    super.key,
    required this.film,
  });

  final Film film;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          'Description: ${film.plot}',
          style: AppConstants.fontFamily(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: AppConstants.bodySize,
          ),
          //softWrap: true,
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}

class FilmHeading extends StatelessWidget {
  const FilmHeading({
    super.key,
    required this.film,
  });

  final Film film;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 911,
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: Text(film.title,
              style: AppConstants.fontFamily(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: AppConstants.filmTitleSize,
              )),
        ),
      ),
    );
  }
}
