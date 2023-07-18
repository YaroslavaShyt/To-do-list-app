import 'package:flutter/material.dart';
import 'package:taskapp/constants/colors.dart';

class Circle extends StatefulWidget {
  final bool checked;
  const Circle({super.key, required this.checked,});
  @override
  CircleState createState() => CircleState();
}

class CircleState extends State<Circle> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      width: widget.checked ? 10 : 5,
      height: widget.checked ?  10 : 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.checked ? AppColors.black : AppColors.lightGrey,
      ),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: const SizedBox(height: 100, width: 100,),
    );
  }

}