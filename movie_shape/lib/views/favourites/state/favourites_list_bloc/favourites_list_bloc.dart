import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/repository/user_repo_implemented.dart';

part 'favourites_list_event.dart';
part 'favourites_list_state.dart';

class FavouritesListBloc
    extends Bloc<FavouritesListEvent, FavouritesListState> {
  FavouritesListBloc() : super(FavouritesListInitial()) {
    on<LoadFavouritesList>(_onLoadFavouritesList);
    on<SearchFavouritesList>(_onSearchFavouritesList);
    on<ClearFavouritesSearch>(_onClearFavouritesSearch);
  }

  void _onLoadFavouritesList(event, emit) async {
    try {
      emit(FavouritesListLoading());

      List<Film> favouritesList =
          await UserRepoImplemented().getFavouritedFilms();

      emit(FavouritesListLoaded(favouritesList));
    } catch (e) {
      emit(FavouritesListError(e.toString()));
    }
  }

  void _onSearchFavouritesList(event, emit) async {
    try {
      String searchQuery = event.searchQuery;

      emit(FavouritesListLoading());
      List<Film> favouritesList =
          await UserRepoImplemented().getFavouritedFilms();
      List<Film> filteredFilms = favouritesList
          .where((film) =>
              film.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      if (searchQuery.isNotEmpty) {
        emit(FavouritesListLoaded(filteredFilms));
      } else {
        emit(FavouritesListLoaded(favouritesList));
      }
    } catch (e) {
      emit(FavouritesListError(e.toString()));
    }
  }

  void _onClearFavouritesSearch(event, emit) async {
    try {
      emit(FavouritesListLoading());
      List<Film> favouritesList =
          await UserRepoImplemented().getFavouritedFilms();
      emit(FavouritesListLoaded(favouritesList));
    } catch (e) {
      emit(FavouritesListError(e.toString()));
    }
  }
}
