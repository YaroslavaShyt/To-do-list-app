import 'package:flutter/material.dart';
import 'package:taskapp/constants/colors.dart';
import 'package:taskapp/constants/font_styling.dart';
import 'package:taskapp/models/date_model.dart';
import 'package:taskapp/screens/pending_screen/widgets/category_floating_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taskapp/services/date_getter.dart';
import 'package:taskapp/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayCard extends StatelessWidget {
  final Color cardColor;
  final DateModel date;
  const DayCard({super.key, required this.cardColor, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: cardColor, borderRadius: BorderRadius.circular(20.0)),
      width: 350,
      child: Stack(
        children: [
          Positioned(
              bottom: 90,
              right: -50,
              child: Image.asset(
                  height: 200,
                  width: 200,
                  cardColor == AppColors.lightGreen
                      ? 'assets/images/curves/curve_green.png'
                      : cardColor == AppColors.pink
                          ? 'assets/images/curves/curve_pink.png'
                          : 'assets/images/curves/curve_yellow.png')),
          Positioned(
              top: 30,
              left: 30,
              child: SizedBox(
                width: 200,
                child: Wrap(children: [
                  Text(
                    '${date.dayName}, ${date.date}\n${date.monthName}',
                    style: cardColor == AppColors.honeyYellow ||
                            cardColor == AppColors.lightGreen
                        ? FontStyling.nunitoThinMediumBlack
                        : FontStyling.nunitoThinMediumWhite,
                  )
                ]),
              )),
          Positioned(
            bottom: 20,
            right: 20,
            child: SizedBox(
                height: 40,
                width: 40,
                child: CategoryFloatingButton(
                    callback: () {
                      String text =
                          'Tasks on ${Date.dateFormat.format(Date.now)}\n\n';
                      List tasks = context.read<TasksBloc>().state.pendingTasks;
                      for (var i in tasks) {
                        text += '${i.title}\n';
                      }
                      Share.share(text);
                    },
                    icon: Icons.share,
                    cardColor: cardColor)),
          )
        ],
      ),
    );
  }
}
