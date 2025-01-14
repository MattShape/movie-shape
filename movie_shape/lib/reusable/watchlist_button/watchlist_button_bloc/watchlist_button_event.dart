part of 'watchlist_button_bloc.dart';

@immutable
sealed class WatchlistButtonEvent {}

class WatchlistButtonDisplayed extends WatchlistButtonEvent {}

class WatchlistButtonPressed extends WatchlistButtonEvent {
  final FilmSummary film;

  WatchlistButtonPressed(this.film);
}
