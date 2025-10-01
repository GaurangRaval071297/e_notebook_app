import 'package:flutter/material.dart';
import 'Screens/Splash_Screen/splash_screen.dart';

void main() {
  final Color primaryColor = Colors.blue.shade800;
  final Color accentColor = Colors.lightBlue.shade300;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: accentColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: accentColor.withOpacity(0.1),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          labelStyle: TextStyle(color: primaryColor),
          errorStyle: TextStyle(color: Colors.red),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionColor: accentColor.withOpacity(0.5),
          selectionHandleColor: primaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primaryColor),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    ),
  );
}