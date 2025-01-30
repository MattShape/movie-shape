import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/server_film_repo.dart';
import 'package:movie_shape/reusable/watchlist_button/watchlist_button_bloc/watchlist_button_bloc.dart';

class WatchlistButton extends StatelessWidget {
  final FilmSummary film;
  const WatchlistButton({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WatchlistButtonBloc(filmId: film.imdbID, filmRepo: ServerFilmRepo())
            ..add(WatchlistButtonDisplayed()),
      child: BlocBuilder<WatchlistButtonBloc, WatchlistButtonState>(
        builder: (context, state) {
          if (state is WatchlistButtonLoading) {
            return const CircularProgressIndicator();
          }
          if (state is WatchlistButtonLoaded) {
            return IconButton(
                onPressed: () {
                  context
                      .read<WatchlistButtonBloc>()
                      .add(WatchlistButtonPressed(film));
                },
                color: AppConstants.secondaryColour,
                icon: Icon(state.isInWatchlist
                    ? Icons.bookmark
                    : Icons.bookmark_outline));
          }
          if (state is WatchlistButtonError) {
            return Text(state.error);
          }
          return Container();
        },
      ),
    );
  }
}
