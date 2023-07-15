import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';

import '../../config/colors.dart';
import 'package:get/get.dart';
import 'animated_circular_progressIndicator.dart';

class PartOfInformation extends StatelessWidget {
  const PartOfInformation({
    super.key,
    required this.edgeInsets,
    required this.text,
    this.currentProgressCount,
    this.totalProgressCount,
    this.goToSutdy,
  });
  final String text;
  final EdgeInsets edgeInsets;

  final int? currentProgressCount;
  final int? totalProgressCount;
  final Function()? goToSutdy;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: Container(
        margin: EdgeInsets.only(bottom: Dimentions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: Dimentions.width14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: Dimentions.height45,
                  width: Dimentions.width165,
                  child: ElevatedButton(
                    onPressed: goToSutdy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteGrey,
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimentions.width16),
                    ),
                    child: Text(
                      '학습 하기',
                      style: TextStyle(
                        fontSize: Dimentions.height14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '진행률',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimentions.height11,
                          ),
                        ),
                        Row(
                          children: [
                            TweenAnimationBuilder(
                              tween: Tween<double>(
                                  begin: 0, end: currentProgressCount! / 100),
                              duration: const Duration(milliseconds: 1500),
                              builder: (context, value, child) {
                                return Text(
                                  (value * 100).ceil().toString(),
                                  style: TextStyle(
                                    fontSize: Dimentions.height14,
                                  ),
                                );
                              },
                            ),
                            Text(
                              ' / ',
                              style: TextStyle(
                                fontSize: Dimentions.height14,
                              ),
                            ),
                            Text(
                              totalProgressCount.toString(),
                              style: TextStyle(
                                fontSize: Dimentions.height14,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: Dimentions.width15),
                    SizedBox(
                      height: Dimentions.height60,
                      width: Dimentions.height60,
                      child: AnimatedCircularProgressIndicator(
                        currentProgressCount: currentProgressCount,
                        totalProgressCount: totalProgressCount,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
