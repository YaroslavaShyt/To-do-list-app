import 'package:flutter/material.dart';
import 'package:taskapp/screens/pending_screen/widgets/carousel/indicator_dot.dart';

class DotsIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final double dotSize;
  final double activeDotSize;
  final Color dotColor;
  final Color activeDotColor;

  const DotsIndicator({super.key,
    required this.itemCount,
    required this.currentIndex,
    this.dotSize = 8.0,
    this.activeDotSize = 12.0,
    this.dotColor = Colors.grey,
    this.activeDotColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        double size = (index == currentIndex) ? activeDotSize : dotSize;
        Color color = (index == currentIndex) ? activeDotColor : dotColor;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Circle(checked: index == currentIndex ? true : false),
        );
      }),
    );
  }
}
