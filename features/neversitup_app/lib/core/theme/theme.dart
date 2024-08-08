import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  iconButtonTheme: const IconButtonThemeData(),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter().copyWith(
      fontSize: 50.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleLarge: GoogleFonts.inter().copyWith(
      fontSize: mDeviceSize.width * 24.0 / mDeviceSize.width,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.inter().copyWith(
      fontSize: mDeviceSize.width * 18.0 / mDeviceSize.width,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: GoogleFonts.inter().copyWith(
      fontSize: mDeviceSize.width * 16.0 / mDeviceSize.width,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: GoogleFonts.inter().copyWith(
      fontSize: mDeviceSize.width * 14.0 / mDeviceSize.width,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.inter().copyWith(
      fontSize: mDeviceSize.width * 12.0 / mDeviceSize.width,
      color: Colors.black,
    ),
    bodySmall: GoogleFonts.inter().copyWith(
      fontSize: mDeviceSize.width * 9.0 / mDeviceSize.width,
      color: Colors.black,
    ),
  ),
);
