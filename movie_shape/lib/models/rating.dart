// Data representation of a film's ratings
class Rating {
  final String source;
  final String value;

  Rating({
    required this.source,
    required this.value,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      source: json['Source'] as String,
      value: json['Value'] as String, 
    );
  }
}