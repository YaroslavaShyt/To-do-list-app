import 'package:flutter/material.dart';
import 'package:taskapp/constants/colors.dart';

class CategoryFloatingButton extends StatelessWidget {
  final Color cardColor;
  final IconData icon;
  final VoidCallback callback;
  const CategoryFloatingButton({super.key, required this.cardColor, required this.icon, required this.callback});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: callback,
      backgroundColor: cardColor == AppColors.honeyYellow
          ? AppColors.lightYellow
          : cardColor == AppColors.pink
          ? AppColors.lightPink
          : AppColors.darkGreen,
      elevation: 0,
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
