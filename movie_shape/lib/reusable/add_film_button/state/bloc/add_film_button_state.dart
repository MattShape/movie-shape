part of 'add_film_button_bloc.dart';

@immutable
sealed class AddFilmButtonState {}

final class AddFilmButtonInitial extends AddFilmButtonState {}

final class AddFilmButtonLoading extends AddFilmButtonState {}

final class AddFilmButtonLoaded extends AddFilmButtonState {
  final bool isInServer;
  AddFilmButtonLoaded(this.isInServer);
}

final class AddFilmButtonError extends AddFilmButtonState {
  final String error;

  AddFilmButtonError(this.error);
}
