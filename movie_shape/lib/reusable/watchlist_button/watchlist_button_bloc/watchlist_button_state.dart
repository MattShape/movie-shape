part of 'watchlist_button_bloc.dart';

@immutable
sealed class WatchlistButtonState {}

final class WatchlistButtonInitial extends WatchlistButtonState {}

final class WatchlistButtonLoaded extends WatchlistButtonState {
  final bool isInWatchlist;

  WatchlistButtonLoaded(this.isInWatchlist);
}

final class WatchlistButtonLoading extends WatchlistButtonState {}

final class WatchlistButtonError extends WatchlistButtonState {
  final String error;

  WatchlistButtonError(this.error);
}
