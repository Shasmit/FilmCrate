import 'package:filmcrate/config/constants/app_color_theme.dart';
import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();
  static getApplicationTheme(bool isDark) {
    return ThemeData(
      // colorScheme: ColorScheme.light(
      //   primary: AppColors.appbarColors,
      // ),
      colorScheme: isDark
          ? ColorScheme.dark(
              primary: AppColors.darkPrimaryColor,
            )
          : ColorScheme.light(
              primary: AppColors.appbarColors,
            ),
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: AppColors.appbarColors,
      appBarTheme: AppBarTheme(
        backgroundColor:
            isDark ? AppColors.darkPrimaryColor : AppColors.appbarColors,
        titleTextStyle: TextStyle(
          fontFamily: 'Dongle',
          color: AppColors.bodyColors,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
          fontSize: 38,
        ),
        toolbarHeight: 100.0,
      ),
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(AppColors.bodyColors),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(AppColors.bodyColors),
        ),
      ),
    );
  }
}
