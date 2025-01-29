import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/views/film_detail_page/film_detail_view.dart';
import 'package:movie_shape/views/film_detail_page/state/bloc/film_detail_page_bloc.dart';

class FilmDetailPage extends StatelessWidget {
  final String filmId;

  const FilmDetailPage({super.key, required this.filmId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilmDetailPageBloc()..add(LoadFilm(filmId)),
      child: FilmDetailView(),
    );
  }
}
