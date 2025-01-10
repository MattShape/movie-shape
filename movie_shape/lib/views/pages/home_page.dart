import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/views/widgets/searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FilmSummary> _filmResults = [];

  void _updateFilmResults(List<FilmSummary> films) {
    setState(() {
      _filmResults = films;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text("MovieShape",
                    style: AppConstants.fontFamily(
                        color: AppConstants.textColour,
                        fontSize: AppConstants.companyTitleSize)),
                Expanded(child: CustomSearchBar()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
