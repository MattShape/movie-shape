import 'package:bloc/bloc.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  FilmRepo filmRepo;
  WatchlistBloc({required this.filmRepo}) : super(WatchlistInitial()) {
    on<LoadWatchlist>((event, emit) async {
      try {
        emit(WatchlistLoading());
        List<FilmSummary> watchlist = await filmRepo.getWatchlistFilms() ?? [];
        emit(WatchlistLoaded(watchlist));
      } catch (e) {
        emit(WatchlistError(e.toString()));
      }
    });
    on<SearchWatchlist>((event, emit) async {
      try {
        String searchQuery = event.searchQuery;

        emit(WatchlistLoading());
        List<FilmSummary> watchlist = await filmRepo.getWatchlistFilms() ?? [];

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
        List<FilmSummary> watchlist = await filmRepo.getWatchlistFilms() ?? [];
        emit(WatchlistLoaded(watchlist));
      } catch (e) {
        emit(WatchlistError(e.toString()));
      }
    });
  }
}
