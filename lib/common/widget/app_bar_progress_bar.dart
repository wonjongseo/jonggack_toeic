import 'package:flutter/cupertino.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../../config/colors.dart';

class AppBarProgressBar extends StatelessWidget {
  const AppBarProgressBar({
    super.key,
    required this.currentValue,
    required this.size,
  });
  final Size size;
  final double currentValue;

  @override
  Widget build(BuildContext context) {
    return FAProgressBar(
      currentValue: currentValue,
      maxValue: 100,
      displayText: '%',
      size: size.width > 500 ? 35 : 25,
      formatValueFixed: 0,
      backgroundColor: AppColors.darkGrey,
      progressColor: AppColors.lightGreen,
      borderRadius: size.width > 500
          ? BorderRadius.circular(30)
          : BorderRadius.circular(12),
      displayTextStyle: TextStyle(
          color: const Color(0xFFFFFFFF), fontSize: size.width > 500 ? 18 : 14),
    );
  }
}
