// Data representation of a film's summary from film by search request
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
      year: json['Year'] ?? 'Unknown Year',
      type: json['Type'] ?? 'Unknown Type',
      imdbID: json['imdbID'] ?? 'Unknown imdbID',
      // if response is 'N/A' set to default poster, if null
      poster: Uri.tryParse(json['poster_link'] ?? '')?.hasAbsolutePath == true
          ? json['poster_link']
          : defaultPosterUrl,
    );

    return filmSummary;
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Year': year,
      'imdbID': imdbID,
      'Type': type,
      'Poster': poster,
    };
  }
}
