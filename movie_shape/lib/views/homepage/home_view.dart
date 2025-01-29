import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/reusable/list/list_card.dart';
import 'package:movie_shape/views/homepage/state/home_bloc/home_bloc.dart';
import 'package:movie_shape/views/nav_rail/state/nav_rail_bloc.dart';
import 'package:movie_shape/views/widgets/searchbar.dart';
import 'package:movie_shape/reusable/page_title_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title Card
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 14),
          child: PageTitleCard(
            title: 'Home',
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
                    return ListCard(
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
