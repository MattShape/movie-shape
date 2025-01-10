import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/views/widgets/searchbar.dart';
import 'package:movie_shape/views/widgets/film_list.dart'; // Import the FilmList widget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FilmSummary> _filmResults = [];

  // This function will be called by the search bar to update the list
  void _updateFilmResults(List<FilmSummary> films) {
    setState(() {
      _filmResults = films;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColour,
        title: Text(
          "MovieShape",
          style: TextStyle(
              fontSize: AppConstants.companyTitleSize,
              color: AppConstants.textColour),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                    child:
                        CustomSearchBar(onSearchResults: _updateFilmResults)),
              ],
            ),
          ),
          // Film list is now displayed here
          FilmList(films: _filmResults),
        ],
      ),
    );
  }
}
