part of 'favourites_list_bloc.dart';

@immutable
sealed class FavouritesListEvent {}

class LoadFavouritesList extends FavouritesListEvent {
  LoadFavouritesList();
}