import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/reusable/watchlist_button/list_card.dart';
import 'package:movie_shape/views/homepage/state/home_bloc/home_bloc.dart';
import 'package:movie_shape/views/pages/film_detail_page.dart';
import 'package:movie_shape/views/widgets/searchbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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

    return Column(
      children: [
        CustomSearchBar(onSearchResults: (searchQuery) {
          context.read<HomeBloc>().add(OnSearchSubmit(searchQuery));
        }),
        Expanded(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              // step 1 add in search bar
              if (state is HomeInitial) {
                return const Center(
                  child: Text("Search for a film"),
                );
              }

              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is HomeLoaded) {
                return ListView.builder(
                  itemCount: state.filmlist.length,
                  itemBuilder: (context, index) {
                    final film = state.filmlist[index];
                    return ListCard(
                      film: film,
                      onTap: (val) {
                        _goToDetailPage(val);
                      },
                    );
                  },
                );
              }

              if (state is HomeError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
