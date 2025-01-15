import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/views/favourites/state/favourites_list_bloc/favourites_list_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/views/pages/film_detail_page.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _goToDetailPage(String id) async {
      Film film = await FilmRepoImplemented().getFilmById(id: id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilmDetailPage(film: film),
        ),
      );
    }

    return BlocBuilder<FavouritesListBloc, FavouritesListState>(
      builder: (context, state) {
        if (state is FavouritesListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is FavouritesListLoaded) {
          if (state.favouritesList.isEmpty) {
            return const Center(
              child: Text('Your favourites list is empty'),
            );
          }

          return ListView.builder(
            itemCount: state.favouritesList.length,
            itemBuilder: (context, index) {
              final film = state.favouritesList[index];
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
          );
        }

        if (state is FavouritesListError) {
          return Center(
            child: Text(state.errorMessage),
          );
        }

        return Container();
      },
    );
  }
}