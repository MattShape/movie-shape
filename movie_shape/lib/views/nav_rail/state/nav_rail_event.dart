part of 'nav_rail_bloc.dart';

@immutable
sealed class NavRailEvent {}

class DestinationSelected extends NavRailEvent {
  final int selectedIndex;

  DestinationSelected(this.selectedIndex);
}

class FilmSelected extends NavRailEvent {
  final String filmId;

  FilmSelected(this.filmId);
}
