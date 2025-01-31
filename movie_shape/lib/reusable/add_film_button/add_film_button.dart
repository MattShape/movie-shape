import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/server_film_repo.dart';
import 'package:movie_shape/reusable/add_film_button/state/bloc/add_film_button_bloc.dart';

class AddFilmButton extends StatelessWidget {
  final FilmSummary film;

  const AddFilmButton({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFilmButtonBloc(filmRepo: ServerFilmRepo())
        ..add(AddFilmButtonDisplayed(film)),
      child: BlocBuilder<AddFilmButtonBloc, AddFilmButtonState>(
        builder: (context, state) {
          if (state is AddFilmButtonLoading) {
            return const CircularProgressIndicator();
          }

          if (state is AddFilmButtonLoaded) {
            return IconButton(
                onPressed: () {
                  context
                      .read<AddFilmButtonBloc>()
                      .add(AddFilmButtonPressed(film));
                },
                color: AppConstants.secondaryColour,
                icon: Icon(state.isInServer ? Icons.check : Icons.add));
          }

          if (state is AddFilmButtonError) {
            return Text(state.error);
          }

          return Text("Unhandled state");
        },
      ),
    );
  }
}
