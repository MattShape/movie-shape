import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/reusable/add_film_button/add_film_button.dart';
import 'package:movie_shape/reusable/list/list_card.dart';
import 'package:movie_shape/views/homepage/state/home_bloc/home_bloc.dart';
import 'package:movie_shape/views/nav_rail/state/nav_rail_bloc.dart';
import 'package:movie_shape/views/widgets/searchbar.dart';
import 'package:movie_shape/reusable/page_title_card.dart';

class AddFilmView extends StatelessWidget {
  const AddFilmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title Card
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 14),
          child: PageTitleCard(
            title: 'Add a film from omDB',
          ),
        ),
        // Search Bar
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 28),
          child: CustomSearchBar(
            onSearchResults: (searchQuery) {
              context.read<HomeBloc>().add(OnSearchSubmit(searchQuery));
            },
            hintText: "Search for a film...",
          ),
        ),

        // Film List View
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
                    return ListCardAddFilm(
                      film: film,
                      onTap: (val) async {
                        context.read<NavRailBloc>().add(FilmSelected(val));
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

class ListCardAddFilm extends StatelessWidget {
  final FilmSummary film;
  final Function(String) onTap;

  const ListCardAddFilm({super.key, required this.film, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(65.0),
        child: Card(
          color: AppConstants.primaryColour,
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
          child: InkWell(
            onTap: () {
              onTap(film.imdbID);
            },
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          film.poster,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          film.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppConstants.textColour,
                              fontSize: 28),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "Release date: ${film.year}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppConstants.textColour,
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AddFilmButton(film: film),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
