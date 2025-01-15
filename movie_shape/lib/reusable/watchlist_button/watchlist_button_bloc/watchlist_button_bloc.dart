import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';

part 'watchlist_button_event.dart';
part 'watchlist_button_state.dart';

class WatchlistButtonBloc
    extends Bloc<WatchlistButtonEvent, WatchlistButtonState> {
  final String filmId;
  WatchlistButtonBloc({required this.filmId})
      : super(WatchlistButtonInitial()) {
    on<WatchlistButtonDisplayed>((event, emit) async {
      emit(WatchlistButtonLoading());
      try {
        List<FilmSummary>? favourites =
            await FilmRepoImplemented().getWatchlistFilms();
        if (favourites != null) {
          emit(WatchlistButtonLoaded(
              favourites.any((film) => film.imdbID == filmId)));
        } else {
          emit(WatchlistButtonLoaded(false));
        }
      } catch (e) {
        emit(WatchlistButtonError(e.toString()));
      }
    });

    on<WatchlistButtonPressed>((event, emit) async {
      emit(WatchlistButtonLoading());
      try {
        bool isInWatchlist = false;
        List<FilmSummary>? watchlist =
            await FilmRepoImplemented().getWatchlistFilms();
        if (watchlist != null) {
          isInWatchlist =
              watchlist.any((film) => film.imdbID == event.film.imdbID);
        }
        if (isInWatchlist) {
          await FilmRepoImplemented().removeFilmFromWatchlist(film: event.film);

          emit(WatchlistButtonLoaded(false));
        } else {
          await FilmRepoImplemented().addFilmToWatchlist(film: event.film);

          emit(WatchlistButtonLoaded(true));
        }
      } catch (e) {
        emit(WatchlistButtonError(e.toString()));
      }
    });
  }
}
