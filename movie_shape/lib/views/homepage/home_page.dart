import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_shape/views/homepage/home_view.dart';
import 'package:movie_shape/views/homepage/state/home_bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ],
      child: HomeView(),
    );
  }
}
