import '../import.dart';

class AppTextTheme {
  final Color color;
  const AppTextTheme([this.color = CC.black]);

  TextStyle get heading1 => TextStyle(
        color: color,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      );
  TextStyle get heading2 => TextStyle(
        color: color,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );
  TextStyle get heading3 => TextStyle(
        color: color,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );
  TextStyle get heading4 => TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
  TextStyle get heading5 => TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
  TextStyle get heading6 => TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle get display1 => TextStyle(
        color: color,
        fontSize: 28,
        fontWeight: FontWeight.normal,
      );
  TextStyle get display2 => TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      );
  TextStyle get display3 => TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );
  TextStyle get display4 => TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
  TextStyle get display5 => TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );
  TextStyle get display6 => TextStyle(
        color: color,
        fontSize: 10,
        fontWeight: FontWeight.normal,
      );
  TextStyle get display7 => TextStyle(
        color: color,
        fontSize: 8,
        fontWeight: FontWeight.normal,
      );
}
