part of 'favourite_button_bloc.dart';

@immutable
sealed class FavouriteButtonEvent {}

class FavouriteButtonDisplayed extends FavouriteButtonEvent {}

class FavouriteButtonPressed extends FavouriteButtonEvent {
  final FilmSummary film;

  FavouriteButtonPressed(this.film);
}
