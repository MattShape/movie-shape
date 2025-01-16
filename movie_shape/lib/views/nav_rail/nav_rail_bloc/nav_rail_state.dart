part of 'nav_rail_bloc.dart';

abstract class NavRailState {}

// class NavRailInitial extends NavRailState {}

// we only need one state for NavRail - which destination is selected
// We can give it an initial value of 0 for the landing page - i.e. HomePage()

class DisplaySelectedPage extends NavRailState {
  final int pageIndex;
  DisplaySelectedPage(this.pageIndex);
}

// errors are pretty unlikely to occur, but we can handle them anyway

class NavDestinationError extends NavRailState {
  final String message;
  NavDestinationError(this.message);
}
