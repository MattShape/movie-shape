import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/views/pages/favourites_page.dart';
import 'package:movie_shape/models/film.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesButton extends StatefulWidget {
  final Film film;

  FavouritesButton({super.key, required this.film}); 

  @override
  State<FavouritesButton> createState() => _FavouritesButtonState();
}

class _FavouritesButtonState extends State<FavouritesButton> {
  bool selected = false;

  final prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      isSelected: selected,
      icon: const Icon(Icons.favorite_outline),
      selectedIcon: const Icon(Icons.favorite),
      onPressed: () {
        setState(() {
          selected = !selected;
        
          if (selected) {
            // add to favourites
            addToFavourites(widget.film);
          } else {
            // remove from favourites
            removeFromFavourites(widget.film);
          }
          });
      },
      color: AppConstants.accentColour,
    );
  }
}

Future<void> addToFavourites(Film film) async {
  final prefs = await SharedPreferences.getInstance();

  String filmJson = jsonEncode(film.toJson());

  List<String> currentList = prefs.getStringList("favourites") ?? [];

  currentList.add(filmJson);

  await prefs.setStringList("favourites", currentList);

  print("film: ${film} added");
  print(currentList);
}

Future<void> removeFromFavourites(Film film) async {
  final prefs = await SharedPreferences.getInstance();

  String filmJson = jsonEncode(film.toJson());

  List<String> currentList = prefs.getStringList("favourites") ?? [];

  currentList.remove(filmJson);

  await prefs.setStringList("favourites", currentList);

  print("Film removed: ${film.title}");
  print("Updated Favourites List: $currentList");
}
