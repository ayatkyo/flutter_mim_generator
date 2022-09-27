import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xff28a979);
  static const Color secondary = Color(0xFF7B736E);
  static const Color background = Color(0xFFfefefe);
  static const Color backgroundDark = Color(0xFF192d35);
  static const Color textPrimary = Color(0xFF4B4542);
  static const Color textSecondary = Color(0xFF7B736E);
}

class AppBorderRadius {
  static BorderRadius get normal => BorderRadius.circular(8);
}

class AppTextStyles {
  static TextStyle get formLabel => AppFonts.secondary(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: const Color(0xff665E5A),
      );
}

class AppFonts {
  static const primary = GoogleFonts.poppins;
  static const secondary = GoogleFonts.inter;
}

const AppBounceScrollPhysic = AlwaysScrollableScrollPhysics(
  parent: BouncingScrollPhysics(),
);
