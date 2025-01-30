import 'package:flutter/material.dart';
import 'package:movie_shape/helpers/constants.dart';

class PageTitleCard extends StatelessWidget {
  final String title;

  const PageTitleCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: 66,
        color: AppConstants.primaryColour,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: AppConstants.companyTitleSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
