import 'package:flutter/material.dart';
import 'package:jonggack_toeic/config/colors.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.07,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: AppColors.whiteGrey),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
