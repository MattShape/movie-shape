part of 'nav_rail_bloc.dart';

@immutable
sealed class NavRailEvent {}

class DestinationSelected extends NavRailEvent {
  final int selectedIndex;

  DestinationSelected(this.selectedIndex);
}
