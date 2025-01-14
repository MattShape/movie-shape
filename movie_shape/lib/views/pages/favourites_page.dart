import 'package:flutter/material.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo_implemented.dart';
import 'package:movie_shape/reusable/watchlist_button/list_card.dart';
import 'package:movie_shape/views/pages/film_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late Future<List<Film>> _favouriteFilmsFuture;

  @override
  void initState() {
    super.initState();
    _favouriteFilmsFuture = loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _goToDetailPage(String id) async {
      Film film = await FilmRepoImplemented().getFilmById(id: id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilmDetailPage(film: film),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Film>>(
              future: _favouriteFilmsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // waiting
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // no data
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // data but empty favourites list
                  return Center(child: Text('No favourites found.'));
                } else {
                  // favourites list
                  List<Film> favouriteFilms = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: favouriteFilms.length,
                    itemBuilder: (context, index) {
                      final film = favouriteFilms[index];

                      return ListCard(
                        film: FilmSummary(
                            title: film.title,
                            year: film.year,
                            imdbID: film.imdbId,
                            type: film.type,
                            poster: film.poster),
                        onTap: (val) {
                          _goToDetailPage(val);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Film>> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favouritesFromPrefs = prefs.getStringList("favourites") ?? [];

    if (favouritesFromPrefs.isEmpty) {
      print("Nothing in favourites");
      return [];
    }

    List<Film> favouriteFilms = favouritesFromPrefs.map((jsonString) {
      return Film.fromCustomJson(jsonDecode(jsonString));
    }).toList();

    return favouriteFilms;
  }
}
