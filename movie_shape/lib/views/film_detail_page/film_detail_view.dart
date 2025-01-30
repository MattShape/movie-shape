import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/models/rating.dart';
import 'package:movie_shape/reusable/favourite_button/favourite_button.dart';
import 'package:movie_shape/reusable/watchlist_button/watchlist_button.dart';
import 'package:movie_shape/views/film_detail_page/state/bloc/film_detail_page_bloc.dart';

class FilmDetailView extends StatelessWidget {
  const FilmDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmDetailPageBloc, FilmDetailPageState>(
      builder: (context, state) {
        if (state is FilmDetailPageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is FilmDetailPageLoaded) {
          final Film film = state.film;

          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  FilmHeading(film: film),
                  SizedBox(
                    height: 35,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 924,
                      height: 653,
                      color: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Poster(film: film)),
                            Expanded(
                              flex: 2,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 32),
                                  child: Container(
                                    width: 420,
                                    child: Column(
                                      children: [
                                        YearFavouriteWatchlistRow(
                                          context,
                                          film: film,
                                          longDescription:
                                              state.longDescription,
                                        ),
                                        SizedBox(height: 11),
                                        DirectorRow(context, film: film),
                                        SizedBox(height: 20),
                                        RuntimeRow(context, film: film),
                                        SizedBox(height: 20),
                                        RatingColumn(film: film),
                                        SizedBox(height: 12),
                                        PlotBox(film: film),
                                        SizedBox(height: 32),
                                        ActorsWritersRow(context, film: film),
                                        SizedBox(height: 56),
                                        LanguagesRow(context, film: film),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is FilmDetailPageError) {
          return Center(
            child: Text(state.message),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}

// Poster Widget
class Poster extends StatelessWidget {
  final Film film;
  const Poster({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        film.poster ?? "",
        fit: BoxFit.cover,
      ),
    );
  }
}

// LanguagesRow Widget
class LanguagesRow extends StatelessWidget {
  final Film film;
  const LanguagesRow(BuildContext context, {required this.film});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text('Languages: ',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 14,
            )),
        Text(
          film.language.join(', '),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// ActorsWritersRow Widget
class ActorsWritersRow extends StatelessWidget {
  final Film film;
  const ActorsWritersRow(BuildContext context, {required this.film});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Actors column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actors',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: AppConstants.bodySize,
              ),
            ),
            ...film.actors.map((item) => Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    item.trim(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: AppConstants.bodySize,
                    ),
                  ),
                ))
          ],
        ),
        SizedBox(width: 36),
        // Writers column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Writers',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: AppConstants.bodySize,
              ),
            ),
            ...film.writer.map((item) => Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    item.trim(),
                    style: TextStyle(
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
}

// RuntimeRow Widget
class RuntimeRow extends StatelessWidget {
  final Film film;
  const RuntimeRow(BuildContext context, {required this.film});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Run Time: ${film.runtime}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: AppConstants.bodySize,
          ),
        ),
      ],
    );
  }
}

// DirectorRow Widget
class DirectorRow extends StatelessWidget {
  final Film film;
  const DirectorRow(BuildContext context, {required this.film});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Director: ${film.director}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: AppConstants.bodySize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// YearFavouriteWatchlistRow Widget
class YearFavouriteWatchlistRow extends StatelessWidget {
  final Film film;
  final bool longDescription;
  const YearFavouriteWatchlistRow(BuildContext context,
      {required this.film, required this.longDescription});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Release date: ${film.year}',
          style: TextStyle(
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
            poster: film.poster ?? "",
          ),
        ),
        SizedBox(width: 20),
        WatchlistButton(
          film: FilmSummary(
            title: film.title,
            year: film.year,
            imdbID: film.imdbId,
            type: film.type,
            poster: film.poster ?? "",
          ),
        ),
        IconButton(
          onPressed: () {
            context
                .read<FilmDetailPageBloc>()
                .add(ShowLongDescription(film.imdbId, longDescription));
          },
          icon: Icon(Icons.unfold_more),
        ),
      ],
    );
  }
}

// RatingColumn Widget
class RatingColumn extends StatelessWidget {
  final Film film;
  const RatingColumn({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(
                      color: AppConstants.textColour,
                      fontSize: AppConstants.bodySize,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    rating.value,
                    style: TextStyle(
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
}

// PlotBox Widget
class PlotBox extends StatelessWidget {
  final Film film;
  const PlotBox({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          'Description: ${film.plot}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: AppConstants.bodySize,
          ),
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}

// FilmHeading Widget
class FilmHeading extends StatelessWidget {
  final Film film;
  const FilmHeading({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 911,
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: Text(film.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: AppConstants.filmTitleSize,
              )),
        ),
      ),
    );
  }
}
