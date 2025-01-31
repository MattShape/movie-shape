import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';

part 'add_film_button_event.dart';
part 'add_film_button_state.dart';

class AddFilmButtonBloc extends Bloc<AddFilmButtonEvent, AddFilmButtonState> {
  final FilmRepo filmRepo;
  final FilmRepoImplemented omdbRepo = FilmRepoImplemented();

  AddFilmButtonBloc({required this.filmRepo}) : super(AddFilmButtonInitial()) {
    on<AddFilmButtonDisplayed>((event, emit) async {
      emit(AddFilmButtonLoading());
      try {
        List<FilmSummary> filmList =
            await filmRepo.searchFilmsByTitle(searchQuery: event.film.title);
        bool isFilmInDb =
            filmList.any((film) => film.title == event.film.title);
        emit(AddFilmButtonLoaded(isFilmInDb));
      } catch (e) {
        emit(AddFilmButtonError(e.toString()));
      }
    });

    on<AddFilmButtonPressed>((event, emit) async {
      emit(AddFilmButtonLoading());

      try {
        List<FilmSummary> filmList =
            await filmRepo.searchFilmsByTitle(searchQuery: event.film.title);
        bool isFilmInDb =
            filmList.any((film) => film.title == event.film.title);

        if (isFilmInDb) {
          FilmSummary filmFromDB = filmList.firstWhere(
            (film) => film.title == event.film.title,
          );
          await filmRepo.removeFilm(id: int.tryParse(filmFromDB.imdbID) ?? 0);
          emit(AddFilmButtonLoaded(false));
        } else {
          Film film = await omdbRepo.getFilmById(id: event.film.imdbID);
          await filmRepo.addFilm(film: film);
          emit(AddFilmButtonLoaded(true));
        }
      } catch (e) {
        emit(AddFilmButtonError(e.toString()));
      }
    });
  }
}
