import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_tomatos/design/tomato_colors.dart';

class TomatoTheme{
  static ThemeData get mainTheme{
    return ThemeData(
        primaryColorDark: TomatoColors.tomatoDarkRed,
        primaryColor: TomatoColors.tomatoLightRed,
        scaffoldBackgroundColor: TomatoColors.tomatoWhite,
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            buttonColor: TomatoColors.tomatoBlack,
            textTheme: ButtonTextTheme.primary),
        appBarTheme: AppBarTheme(brightness: Brightness.dark)
    );
  }
}