import 'package:flutter/material.dart';

final MaterialColor primarySwatch = MaterialColor(
  0xFF000F62,
  <int, Color>{
    50: CC.primary.withOpacity(1),
    100: CC.primary.withOpacity(1),
    200: CC.primary.withOpacity(1),
    300: CC.primary.withOpacity(1),
    400: CC.primary.withOpacity(1),
    500: CC.primary.withOpacity(1),
    600: CC.primary.withOpacity(1),
    700: CC.primary.withOpacity(1),
    800: CC.primary.withOpacity(1),
    900: CC.primary.withOpacity(1),
  },
);

class CC {
  static const white = Colors.white;
  static const primary = Color(0xFF000F62);
  static const primaryDark = Color(0xFF1565C0);
  static const primaryLight = Color(0xFF1E88E5);
  static const accent = Color(0xFFFF4081);
  static const accentDark = Color(0xFFF50057);
  static const accentLight = Color(0xFFFF80AB);
  static const buttonGrey = Color(0xFF424242);
  static const grey1 = Color(0xFF777777);

  static const black = Colors.black;
  static const disabled = Color(0xFFd3d3d3);
}
