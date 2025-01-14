part of 'home_bloc.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<FilmSummary> filmlist;
  const HomeLoaded(this.filmlist);
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}
