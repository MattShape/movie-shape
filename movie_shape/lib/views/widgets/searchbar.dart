import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearchResults;

  CustomSearchBar({super.key, required this.onSearchResults});

  final TextEditingController _controller = TextEditingController();

  void _handleSearch(String title) {
    onSearchResults(title);
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: "Search for a film...",
      controller: _controller,
      onSubmitted: (value) {
        _handleSearch(value);
      },
      leading: Icon(Icons.search),
    );
  }
}
