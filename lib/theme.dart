import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 30.0;

Color primaryColor = Color(0xFF27AE60);
Color primaryDarkColor = Color(0xFF117660);
Color secondaryColor = Color(0xFF2CB17F);
Color primaryTextColor = Color(0xFF29313E);
Color greenTextColor = Color(0xFF09323B);
Color redTextColor = Color(0xFFEB5757);
Color secondaryTextColor = Color(0xFF728196);
Color hintTextColor = Color(0xFF728196).withOpacity(0.5);
Color backgorundColor = Color(0xFFF6F6F6);
Color backgorundFieldColor = Color(0xFFEAEAEA);
Color whiteColor = Color(0xFFFFFFFF);

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: primaryTextColor,
);

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: secondaryTextColor,
);

TextStyle darkGreenTextStyle = GoogleFonts.poppins(
  color: greenTextColor,
);

TextStyle greenTextStyle = GoogleFonts.poppins(
  color: primaryColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: whiteColor,
);
TextStyle hintTextStyle = GoogleFonts.poppins(
  color: hintTextColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
