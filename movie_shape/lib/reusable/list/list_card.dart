import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/reusable/favourite_button/favourite_button.dart';
import 'package:movie_shape/reusable/watchlist_button/watchlist_button.dart';

class ListCard extends StatelessWidget {
  final FilmSummary film;
  final Function(String) onTap;

  const ListCard({super.key, required this.film, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(65.0),
        child: Card(
          color: AppConstants.primaryColour,
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
          child: InkWell(
            onTap: () {
              onTap(film.id);
            },
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          film.poster,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          film.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppConstants.textColour,
                              fontSize: 28),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "Release date: ${film.year}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppConstants.textColour,
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FavouriteButton(film: film),
                      WatchlistButton(film: film)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
