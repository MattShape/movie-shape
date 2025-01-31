part of 'add_film_button_bloc.dart';

@immutable
sealed class AddFilmButtonEvent {}

class AddFilmButtonDisplayed extends AddFilmButtonEvent {
  final FilmSummary film;
  AddFilmButtonDisplayed(this.film);
}

class AddFilmButtonPressed extends AddFilmButtonEvent {
  final FilmSummary film;

  AddFilmButtonPressed(this.film);
}
