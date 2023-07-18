import 'package:flutter/material.dart';
import 'package:taskapp/constants/colors.dart';
import 'package:taskapp/services/date_getter.dart';
import '../screens/pending_screen/widgets/edit_task_screen.dart';
import 'popup_menu.dart';
import '../blocs/bloc_exports.dart';
import 'package:taskapp/models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? {
            ctx.read<TasksBloc>().add(DeleteTask(task: task)),
            ctx
                .read<TasksBloc>()
                .add(GetTodayTasks(date: Date.dateFormat.format(Date.now)))
          }
        : {
            ctx.read<TasksBloc>().add(RemoveTask(task: task)),
            ctx
                .read<TasksBloc>()
                .add(GetTodayTasks(date: Date.dateFormat.format(Date.now)))
          };
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: EditTaskScreen(
                  oldTask: task,
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: AppColors.lightPurple,
                  width: 1.0,
                ),
              )),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        Text(task.date),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Checkbox(
                activeColor: AppColors.darkGreen,
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                        context.read<TasksBloc>().add(GetTodayTasks(
                            date: Date.dateFormat.format(Date.now)));
                      }
                    : null,
              ),
              PopupMenu(
                  task: task,
                  cancelOrDeleteCallback: () =>
                      _removeOrDeleteTask(context, task),
                  likeOrDislikeCallback: () {
                    context
                        .read<TasksBloc>()
                        .add(MarkFavoriteOrUnfavoriteTask(task: task));
                    context.read<TasksBloc>().add(
                        GetTodayTasks(date: Date.dateFormat.format(Date.now)));
                  },
                  editTaskCallback: () {
                    Navigator.of(context).pop();
                    _editTask(context);
                  },
                  restoreTaskCallback: () {
                    context.read<TasksBloc>().add(RestoreTask(task: task));
                    context.read<TasksBloc>().add(
                        GetTodayTasks(date: Date.dateFormat.format(Date.now)));
                  }),
            ],
          ),
        ],
      ),
    );
  }
}




// ListTile(
//       title: Text(
//         task.title,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           decoration: task.isDone! ? TextDecoration.lineThrough : null,
//         ),
//       ),
//       trailing: Checkbox(
//         value: task.isDone,
//         onChanged: task.isDeleted == false
//             ? (value) {
//                 context.read<TasksBloc>().add(UpdateTask(task: task));
//               }
//             : null,
//       ),
//       onLongPress: () => _removeOrDeleteTask(context, task),
//     );