part of 'nav_rail_bloc.dart';

@immutable
sealed class NavRailState {}

final class DisplaySelectedPage extends NavRailState {
  final int selectedIndex;
  final Widget currentPage;

  DisplaySelectedPage(this.selectedIndex, this.currentPage);
}

final class DisplayFilmDetailPage extends NavRailState {
  final String id;

  DisplayFilmDetailPage(this.id);
}

final class NavRailError extends NavRailState {
  final String errorMessage;

  NavRailError(this.errorMessage);
}
