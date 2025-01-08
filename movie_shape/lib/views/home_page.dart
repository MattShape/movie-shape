import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "MovieShape",
        style: AppConstants.fontFamily(
          color: AppConstants.textColour,
          fontSize: AppConstants.companyTitleSize
        ))
    );
  }
}
