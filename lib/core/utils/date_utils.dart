import 'package:intl/intl.dart';

class DateUtilsX {
  static List<DateTime> getWeekDates(DateTime selectedDate) {
    final start = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    return List.generate(7, (i) => start.add(Duration(days: i)));
  }

  static String formatDay(DateTime date) => DateFormat('d').format(date); // 13
  static String formatWeekday(DateTime date) => DateFormat('EEE').format(date); // Thu
}
