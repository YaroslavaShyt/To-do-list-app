import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final Function(DateTime day, DateTime focusedDay) onDaySelected;
  final DateTime today;
  const Calendar({super.key, required this.onDaySelected, required this.today});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 43,
      headerStyle:
          const HeaderStyle(titleCentered: true, formatButtonVisible: false),
      selectedDayPredicate: (day) => isSameDay(day, today),
      availableGestures: AvailableGestures.all,
      focusedDay: today,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2050, 3, 14),
      onDaySelected: onDaySelected,
    );
  }
}
