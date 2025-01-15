import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/models/film_summary.dart';

part 'favourites_list_event.dart';
part 'favourites_list_state.dart';

class FavouritesListBloc extends Bloc<FavouritesListEvent, FavouritesListState> {
  FavouritesListBloc() : super(FavouritesListInitial()) {
    on<FavouritesListEvent>(_onLoadFavouritesList);
  }

  void _onLoadFavouritesList(event, emit) async {
    try {
      emit(FavouritesListLoading());

      List<FilmSummary> favouritesList = 
          await FilmRepoImplemented().getFavouritedFilms() ?? [];
      
      emit(FavouritesListLoaded(favouritesList));
    } catch (e) {
      emit(FavouritesListError(e.toString()));
    }
  }
}
