import 'package:flutter/material.dart';
import 'package:taskapp/blocs/bloc_exports.dart';
import 'package:taskapp/constants/colors.dart';
import 'package:taskapp/constants/font_styling.dart';
import 'package:taskapp/models/date_model.dart';
import 'package:taskapp/screens/calendar/calendar_screen.dart';
import 'package:taskapp/services/calendar_date.dart';
import 'package:taskapp/services/date_getter.dart';
import '../completed_tasks_screen/completed_tasks_screen.dart';
import '../favorite_tasks_screen/favorite_tasks_screen.dart';
import 'widgets/my_drawer.dart';
import '../pending_screen/pending_screen.dart';

import '../pending_screen/widgets/add_task_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const PendingTasksScreen(), 'title': 'Pending Tasks'},
    {'pageName': const CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {
      'pageName': const CalendarScreen(),
      'title': 'Calendar ${CalendarDate.currentYear}'
    },
    // {'pageName': const FavoriteTasksScreen(), 'title': 'Favorite Tasks'},
  ];

  var _selectedPageIndex = 0;

  @override
  void initState() {
    // print(Date.weekDates[Date.currentWeekday]);
    context
        .read<TasksBloc>()
        .add(GetTodayTasks(date: Date.dateFormat.format(Date.now)));
    super.initState();
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageDetails[_selectedPageIndex]['title'],
          style: FontStyling.nunitoRegularMedium,
        ),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedPageIndex,
          onTap: (index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          selectedItemColor: AppColors.black,
          unselectedItemColor: AppColors.lightPurple,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.incomplete_circle_sharp),
                label: 'Pending Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.done), label: 'Completed Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined), label: 'Calendar'),
          ],
        ),
      ),
    );
  }
}
