import 'package:movie_shape/models/rating.dart';

// Data representing the film's detail from search by id request
class Film {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  String poster;
  final List<Rating> ratings;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbId;
  final String type;
  final String dvd;
  final String boxOffice;
  final String production;
  final String response;

  Film({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbId,
    required this.type,
    required this.dvd,
    required this.boxOffice,
    required this.production,
    required this.response,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    const String defaultPosterUrl = 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';

    var film = Film(
      title: json['Title'] as String? ?? 'N/A',
      year: json['Year'] as String? ?? 'N/A',
      rated: json['Rated'] as String? ?? 'N/A',
      released: json['Released'] as String? ?? 'N/A',
      runtime: json['Runtime'] as String? ?? 'N/A',
      genre: json['Genre'] as String? ?? 'N/A',
      director: json['Director'] as String? ?? 'N/A',
      writer: json['Writer'] as String? ?? 'N/A',
      actors: json['Actors'] as String? ?? 'N/A',
      plot: json['Plot'] as String? ?? 'N/A',
      language: json['Language'] as String? ?? 'N/A',
      country: json['Country'] as String? ?? 'N/A',
      awards: json['Awards'] as String? ?? 'N/A',
      // if response is 'N/A' set to default poster, if null set to '', else keep url from response
      poster: Uri.tryParse(json['Poster'] ?? '')?.hasAbsolutePath == true
          ? json['Poster']
          : defaultPosterUrl,
      // convert JSON list into Rating class
      ratings: (json['Ratings'] as List<dynamic>?)
          ?.map((item) => Rating.fromJson(item))
          .toList() ?? [], 
      metascore: json['Metascore'] as String? ?? 'N/A',
      imdbRating: json['imdbRating'] as String? ?? 'N/A',
      imdbVotes: json['imdbVotes'] as String? ?? 'N/A',
      imdbId: json['imdbID'] as String? ?? 'N/A',
      type: json['Type'] as String? ?? 'N/A',
      dvd: json['DVD'] as String? ?? 'N/A',
      boxOffice: json['BoxOffice'] as String? ?? 'N/A',
      production: json['Production'] as String? ?? 'N/A',
      response: json['Response']?.toString() ?? 'False',
    );

    return film;
  }
}