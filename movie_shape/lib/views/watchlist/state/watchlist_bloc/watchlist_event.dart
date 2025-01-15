part of 'watchlist_bloc.dart';

abstract class WatchlistEvent {
  const WatchlistEvent();
}

class LoadWatchlist extends WatchlistEvent {
  const LoadWatchlist();
}

class SearchWatchlist extends WatchlistEvent {
  final String searchQuery;
  const SearchWatchlist(this.searchQuery);
}
