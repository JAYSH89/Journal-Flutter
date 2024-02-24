extension DateTimeExtension on DateTime {
  String get dmy {
    final leadingZeroDay = day.toString().padLeft(2, "0");
    final leadingZeroMonth = month.toString().padLeft(2, "0");
    return "$leadingZeroDay-$leadingZeroMonth-$year";
  }
}
