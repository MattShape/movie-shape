import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/views/add_film/add_film_view.dart';
import 'package:movie_shape/views/homepage/home_view.dart';
import 'package:movie_shape/views/homepage/state/home_bloc/home_bloc.dart';

class AddFilmPage extends StatelessWidget {
  const AddFilmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(filmRepo: FilmRepoImplemented()),
        ),
      ],
      child: AddFilmView(),
    );
  }
}
