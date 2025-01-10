import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_shape/models/film.dart';

import "../models/film_search.dart";

// Repository for handling API requests with OMDb API
class FilmRepo {
  static const String _apiKey = "f7594dee";
  static const String _baseUrl = "http://omdbapi.com/";

  static Future<Film> fetchFilmById(String id) async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?apikey=810d5ee8&i=$id'));

    if (response.statusCode == 200) {
      return Film.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load film');
    }
  }

  static Future<FilmsSearch?> fetchFilmByTitle(String title) async {
    final response = await http
        .get(Uri.parse("$_baseUrl?apikey=$_apiKey&type=movie&s=$title"));

    // print(response.statusCode);

    if (response.statusCode == 200) {
      return FilmsSearch.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fail");
    }
  }
}
