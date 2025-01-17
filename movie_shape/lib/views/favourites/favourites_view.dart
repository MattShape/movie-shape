import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/views/favourites/state/favourites_list_bloc/favourites_list_bloc.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/views/pages/film_detail_page.dart';
import 'package:movie_shape/reusable/list/list_card.dart';
import 'package:movie_shape/views/widgets/searchbar.dart';
import 'package:movie_shape/reusable/page_title_card.dart';

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

    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 14),
          child: PageTitleCard(title: 'Favourites'),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 28),
          child: CustomSearchBar(
            onSearchResults: (searchQuery) {
              context
                  .read<FavouritesListBloc>()
                  .add(SearchFavouritesList(searchQuery));
            },
            onClear: () {
              context.read<FavouritesListBloc>().add(ClearFavouritesSearch());
            },
            hintText: "Search your Favourites List...",
          ),
        ),
        Expanded(
          child: BlocBuilder<FavouritesListBloc, FavouritesListState>(
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
                    return ListCard(
                      film: film,
                      onTap: (val) {
                        _goToDetailPage(val);
                      },
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
          ),
        ),
      ],
    );
  }
}
