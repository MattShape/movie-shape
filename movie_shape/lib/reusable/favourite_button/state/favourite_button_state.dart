part of 'favourite_button_bloc.dart';

@immutable
sealed class FavouriteButtonState {}

final class FavouriteButtonInitial extends FavouriteButtonState {}

final class FavouriteButtonLoaded extends FavouriteButtonState {
  // conditional for what icon should be displayed
  final bool isInFavouritesList;

  FavouriteButtonLoaded(this.isInFavouritesList);
}

final class FavouriteButtonLoading extends FavouriteButtonState {}

final class FavouriteButtonError extends FavouriteButtonState {
  final String error;

  FavouriteButtonError(this.error);
}