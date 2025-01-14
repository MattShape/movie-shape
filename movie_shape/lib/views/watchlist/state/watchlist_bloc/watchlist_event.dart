part of 'watchlist_bloc.dart';

abstract class WatchlistEvent {
  const WatchlistEvent();
}

class LoadWatchlist extends WatchlistEvent {
  const LoadWatchlist();
}
