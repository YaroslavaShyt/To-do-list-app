import 'package:flutter/material.dart';
import 'package:taskapp/blocs/bloc_exports.dart';
import 'package:taskapp/constants/colors.dart';
import 'package:taskapp/screens/calendar/calendar_widgets/calendar.dart';
import 'package:taskapp/services/calendar_date.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskapp/services/date_getter.dart';

class CalendarScreen extends StatefulWidget {
  static const id = "calendar_screen";

  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _today = Date.now;
  List tasks = [];

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _today = day;
    });
    context
        .read<TasksBloc>()
        .add(GetTodayTasks(date: Date.getDateDayMonthYear(_today)));
  }

  @override
  void initState() {
    super.initState();
    context
        .read<TasksBloc>()
        .add(GetTodayTasks(date: Date.getDateDayMonthYear(_today)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Calendar(onDaySelected: _onDaySelected, today: _today),
            Expanded(
                child: ListView.builder(
                    itemCount: state.pendingTasks.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text(
                            state.pendingTasks[index].title,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                              decoration: state.pendingTasks[index].isDone!
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        )))
          ],
        ),
      );
    });
  }
}
