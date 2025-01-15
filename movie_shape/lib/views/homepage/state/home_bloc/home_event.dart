part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class OnSearchSubmit extends HomeEvent {
  final String searchQuery;
  OnSearchSubmit(this.searchQuery);
}
