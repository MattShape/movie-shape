import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/reusable/list/list_card.dart';
import 'package:movie_shape/views/film_detail_page/film_detail_view.dart';
import 'package:movie_shape/views/nav_rail/state/nav_rail_bloc.dart';

class FilmList extends StatefulWidget {
  final List<FilmSummary> films;

  const FilmList({super.key, required this.films});

  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  // Future<void> _goToDetailPage(String id) async {
  //   Film film = await FilmRepoImplemented().getFilmById(id: id);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => FilmDetailView(film: film),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.films.length,
        itemBuilder: (context, index) {
          final film =
              widget.films[index]; // Access the films using widget.films
          return ListCard(
            film: film,
            onTap: (val) async {
              context.read<NavRailBloc>().add(FilmSelected(val));
            },
          );
        },
      ),
    );
  }
}
