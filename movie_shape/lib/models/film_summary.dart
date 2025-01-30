// Data representation of a film's summary from film by search request
import 'package:movie_shape/models/film.dart';

class FilmSummary {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  FilmSummary(
      {required this.title,
      required this.year,
      required this.imdbID,
      required this.type,
      required this.poster});

  factory FilmSummary.fromJson(Map<String, dynamic> json) {
    const String defaultPosterUrl =
        'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';

    var filmSummary = FilmSummary(
      title: json['title'] ?? 'Unknown Title',
      year: (json['release_date']).toString(),
      type: json['Type'] ?? 'Unknown Type',
      imdbID: (json['id']).toString(),
      // if response is 'N/A' set to default poster, if null
      poster: Uri.tryParse(json['poster_link'] ?? '')?.hasAbsolutePath == true
          ? json['poster_link']
          : defaultPosterUrl,
    );

    return filmSummary;
  }

  factory FilmSummary.fromFilm(Film film) {
    return FilmSummary(
      title: film.title,
      year: film.year,
      imdbID: film.imdbId,
      type: film.type,
      poster: film.poster,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Year': int.parse(year),
      'id': int.parse(imdbID),
      'Type': type,
      'Poster': poster,
    };
  }
}
