import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/views/pages/film_detail_page.dart';

class FilmList extends StatefulWidget {
  final List<FilmSummary> films;

  const FilmList({super.key, required this.films});

  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  Future<void> _goToDetailPage(String id) async {
    Film film = await FilmRepoImplemented().getFilmById(id: id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilmDetailPage(film: film),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.films.length,
        itemBuilder: (context, index) {
          final film =
              widget.films[index]; // Access the films using widget.films
          return Card(
            color: AppConstants.secondaryFgColour,
            shadowColor: AppConstants.accentColour,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            elevation: 4,
            child: ListTile(
              title: Text(
                film.title,
                style: TextStyle(color: AppConstants.textColour),
              ),
              subtitle: Text(
                film.year,
                style: TextStyle(color: AppConstants.textColour),
              ),
              leading: Image.network(
                film.poster,
              ),
              onTap: () {
                _goToDetailPage(film.imdbID);
              },
            ),
          );
        },
      ),
    );
  }
}
