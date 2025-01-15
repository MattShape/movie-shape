import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/views/favourites/favourites_view.dart';
import 'package:movie_shape/views/favourites/state/favourites_list_bloc/favourites_list_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesListBloc()..add(LoadFavouritesList()),
      child: FavouritesView(),
    );
  }
}
