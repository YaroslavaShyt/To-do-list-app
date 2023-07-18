import 'package:intl/intl.dart';
import 'package:taskapp/models/date_model.dart';

class Date {
  static DateTime now = DateTime.now();
  static int currentWeekday = DateTime.now().weekday;
  static DateTime startOfWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  static DateFormat dateFormat = DateFormat('dd.MM.yyyy');
  static List<DateModel> weekDates =  [];

  static List<DateModel> getWeekDates() {
    weekDates = [];
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startOfWeek.add(Duration(days: i));
      String dayName = DateFormat.EEEE().format(currentDate);
      String fullDate = dateFormat.format(currentDate).toString();
      String date = DateFormat.d().format(currentDate); // День місяця
      String monthName = DateFormat.MMMM().format(currentDate); // Назва місяця (повна)
      String time = DateFormat.Hm().format(currentDate); // Час (години та хвилини)
    //  print('$currentDate, $dayName');
      weekDates.add(DateModel(
        fullDate: fullDate,
          dayName: dayName, date: date, monthName: monthName, time: time));
      print(fullDate);
    }

    return weekDates;
  }

  static String getDateDayMonthYear(DateTime date){
    return dateFormat.format(date).toString();
  }


}
