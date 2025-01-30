class FilmSummary {
  final int id;
  final String posterLink;
  final String title;
  final int releaseDate;
  final String genre;

  FilmSummary({
    required this.id,
    required this.posterLink,
    required this.title,
    required this.releaseDate,
    required this.genre,
  });

  factory FilmSummary.fromJson(Map<String, dynamic> json) {
    return FilmSummary(
      id: json['id'],
      posterLink: json['poster_link'],
      title: json['title'],
      releaseDate: json['release_date'],
      genre: json['genre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_link': posterLink,
      'title': title,
      'release_date': releaseDate,
      'genre': genre,
    };
  }
}
