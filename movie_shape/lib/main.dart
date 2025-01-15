import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_shape/helpers/constants.dart';
import 'package:movie_shape/views/widgets/nav_rail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      //theme: ThemeData(scaffoldBackgroundColor: AppConstants.primaryColour),
      theme: ThemeData.from(
        colorScheme: AppConstants.colorScheme,
        textTheme: GoogleFonts.interTextTheme(),
      ).copyWith(
        // Customizing additional properties if needed
        scaffoldBackgroundColor: AppConstants.backgroundColour,
        iconTheme: IconThemeData(
          color: AppConstants.secondaryColour,
          size: AppConstants.IconSize,
        ),
      ),
      home: NavRail()
    );
    return materialApp;
  }
}