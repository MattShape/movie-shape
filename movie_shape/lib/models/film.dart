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
  final List<String> writer;
  final List<String> actors;
  final String plot;
  final List<String> language;
  final String country;
  final List<String> awards;
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
    const String defaultPosterUrl =
        'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';

    var film = Film(
      title: json['title'] as String? ?? 'N/A',
      year: (json['release_date'] as int?).toString(),
      rated: json['Rated'] as String? ?? 'N/A',
      released: json['Released'] as String? ?? 'N/A',
      runtime: json['Runtime'] as String? ?? 'N/A',
      genre: json['Genre'] as String? ?? 'N/A',
      director: json['Director'] as String? ?? 'N/A',
      // // convert csv string into list
      writer: (json['Writer'] as String?)
              ?.split(',')
              .map((writer) => writer.trim())
              .toList() ??
          ['N/A'],
      // convert csv string into list
      actors: (json['Actors'] as String?)
              ?.split(',')
              .map((actor) => actor.trim())
              .toList() ??
          ['N/A'],
      plot: json['Plot'] as String? ?? 'N/A',
      // convert csv string into list
      language: (json['Language'] as String?)
              ?.split(',')
              .map((actor) => actor.trim())
              .toList() ??
          ['N/A'],
      country: json['Country'] as String? ?? 'N/A',
      //awards: json['Awards'] as String? ?? 'N/A',
      awards: (json['Awards'] as String?) // Extract awards string
              ?.split(RegExp(r'[.&]')) // Split by "." and "&"
              .map((part) => part.trim()) // Trim whitespace
              .toList() ??
          [], // Default to empty list if null
      // if response is 'N/A' set to default poster, if null set to '', else keep url from response
      poster: Uri.tryParse(json['Poster'] ?? '')?.hasAbsolutePath == true
          ? json['Poster']
          : defaultPosterUrl,
      // convert JSON list into Rating class
      ratings: (json['Ratings'] as List<dynamic>?)
              ?.map((item) => Rating.fromJson(item))
              .toList() ??
          [],
      metascore: json['Metascore'] as String? ?? 'N/A',
      imdbRating: json['imdbRating'] as String? ?? 'N/A',
      imdbVotes: json['imdbVotes'] as String? ?? 'N/A',
      imdbId: (json['id'] as int?).toString(),
      type: json['Type'] as String? ?? 'N/A',
      dvd: json['DVD'] as String? ?? 'N/A',
      boxOffice: json['BoxOffice'] as String? ?? 'N/A',
      production: json['Production'] as String? ?? 'N/A',
      response: json['Response']?.toString() ?? 'False',
    );

    return film;
  }

  factory Film.fromServerJson(Map<String, dynamic> json) {
    const String defaultPosterUrl =
        'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';

    var film = Film(
      title: json['title'] as String? ?? 'N/A',
      year: (json['release_date'] as int?).toString() ?? 'N/A',
      rated: json['certificate'] as String? ?? 'N/A',
      released: json['released'] as String? ?? 'N/A',
      runtime: json['runtime'] as String? ?? 'N/A',
      genre: json['genre'] as String? ?? 'N/A',
      director: json['director'] as String? ?? 'N/A',
      // TODO: NO WRITER FROM SERVER RESPONSE
      writer: (json['writer'] as String?)
              ?.split(',')
              .map((writer) => writer.trim())
              .toList() ??
          ['N/A'],
      actors: [
        json['star1'] as String? ?? 'N/A',
        json['star2'] as String? ?? 'N/A',
        json['star3'] as String? ?? 'N/A',
        json['star4'] as String? ?? 'N/A',
      ],
      plot: json['description'] as String? ?? 'N/A',
      // TODO: NO LANGUAGE FROM SERVER RESPONSE
      language: (json['language'] as String?)
              ?.split(',')
              .map((actor) => actor.trim())
              .toList() ??
          ['N/A'],
      // TODO: NO COUNTRY FROM SERVER RESPONSE
      country: json['country'] as String? ?? 'N/A',
      // TODO: NO AWARDS FROM SERVER RESPONSE
      awards: (json['awards'] as String?)
              ?.split(RegExp(r'[.&]')) // Split by "." and "&"
              .map((part) => part.trim()) // Trim whitespace
              .toList() ??
          [],
      poster: Uri.tryParse(json['poster_link'] ?? '')?.hasAbsolutePath == true
          ? json['poster_link']
          : defaultPosterUrl,
      ratings: [
        Rating(
            source: 'IMDb',
            value: json['imdb_rating'] as String? ??
                'N/A'), // SQL Column: imdb_rating
        Rating(
            source: 'Metascore',
            value: (json['meta_score'] as int?).toString() ??
                'N/A'), // SQL Column: meta_score
      ],
      metascore: (json['meta_score'] as int?).toString() ?? 'N/A',
      imdbRating:
          json['imdb_rating'] as String? ?? 'N/A', // SQL Column: imdb_rating
      imdbVotes: (json['no_of_votes'] as int?).toString() ??
          'N/A', // SQL Column: no_of_votes
      imdbId: (json['id'] as int?).toString() ?? 'N/A',
      type: 'Film',
      dvd: 'N/A',
      boxOffice: json['gross'] as String? ?? 'N/A',
      // TODO: no production from SERVER RESPONSE
      production: json['production'] as String? ?? 'N/A',
      response: 'True',
    );

    return film;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'release_date': year,
      'Rated': rated,
      'Released': released,
      'Runtime': runtime,
      'Genre': genre,
      'Director': director,
      'Writer': writer,
      'Actors': actors,
      'Plot': plot,
      'Language': language,
      'Country': country,
      'Awards': awards,
      'Poster': poster,
      'Ratings': ratings.map((rating) => rating.toJson()).toList(),
      'Metascore': metascore,
      'imdbRating': imdbRating,
      'imdbVotes': imdbVotes,
      'id': int.parse(imdbId),
      'Type': type,
      'DVD': dvd,
      'BoxOffice': boxOffice,
      'Production': production,
      'Response': response,
    };
  }

  factory Film.fromCustomJson(Map<String, dynamic> json) {
    return Film(
      title: json['Title'] ?? 'N/A',
      year: json['Year'] ?? 'N/A',
      rated: json['Rated'] ?? 'N/A',
      released: json['Released'] ?? 'N/A',
      runtime: json['Runtime'] ?? 'N/A',
      genre: json['Genre'] ?? 'N/A',
      director: json['Director'] ?? 'N/A',
      writer: List<String>.from(json['Writer'] ?? []),
      actors: List<String>.from(json['Actors'] ?? []),
      plot: json['Plot'] ?? 'N/A',
      language: List<String>.from(json['Language'] ?? []),
      country: json['Country'] ?? 'N/A',
      awards: List<String>.from(json['Awards'] ?? []),
      poster: json['Poster'] ?? '',
      ratings: (json['Ratings'] as List<dynamic>?)
              ?.map((ratingJson) => Rating.fromJson(ratingJson))
              .toList() ??
          [],
      metascore: json['Metascore'] ?? 'N/A',
      imdbRating: json['imdbRating'] ?? 'N/A',
      imdbVotes: json['imdbVotes'] ?? 'N/A',
      imdbId: json['imdbID'] ?? 'N/A',
      type: json['Type'] ?? 'N/A',
      dvd: json['DVD'] ?? 'N/A',
      boxOffice: json['BoxOffice'] ?? 'N/A',
      production: json['Production'] ?? 'N/A',
      response: json['Response'] ?? 'N/A',
    );
  }
}
