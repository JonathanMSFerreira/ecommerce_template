import 'package:flutter/material.dart';

BoxDecoration fundoGradient() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    gradient: LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      // Add one stop for each color. Stops should increase from 0 to 1
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Colors.blue[900].withOpacity(0.9),
        Colors.blue[800].withOpacity(0.8),
        Colors.blue[700].withOpacity(0.7),
        Colors.blue.withOpacity(0.6),

      ],
    ),
  );
}
