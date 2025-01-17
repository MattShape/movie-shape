import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/reusable/list/list_card.dart';
import 'package:movie_shape/reusable/page_title_card.dart';
import 'package:movie_shape/views/pages/film_detail_page.dart';
import 'package:movie_shape/views/watchlist/state/watchlist_bloc/watchlist_bloc.dart';
import 'package:movie_shape/views/widgets/searchbar.dart';

class WatchlistView extends StatelessWidget {
  const WatchlistView({super.key});

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
        // Title card
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 14),
          child: PageTitleCard(title: 'Watchlist'),
        ),
        // Search bar
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 28),
          child: CustomSearchBar(
            onSearchResults: (searchQuery) {
              context.read<WatchlistBloc>().add(SearchWatchlist(searchQuery));
            },
            onClear: () =>
                {context.read<WatchlistBloc>().add(ClearWatchSearch())},
            hintText: "Search your Watch List...",
          ),
        ),
        Expanded(
          child: BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, state) {
              if (state is WatchlistLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is WatchlistLoaded) {
                if (state.watchlist.isEmpty) {
                  return const Center(
                    child: Text('Your watchlist is empty'),
                  );
                }

                return ListView.builder(
                  itemCount: state.watchlist.length,
                  itemBuilder: (context, index) {
                    final film = state.watchlist[index];
                    return ListCard(
                      film: film,
                      onTap: (val) {
                        _goToDetailPage(val);
                      },
                    );
                  },
                );
              }

              if (state is WatchlistError) {
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
