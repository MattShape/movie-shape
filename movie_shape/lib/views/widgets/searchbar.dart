import 'package:flutter/material.dart';
import 'package:movie_shape/models/film_search.dart';
import 'package:movie_shape/repository/film_repo.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  String _query = "";

  Future<void> _handleSearch(String title) async {
    final FilmsSearch? response = await FilmRepo.fetchFilmByTitle(title);
    print(response?.films[0].title);
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
