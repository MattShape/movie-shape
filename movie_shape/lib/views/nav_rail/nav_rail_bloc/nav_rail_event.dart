part of 'nav_rail_bloc.dart';

abstract class NavRailEvent {}

//There is only one event for the nav rail, selecing a destination

class SelectNavRailDestination extends NavRailEvent {
  final int pageIndex;
  SelectNavRailDestination(this.pageIndex);
}
