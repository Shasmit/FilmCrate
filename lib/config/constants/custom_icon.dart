import 'package:flutter/widgets.dart';

class CustomIcon {
  CustomIcon._();

  static const _kFontFam = 'Imdb';
  static const String? _kFontPkg = null;

  static const _kFontFam1 = 'Heart';
  static const String? _kFontPkg1 = null;

  static const _kFontFam2 = 'Heart1';
  static const String? _kFontPkg2 = null;

  static const IconData imdb =
      IconData(0xf2d8, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData heart =
      IconData(0xe800, fontFamily: _kFontFam1, fontPackage: _kFontPkg1);
  static const IconData heart_1 =
      IconData(0xf004, fontFamily: _kFontFam2, fontPackage: _kFontPkg2);
}
