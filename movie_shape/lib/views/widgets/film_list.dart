import 'package:flutter/material.dart';
import 'package:movie_shape/models/film_summary.dart';

class FilmList extends StatefulWidget {
  final List<FilmSummary> films;

  const FilmList({super.key, required this.films});

  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.films.length,
        itemBuilder: (context, index) {
          final film =
              widget.films[index]; // Access the films using widget.films
          return ListTile(
            title: Text(film.title),
            subtitle: Text(film.year),
            leading: Image.network(film.poster),
            onTap: () {
              // Handle film tap (e.g., navigate to film details screen)
            },
          );
        },
      ),
    );
  }
}
