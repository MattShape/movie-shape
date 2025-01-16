import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearchResults;
  final VoidCallback? onClear;
  final String hintText;

  CustomSearchBar(
      {super.key,
      required this.onSearchResults,
      this.onClear,
      required this.hintText});

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
      hintText: hintText,
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
