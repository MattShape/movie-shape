import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/views/widgets/favourites_button.dart';

class FilmDetailPage extends StatelessWidget {
  const FilmDetailPage({super.key, required this.film});

  final Film film;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 120, right: 120, top: 40),
          child: Column(
            children: [
              // film heading row
              Row(
                children: [
                  // poster
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(film.poster,
                          width: 280,
                          height: 360,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
          
                  SizedBox(width: 40),
          
                  // title and subtitle
                  Flexible(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 600,
                        maxHeight: 360
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),

                          Text(
                            film.title,
                            style: AppConstants.fontFamily( 
                              color: AppConstants.textColour,
                              fontSize: AppConstants.filmTitleSize,
                              fontWeight: FontWeight.w500,
                            )
                          ),
                          Text(
                            film.year,
                            style: AppConstants.fontFamily( 
                              color: AppConstants.textColour,
                              fontSize: AppConstants.filmSubtitleSize,
                            )
                          ),
                          Text(
                            film.director,
                            style: AppConstants.fontFamily( 
                              color: AppConstants.textColour,
                              fontSize: AppConstants.filmSubtitleSize,
                              fontWeight: FontWeight.w500,
                            )
                          ),
                          Text(
                            film.runtime,
                            style: AppConstants.fontFamily( 
                              color: AppConstants.textColour,
                              fontSize: AppConstants.filmSubtitleSize,
                            )
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),

                              FavouritesButton(film: film),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 40),
          
              // plot row
              Row(
                children: [
                  // stop overflow
                  Flexible(
                    child: Text(
                      film.plot,
                      style: AppConstants.fontFamily(
                        color: AppConstants.textColour,
                        fontSize: AppConstants.bodySize
                      )
                    ),
                  )
                ],
              ),
          
              SizedBox(height: 32),
          
              // rating column
              Column(
                children: [
                  // rating title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ratings",
                        style: AppConstants.fontFamily(
                          color: AppConstants.textColour,
                          fontSize: AppConstants.bodySize
                        )
                      )
                    ],
                  ),
                  
                  // ratings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: film.ratings
                    .map(
                      (rating) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          children: [
                            Text(
                              rating.source,
                              style: AppConstants.fontFamily(
                                color: AppConstants.textColour,
                                fontSize: AppConstants.bodySize
                              )
                            ),
                            SizedBox(width: 5),
                            Text(
                              rating.value,
                              style: AppConstants.fontFamily(
                                color: AppConstants.textColour,
                                fontSize: AppConstants.bodySize
                              )
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                  ),
                ],
              ),
          
              SizedBox(height: 32),
          
              // extras row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // cast
                  Column(
                    children: [
                      Text(
                        "Cast",
                        style: AppConstants.fontFamily(
                          color: AppConstants.textColour,
                          fontSize: AppConstants.bodySize
                        )
                      ),
        
                      // scrolling cast names
                      Container(
                        height: 100,
                        child: SingleChildScrollView(
                          child: Column(
                            children: film.actors
                              .map((item) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.trim(), // Trim whitespace around each value
                                  style: TextStyle(
                                    color: AppConstants.textColour,
                                    fontSize: AppConstants.bodySize,
                                    ),
                                ),
                              ))
                          .toList(),
                          )
                        ),
                      )
                    ],
                  ),
          
                  // crew
                  Column(
                    children: [
                      Text(
                        "Crew",
                        style: AppConstants.fontFamily(
                          color: AppConstants.textColour,
                          fontSize: AppConstants.bodySize,
                        )
                      ),
        
                      // scrolling crew names
                      Container(
                        height: 100,
                        child: SingleChildScrollView(
                          child: Column(
                            children: film.writer
                              .map((item) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.trim(), // Trim whitespace around each value
                                  style: TextStyle(
                                    color: AppConstants.textColour,
                                    fontSize: AppConstants.bodySize,
                                    ),
                                ),
                              ))
                          .toList(),
                          )
                        ),
                      )
                    ],
                  ),
          
                  // awards
                  Column(
                    children: [
                      Text(
                        "awards",
                        style: AppConstants.fontFamily(
                          color: AppConstants.textColour,
                          fontSize: AppConstants.bodySize,
                        )
                      ),
        
                      // scrolling awards names
                      Container(
                        height: 100,
                        child: SingleChildScrollView(
                          child: Column(
                            children: film.awards
                              .map((item) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.trim(), // Trim whitespace around each value
                                  style: TextStyle(
                                    color: AppConstants.textColour,
                                    fontSize: AppConstants.bodySize,
                                    ),
                                ),
                              ))
                          .toList(),
                          )
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}