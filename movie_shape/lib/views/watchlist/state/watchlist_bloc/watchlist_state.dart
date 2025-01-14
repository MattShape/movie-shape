part of 'watchlist_bloc.dart';

abstract class WatchlistState {
  const WatchlistState();
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<FilmSummary> watchlist;
  const WatchlistLoaded(this.watchlist);
}

class WatchlistError extends WatchlistState {
  final String message;
  const WatchlistError(this.message);
}
