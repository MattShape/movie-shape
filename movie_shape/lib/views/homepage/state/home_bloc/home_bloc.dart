import 'package:bloc/bloc.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<OnSearchSubmit>((event, emit) async {
      try {
        emit(HomeLoading());
        List<FilmSummary> filmList = await FilmRepoImplemented()
            .getFilms(searchQuery: event.searchQuery);
        emit(HomeLoaded(filmList));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
