import 'package:flutter/material.dart';
import 'package:swift_talk_2/core/utils/costants.dart';

class CustomTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppInfo.kPrimaryColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppInfo.kPrimaryColor, // Main primary color
      onPrimary: AppInfo.kPrimaryColor2, // Contrast color for primary
      secondary: AppInfo.kPrimaryColor2, // Accent color
      onSecondary: AppInfo.kPrimaryColor2, // Contrast color for secondary
      error: Colors.red ,// Color for error messages
      onError: Colors.red, // Contrast color for error
      surface: AppInfo.kPrimaryColor2, // Surface color for components like cards
      onSurface: Colors.white, // Text color on surface
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple, // Elevated Button's background
        foregroundColor: Colors.white, // Elevated Button's text color
        elevation: 3, // Shadow elevation
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          side: const BorderSide(
            color: Colors.deepPurple, // Border color
            width: 2, // Border width
          ),
        ),
        minimumSize: const Size(88, 36), // Minimum button size
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(
        fontFamily: 'PTSerif',
        fontWeight: FontWeight.bold,
        fontSize: 35,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 22,
        color: Colors.grey[700],
      ),
      bodySmall: const TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppInfo.kPrimaryColor3, // Same background as light theme
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppInfo.kPrimaryColor3, // Main primary color for dark theme
      onPrimary: AppInfo.kPrimaryColor3, // Contrast color for primary
      secondary: AppInfo.kPrimaryColor, // Accent color
      onSecondary: AppInfo.kPrimaryColor, // Contrast color for secondary
      error: Colors.red, // Error color
      onError: Colors.red, // Contrast color for error
      surface: Colors.red, // Surface color for components
      onSurface: Colors.black, // Text color on surface
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppInfo.kPrimaryColor2, // Elevated Button's background
        foregroundColor: AppInfo.kPrimaryColor, // Elevated Button's text color
        elevation: 3, // Shadow elevation
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          side: const BorderSide(
            color: Colors.deepPurple, // Border color
            width: 2, // Border width
          ),
        ),
        minimumSize: const Size(88, 36), // Minimum button size
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(
        fontFamily: 'PTSerif',
        fontWeight: FontWeight.bold,
        fontSize: 35,
        color: Colors.black
      ),
      bodyMedium: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 22,
        color: Colors.grey[700],
      ),
      bodySmall: const TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        
      ),
    ),
  );
}