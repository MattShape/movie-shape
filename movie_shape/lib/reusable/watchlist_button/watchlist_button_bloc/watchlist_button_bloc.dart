import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';

part 'watchlist_button_event.dart';
part 'watchlist_button_state.dart';

class WatchlistButtonBloc
    extends Bloc<WatchlistButtonEvent, WatchlistButtonState> {
  FilmRepo filmRepo;
  final String filmId;
  WatchlistButtonBloc({required this.filmId, required this.filmRepo})
      : super(WatchlistButtonInitial()) {
    on<WatchlistButtonDisplayed>((event, emit) async {
      emit(WatchlistButtonLoading());
      try {
        List<FilmSummary>? favourites = await filmRepo.getWatchlistFilms();
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
        List<FilmSummary>? watchlist = await filmRepo.getWatchlistFilms();
        if (watchlist != null) {
          isInWatchlist =
              watchlist.any((film) => film.imdbID == event.film.imdbID);
        }
        if (isInWatchlist) {
          await filmRepo.removeFilmFromWatchlist(film: event.film);

          emit(WatchlistButtonLoaded(false));
        } else {
          await filmRepo.addFilmToWatchlist(film: event.film);

          emit(WatchlistButtonLoaded(true));
        }
      } catch (e) {
        emit(WatchlistButtonError(e.toString()));
      }
    });
  }
}
