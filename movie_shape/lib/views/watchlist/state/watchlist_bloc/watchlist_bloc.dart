import 'package:bloc/bloc.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
    on<LoadWatchlist>((event, emit) async {
      try {
        emit(WatchlistLoading());
        await Future.delayed(Duration(seconds: 2));
        List<FilmSummary> watchlist =
            await FilmRepoImplemented().getWatchlistFilms() ?? [];
        emit(WatchlistLoaded(watchlist));
      } catch (e) {
        emit(WatchlistError(e.toString()));
      }
    });
    on<SearchWatchlist>((event, emit) async {
      try {
        String searchQuery = event.searchQuery;

        emit(WatchlistLoading());
        await Future.delayed(Duration(seconds: 2));
        List<FilmSummary> watchlist =
            await FilmRepoImplemented().getWatchlistFilms() ?? [];

        // filter list and emit new filtered version of list
        List<FilmSummary> filteredFilms = watchlist
            .where((film) =>
                film.title.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
        if (searchQuery.isNotEmpty) {
          emit(WatchlistLoaded(filteredFilms));
        } else {
          emit(WatchlistLoaded(watchlist));
        }
      } catch (e) {
        emit(WatchlistError(e.toString()));
      }
    });
    on<ClearWatchSearch>((event, emit) async {
      try {
        emit(WatchlistLoading());
        List<FilmSummary> watchlist =
            await FilmRepoImplemented().getWatchlistFilms() ?? [];
        emit(WatchlistLoaded(watchlist));
      } catch (e) {
        emit(WatchlistError(e.toString()));
      }
    });
  }
}
