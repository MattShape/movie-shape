import 'package:movie_shape/models/film.dart';

class FilmList {
  List<Film> films;

  FilmList({required this.films});

  factory FilmList.fromJson(List<dynamic> jsonList) {
    List<Film> films = jsonList.map((json) => Film.fromJson(json)).toList();
    return FilmList(films: films);
  }
}
