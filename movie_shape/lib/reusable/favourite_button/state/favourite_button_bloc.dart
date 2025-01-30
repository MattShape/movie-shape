import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/repository/server_film_repo.dart';

part 'favourite_button_event.dart';
part 'favourite_button_state.dart';

class FavouriteButtonBloc
    extends Bloc<FavouriteButtonEvent, FavouriteButtonState> {
  FavouriteButtonBloc({required this.filmId})
      : super(FavouriteButtonInitial()) {
    on<FavouriteButtonDisplayed>(_onFavouriteButtonDisplayed);
    on<FavouriteButtonPressed>(_onFavouriteButtonPressed);
  }

  final String filmId;

  // handle logic when favourite button has displayed
  void _onFavouriteButtonDisplayed(event, emit) async {
    emit(FavouriteButtonLoading());

    try {
      List<FilmSummary>? favourites =
          await ServerFilmRepo().getFavouritedFilms();
      if (favourites != null) {
        // update state that film is loaded (true)
        emit(FavouriteButtonLoaded(
            // checks if one element matches the condition
            favourites.any((film) => film.imdbID == filmId)));
      } else {
        emit(FavouriteButtonLoaded(false));
      }
    } catch (e) {
      emit(FavouriteButtonError(e.toString()));
    }
  }

  void _onFavouriteButtonPressed(event, emit) async {
    emit(FavouriteButtonLoading());

    try {
      bool isInFavouritesList = false;

      List<FilmSummary>? favouritesList =
          await ServerFilmRepo().getFavouritedFilms();

      if (favouritesList != null) {
        isInFavouritesList =
            favouritesList.any((film) => film.imdbID == event.film.imdbID);
        print("isInFavouritesList: ${isInFavouritesList}");
      }

      if (isInFavouritesList) {
        await ServerFilmRepo().removeFilmFromFavourites(film: event.film);
        emit(FavouriteButtonLoaded(false));
      } else {
        await ServerFilmRepo().addFilmToFavourites(film: event.film);

        emit(FavouriteButtonLoaded(true));
      }
    } catch (e) {
      emit(FavouriteButtonError(e.toString()));
    }
  }
}
