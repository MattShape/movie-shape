import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_shape/models/film.dart';

// Repository for handling API requests with OMDb API
class FilmRepo {
  // TODO: search by s request

  static Future<Film> fetchFilmById(String id) async {
    final response = await http
      .get(Uri.parse('https://www.omdbapi.com/?apikey=810d5ee8&i=${id}'));
    
    if (response.statusCode == 200) {
      return Film.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load film');
    }
  }
}