class Film {
  final int id;
  final String posterLink;
  final String title;
  final int releaseDate;
  final String certificate;
  final String runtime;
  final String genre;
  final double rating;
  final String description;
  final int metaScore;
  final String director;
  final String star1;
  final String star2;
  final String star3;
  final String star4;
  final int noOfVotes;
  final String gross;

  Film({
    required this.id,
    required this.posterLink,
    required this.title,
    required this.releaseDate,
    required this.certificate,
    required this.runtime,
    required this.genre,
    required this.rating,
    required this.description,
    required this.metaScore,
    required this.director,
    required this.star1,
    required this.star2,
    required this.star3,
    required this.star4,
    required this.noOfVotes,
    required this.gross,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      posterLink: json['poster_link'],
      title: json['title'],
      releaseDate: json['release_date'],
      certificate: json['certificate'],
      runtime: json['runtime'],
      genre: json['genre'],
      rating: (json['rating'] as num).toDouble(),
      description: json['description'],
      metaScore: json['meta_score'],
      director: json['director'],
      star1: json['star1'],
      star2: json['star2'],
      star3: json['star3'],
      star4: json['star4'],
      noOfVotes: json['no_of_votes'],
      gross: json['gross'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_link': posterLink,
      'title': title,
      'release_date': releaseDate,
      'certificate': certificate,
      'runtime': runtime,
      'genre': genre,
      'rating': rating,
      'description': description,
      'meta_score': metaScore,
      'director': director,
      'star1': star1,
      'star2': star2,
      'star3': star3,
      'star4': star4,
      'no_of_votes': noOfVotes,
      'gross': gross,
    };
  }
}
