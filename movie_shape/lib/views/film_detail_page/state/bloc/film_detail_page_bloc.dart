import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/views/film_detail_page/film_detail_view.dart';

part 'film_detail_page_event.dart';
part 'film_detail_page_state.dart';

class FilmDetailPageBloc
    extends Bloc<FilmDetailPageEvent, FilmDetailPageState> {
  FilmDetailPageBloc() : super(FilmDetailPageInitial()) {
    on<LoadFilm>((event, emit) async {
      try {
        emit(FilmDetailPageLoading());

        Film film = await FilmRepoImplemented().getFilmById(id: event.filmId);
        emit(FilmDetailPageLoaded(film));
      } catch (e) {
        emit(FilmDetailPageError(e.toString()));
      }
    });
  }
}
