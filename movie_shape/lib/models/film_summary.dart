// Data representation of a film's summary from film by search request
class FilmSummary {
  final String title;
  final String year;
  final String id;
  final String type;
  final String poster;

  FilmSummary(
      {required this.title,
      required this.year,
      required this.id,
      required this.type,
      required this.poster});

  factory FilmSummary.fromJson(Map<String, dynamic> json) {
    const String defaultPosterUrl =
        'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';

    String parsedYear = json["release_date"] is int
        ? json["release_date"].toString()
        : json["release_date"] ?? "unknown_year";

    String parsedId =
        json["id"] is int ? json["id"].toString() : json["id"] ?? "unknown_id";

    var filmSummary = FilmSummary(
      title: json['title'] ?? 'Unknown Title',
      year: parsedYear,
      type: json['Type'] ?? 'Unknown Type',
      id: parsedId,
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
      'id': id,
      'Type': type,
      'Poster': poster,
    };
  }
}
