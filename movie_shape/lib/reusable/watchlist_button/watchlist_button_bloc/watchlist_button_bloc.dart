import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/repository/user_repo_implemented.dart';

part 'watchlist_button_event.dart';
part 'watchlist_button_state.dart';

class WatchlistButtonBloc
    extends Bloc<WatchlistButtonEvent, WatchlistButtonState> {
  final int filmId;
  WatchlistButtonBloc({required this.filmId})
      : super(WatchlistButtonInitial()) {
    on<WatchlistButtonDisplayed>((event, emit) async {
      emit(WatchlistButtonLoading());
      try {
        List<FilmSummary>? watchlist =
            await UserRepoImplemented().getWatchlistFilms();
        if (watchlist != null) {
          emit(WatchlistButtonLoaded(
              watchlist.any((film) => film.id == filmId)));
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
            await UserRepoImplemented().getWatchlistFilms();
        if (watchlist != null) {
          isInWatchlist = watchlist.any((film) => film.id == event.film.id);
        }
        if (isInWatchlist) {
          await UserRepoImplemented()
              .removeFilmFromWatchlist(movieId: event.film.id);

          emit(WatchlistButtonLoaded(false));
        } else {
          await UserRepoImplemented().getWatchlistFilms();

          emit(WatchlistButtonLoaded(true));
        }
      } catch (e) {
        emit(WatchlistButtonError(e.toString()));
      }
    });
  }
}
