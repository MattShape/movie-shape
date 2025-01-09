import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  String _query = "";

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
        print(_query);
        setState(() {
          _query = "";
        });
        _controller.clear();
      },
      leading: Icon(Icons.search),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
