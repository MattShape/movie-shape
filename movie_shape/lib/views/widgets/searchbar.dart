import 'package:flutter/material.dart';
import 'package:movie_shape/models/film_search.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(List<FilmSummary>) onSearchResults;

  const CustomSearchBar({super.key, required this.onSearchResults});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  String _query = "";

  Future<void> _handleSearch(String title) async {
    final FilmsSearch? response = await FilmRepo.fetchFilmByTitle(title);
    print(response?.films[0].title);
    if (response != null) {
      widget.onSearchResults(response.films);
    } else {
      widget.onSearchResults([]);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: "Search for a film...",
      controller: _controller,
      onChanged: (value) {
        setState(() {
          _query = value;
        });
      },
      onSubmitted: (value) {
        _handleSearch(value);
        setState(() {
          _query = "";
        });
        _controller.clear();
      },
      leading: Icon(Icons.search),
    );
  }
}
