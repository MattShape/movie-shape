part of 'favourites_list_bloc.dart';

@immutable
sealed class FavouritesListEvent {}

class LoadFavouritesList extends FavouritesListEvent {
  LoadFavouritesList();
}

class SearchFavouritesList extends FavouritesListEvent {
  final String searchQuery;
  SearchFavouritesList(this.searchQuery);
}

class ClearFavouritesSearch extends FavouritesListEvent {
  ClearFavouritesSearch();
}
