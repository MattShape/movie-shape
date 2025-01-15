part of 'favourites_list_bloc.dart';

@immutable
sealed class FavouritesListState {}

class FavouritesListInitial extends FavouritesListState {}

class FavouritesListLoading extends FavouritesListState {}

class FavouritesListLoaded extends FavouritesListState {
  final List<FilmSummary> favouritesList;
  
  FavouritesListLoaded(this.favouritesList);
}

class FavouritesListError extends FavouritesListState {
  final String errorMessage;

  FavouritesListError(this.errorMessage);
}