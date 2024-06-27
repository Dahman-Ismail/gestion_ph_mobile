import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';  // Import the GetX package
import 'initial_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleFonts.config.allowRuntimeFetching = false;
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF0066FF),
            onPrimary: Color(0xFFFB5A00),
            secondary: Color(0xFF0AF3F3),
            onSecondary: Colors.teal,
            error: Colors.redAccent,
            onError: Colors.greenAccent,
            background: Color(0xFFEEEEFF),
            onBackground: Color(0xFF01000F),
            surface: Colors.white,
            onSurface: Colors.black),
        textTheme: GoogleFonts.rubikTextTheme(textTheme).copyWith(
          labelSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.6)),
          labelMedium: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          labelLarge: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          bodySmall: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          bodyMedium: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          titleSmall: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0066FF),
          ),
          titleLarge: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Color(0xFFFB5A00),
            onPrimary: Color(0xFF0066FF),
            secondary: Colors.teal,
            onSecondary: Color(0xFF0AF3F3),
            error: Colors.redAccent,
            onError: Colors.greenAccent,
            background: Color(0xFF01000F),
            onBackground: Color(0xFFEEEEFF),
            surface: Colors.black,
            onSurface: Colors.white),
        textTheme: GoogleFonts.rubikTextTheme(textTheme).copyWith(
          labelSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.6)),
          bodySmall: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          bodyMedium: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          titleMedium: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0066FF),
          ),
        ),
      ),
      home: const InitialScreen(),
    );
  }
}
