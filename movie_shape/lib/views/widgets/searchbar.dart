import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 48,
      child: SearchBar(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)))),
        backgroundColor: MaterialStateProperty.all(AppConstants.accentColour),
        textStyle: MaterialStateProperty.all(
            TextStyle(color: AppConstants.primaryColour)),
        hintText: hintText,
        controller: _controller,
        onSubmitted: (value) async {
          _handleSearch(value);
        },
        leading: Icon(
          Icons.search,
          color: AppConstants.secondaryColour,
        ),
        trailing: onClear != null
            ? [
                IconButton(
                    onPressed: _handleClear,
                    icon: Icon(
                      Icons.clear,
                      color: AppConstants.secondaryColour,
                    ))
              ]
            : null,
      ),
    );
  }
}
