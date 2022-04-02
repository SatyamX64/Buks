import 'package:flutter/material.dart' show Colors, Color;
import 'package:google_fonts/google_fonts.dart';

class FontUtils {
  static final textStyle = GoogleFonts.rowdies()
      .copyWith(color: const Color(0xFF000000), fontSize: 18);
  static final heading =
      GoogleFonts.ruslanDisplay().copyWith(color: Colors.black, fontSize: 24);
}
