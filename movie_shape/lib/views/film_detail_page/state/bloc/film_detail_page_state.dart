part of 'film_detail_page_bloc.dart';

abstract class FilmDetailPageState {
  const FilmDetailPageState();
}

class FilmDetailPageInitial extends FilmDetailPageState {}

class FilmDetailPageLoading extends FilmDetailPageState {}

class FilmDetailPageLoaded extends FilmDetailPageState {
  final Film film;

  const FilmDetailPageLoaded(this.film);
}

class FilmDetailPageError extends FilmDetailPageState {
  final String message;

  const FilmDetailPageError(this.message);
}
