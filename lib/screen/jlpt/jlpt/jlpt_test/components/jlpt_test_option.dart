import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/jlpt_test/controller/jlpt_test_controller.dart';
import 'package:jonggack_toeic/model/word.dart';

import '../../../../../config/colors.dart';

class JlptTestOption extends StatelessWidget {
  const JlptTestOption(
      {Key? key, required this.test, required this.index, required this.press})
      : super(key: key);

  final Word test;
  final int index;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<JlptTestController>(
      init: JlptTestController(),
      builder: (qnController) {
        String getString() {
          if (qnController.textEditingController != null) {
            if (!qnController.isSubmittedSpelling) {
              return '???';
            }
          }

          if (qnController.isAnswered) {
            return test.mean;
          }

          return test.mean;
        }

        Color getTheRightColor() {
          if (qnController.isAnswered) {
            if (index == qnController.correctAns) {
              return const Color(0xFF6AC259);
            } else if (index == qnController.selectedAns &&
                index != qnController.correctAns) {
              return const Color(0xFFE92E30);
            }
          }
          return AppColors.scaffoldBackground.withOpacity(0.5);
        }

        IconData getTheRightIcon() {
          return getTheRightColor() == const Color(0xFFE92E30)
              ? Icons.close
              : Icons.done;
        }

        if (qnController.textEditingController == null) {
          return qnController.isWrong
              ? optionCard(getTheRightColor, getTheRightIcon, getString)
              : InkWell(
                  onTap: press,
                  child:
                      optionCard(getTheRightColor, getTheRightIcon, getString),
                );
        }
        return qnController.isWrong
            ? optionCard(getTheRightColor, getTheRightIcon, getString)
            : InkWell(
                onTap: qnController.textEditingController!.text.isNotEmpty
                    ? press
                    : () => qnController.requestFocus(),
                child: optionCard(getTheRightColor, getTheRightIcon, getString),
              );
      },
    );
  }

  Container optionCard(Color Function() getTheRightColor,
      IconData Function() getTheRightIcon, String Function() getString) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${index + 1}. ${getString()}',
              style: TextStyle(color: getTheRightColor(), fontSize: 16),
            ),
          ),
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
                color: getTheRightColor() ==
                        AppColors.scaffoldBackground.withOpacity(0.5)
                    ? Colors.transparent
                    : getTheRightColor(),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: getTheRightColor())),
            child: getTheRightColor() ==
                    AppColors.scaffoldBackground.withOpacity(0.5)
                ? null
                : Icon(
                    getTheRightIcon(),
                    size: 16,
                  ),
          ),
        ],
      ),
    );
  }
}
