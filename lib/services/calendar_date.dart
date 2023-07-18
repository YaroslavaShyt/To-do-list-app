import 'package:intl/intl.dart';

class CalendarDate {
  static Map<String, int> validMonths = {};
  static List<String> monthDates = [];
  static int currentMonth = DateTime.now().month;
  static int currentYear = DateTime.now().year;
  static List<Map<String, List<dynamic>>> calendarDates = [];

  static void getValidMonths() {
    validMonths.clear();
    for (var i = 1; i <= 12; i++) {
      i >= currentMonth
          ? validMonths[DateFormat.MMMM().format(DateTime(currentYear, i))] = i
          : null;
    }
  }

  static void getMonthDates({required int month, required int year}) {
    monthDates.clear();
    DateTime startDate = DateTime(year, month, 1);
    DateTime endDate =
    DateTime(year, month + 1, 2).subtract(const Duration(days: 1));
    for (DateTime date = startDate;
    date.isBefore(endDate);
    date = date.add(const Duration(days: 1))) {
      monthDates.add(DateFormat('dd').format(date));
    }
  }

  static List<Map<String, List<dynamic>>> loadCalendarDates() {
    calendarDates.clear();
    getValidMonths();
    for (var i in validMonths.keys) {
      var value = {i: []};
      getMonthDates(month: validMonths[i]!, year: currentYear);
      for (var j in monthDates) {
        value[i]?.add(j);
      }
      calendarDates.add(value);
    }
    return calendarDates;
  }
}