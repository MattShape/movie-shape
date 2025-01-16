import 'package:bloc/bloc.dart';

part 'nav_rail_event.dart';
part 'nav_rail_state.dart';

class NavRailBloc extends Bloc<NavRailEvent, NavRailState> {
  NavRailBloc() : super(DisplaySelectedPage(0)) {
    on<SelectNavRailDestination>((event, emit) {
      try {
        emit(DisplaySelectedPage(event.pageIndex));
      } catch (e) {
        emit(NavDestinationError(e.toString()));
      }
    });
  }
}
