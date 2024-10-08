// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'initial_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'PMSControl',
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
          labelSmall: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          labelMedium: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          displaySmall: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          labelLarge: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          headlineMedium: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
          titleMedium: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          bodyLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          bodySmall: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          headlineLarge: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          bodyMedium: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          titleSmall: const TextStyle(
            fontSize: 24,
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
      home: const InitialScreen(),
    );
  }
}
