import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:movie_shape/views/homepage/home_page.dart';
import 'package:movie_shape/views/favourites/favourites_page.dart';
import 'package:movie_shape/views/watchlist/watchlist_page.dart';

part 'nav_rail_event.dart';
part 'nav_rail_state.dart';

class NavRailBloc extends Bloc<NavRailEvent, NavRailState> {
  NavRailBloc() : super(DisplaySelectedPage(0, HomePage())) {
    on<DestinationSelected>(_onDestinationSelected);
  }

  void _onDestinationSelected(event, emit) async {
    try {
      switch (event.selectedIndex) {
        case 0:
          emit(DisplaySelectedPage(event.selectedIndex, HomePage()));
        case 1:
          emit(DisplaySelectedPage(event.selectedIndex, FavouritesPage()));
        case 2:
          emit(DisplaySelectedPage(event.selectedIndex, WatchlistPage()));
        default:
          emit(NavRailError('no page found'));
      }
    } catch (e) {
      emit(NavRailError(e.toString()));
    }
  }
}
