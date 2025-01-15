import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearchResults;
  final VoidCallback? onClear;

  CustomSearchBar({super.key, required this.onSearchResults, this.onClear});

  final TextEditingController _controller = TextEditingController();

  void _handleSearch(String title) {
    onSearchResults(title);
  }

  void _handleClear() {
    _controller.clear();
    if (onClear != null) {
      onClear!();
    }
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
      trailing: onClear != null
          ? [IconButton(onPressed: _handleClear, icon: Icon(Icons.clear))]
          : null,
    );
  }
}
