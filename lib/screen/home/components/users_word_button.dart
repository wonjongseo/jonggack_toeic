import 'package:flutter/material.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';

import '../../../config/colors.dart';

/*
 * 나만의 단어장 혹은 자주 틀리는 단어.
 */
class UserWordButton extends StatelessWidget {
  const UserWordButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textKey,
  });

  final Function() onTap;
  final String text;
  final Key? textKey;

  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteGrey,
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(1, 1),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              key: textKey,
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontSize: Dimentions.width14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
