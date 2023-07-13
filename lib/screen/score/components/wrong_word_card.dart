import 'package:flutter/material.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/config/theme.dart';

class WrongWordCard extends StatelessWidget {
  const WrongWordCard({
    super.key,
    this.textWidth,
    required this.word,
    required this.mean,
    required this.onTap,
  });

  final double? textWidth;
  final String word;
  final String mean;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.scaffoldBackground.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: textWidth,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    word,
                    style: const TextStyle(
                      color: AppColors.scaffoldBackground,
                      fontFamily: AppFonts.japaneseFont,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                )),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                width: textWidth ?? size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    mean.contains('@')
                        ? '${mean.split('@')[0]}, ${mean.split('@')[1]}'
                        : mean,
                    style: const TextStyle(
                      color: AppColors.scaffoldBackground,
                      fontFamily: AppFonts.japaneseFont,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
