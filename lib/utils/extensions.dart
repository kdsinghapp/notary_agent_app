import '../import.dart';

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  static DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}

extension StringUtils on String {
  String trimLeftChar(String characters) {
    String from = this;
    if (from.isEmpty || characters.isEmpty || characters.length > from.length) return from;

    while (from.startsWith(characters)) {
      from = from.substring(characters.length);
    }
    return from;
  }

  String trimRightChar(String characters) {
    String from = this;
    if (from.isEmpty || characters.isEmpty || characters.length > from.length) return from;

    while (from.endsWith(characters)) {
      from = from.substring(0, from.length - characters.length);
    }
    return from;
  }

  String trimChar(String characters) {
    String from = this;
    return from.trimLeftChar(characters).trimRightChar(characters);
  }
}

extension Nav on BuildContext {
  Future<T?> navigate<T>(Widget Function() page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (context) => page()));
  }

  Future<T?> replace<T>(Widget Function() page) {
    return Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (context) => page()));
  }

  void pop<T>([T? result]) {
    return Navigator.of(this).pop();
  }
}
