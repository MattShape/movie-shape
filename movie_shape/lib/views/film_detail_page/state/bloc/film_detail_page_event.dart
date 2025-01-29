part of 'film_detail_page_bloc.dart';

abstract class FilmDetailPageEvent {
  const FilmDetailPageEvent();
}

class LoadFilm extends FilmDetailPageEvent {
  final String filmId;

  const LoadFilm(this.filmId);
}

class ShowLongDescription extends FilmDetailPageEvent {
  final String filmId;
  final bool longDescription;

  const ShowLongDescription(this.filmId, this.longDescription);
}
