import 'package:flutter/material.dart';

//please add the colors you need for your views in this theme

ThemeData tromegaTheme() {
  return ThemeData(
    // Colors
    backgroundColor: Colors.white,
    primaryColor: const Color(0xff003050),
    primaryColorLight: const Color(0xff5cbffb),
    highlightColor: Colors.grey[300],
    indicatorColor: Colors.green,
    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
        const Color(0xff003050),
      )),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),

    // Icons
    iconTheme: const IconThemeData(
      color: Color(0xff003050),
    ),

    // Text Theme:
    // fontSizes comply to Material-Design guidelines
    textTheme: const TextTheme(
      // Headlines
      headlineLarge: TextStyle(
        fontSize: 32,
        fontFamily: 'Proxima Nova Bold',
        color: Color(0xff003050),
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontFamily: 'Proxima Nova Bold',
        color: Color(0xff003050),
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontFamily: 'Proxima Nova Bold',
        color: Color(0xff003050),
        letterSpacing: -0.5,
      ),

      // Title
      titleLarge: TextStyle(
        fontSize: 22,
        fontFamily: 'Proxima Nova Bold',
        color: Color(0xff003050),
        letterSpacing: -0.5,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'Proxima Nova Bold',
        color: Color(0xff003050),
        letterSpacing: -0.5,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontFamily: 'Proxima Nova Bold',
        color: Color(0xff003050),
        letterSpacing: -0.5,
      ),

      // Labels
      labelLarge: TextStyle(
        fontSize: 14,
        fontFamily: 'Proxima Nova',
        color: Colors.white,
        letterSpacing: -0.5,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontFamily: 'Proxima Nova',
        color: Colors.white,
        letterSpacing: -0.5,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontFamily: 'Proxima Nova',
        color: Colors.white,
        letterSpacing: -0.5,
      ),

      // Indicator
      displayLarge: TextStyle(
        fontSize: 22,
        fontFamily: 'Proxima Nova Bold',
        color: Color(0xff5cbffb),
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'Proxima Nova Bold',
        color: Color(0xff5cbffb),
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        fontFamily: 'Proxima Nova Bold',
        color: Color(0xff5cbffb),
        letterSpacing: -0.5,
      ),

      // Body
      bodyLarge: TextStyle(
        fontSize: 16,
        fontFamily: 'Proxima Nova',
        color: Colors.black,
        letterSpacing: -0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontFamily: 'Proxima Nova',
        color: Colors.black,
        letterSpacing: -0.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontFamily: 'Proxima Nova',
        color: Colors.black,
        letterSpacing: -0.5,
      ),
    ),
  );
}
