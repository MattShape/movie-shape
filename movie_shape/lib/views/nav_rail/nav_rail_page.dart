import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/views/nav_rail/nav_rail_view.dart';
import 'package:movie_shape/views/nav_rail/state/nav_rail_bloc.dart';

class NavRailPage extends StatelessWidget {
  const NavRailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavRailBloc(),
      child: NavRailView(),
    );
  }
}
