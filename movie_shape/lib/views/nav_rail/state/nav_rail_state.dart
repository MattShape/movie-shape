part of 'nav_rail_bloc.dart';

@immutable
sealed class NavRailState {}

// we only need one state for NavRail - which destination is selected
// We can give it an initial value of 0 for the landing page - i.e. HomePage()

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
