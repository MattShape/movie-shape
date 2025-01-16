import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/reusable/favourite_button/state/favourite_button_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';

class FavouriteButton extends StatelessWidget {
  final FilmSummary film;

  const FavouriteButton({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteButtonBloc(
        filmId: film.imdbID,
      )..add(FavouriteButtonDisplayed()),
      child: BlocBuilder<FavouriteButtonBloc, FavouriteButtonState>(
        builder: (context, state) {
          if (state is FavouriteButtonLoading) {
            return const CircularProgressIndicator();
          }

          if (state is FavouriteButtonLoaded) {
            return IconButton(
                onPressed: () {
                  context
                      .read<FavouriteButtonBloc>()
                      .add(FavouriteButtonPressed(film));
                },
                color: AppConstants.accentColour,
                icon: Icon(state.isInFavouritesList
                    ? Icons.favorite
                    : Icons.favorite_outline));
          }

          if (state is FavouriteButtonError) {
            return Text(state.error);
          }

          return Text("Unhandled state");
        },
      ),
    );
  }
}
