import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/auth_screen.dart';

class EcoDayApp extends StatelessWidget {
  const EcoDayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoDay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          AppTheme.lightTheme.textTheme,
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
