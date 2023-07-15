import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';
import 'package:jonggack_toeic/model/Question.dart';

import '../../../../../config/colors.dart';
import '../controller/jlpt_test_controller.dart';

class JlptTestTextFormField extends StatelessWidget {
  const JlptTestTextFormField({super.key, required this.question});
  final Question question;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<JlptTestController>(
      builder: (controller) {
        return TextFormField(
          autofocus: true,
          style: TextStyle(
            color: controller.getTheTextEditerBorderRightColor(isBorder: false),
          ),
          onChanged: (value) {
            controller.inputValue = value;
            controller.checkAns(question, 0);
          },
          focusNode: controller.focusNode,
          onFieldSubmitted: (value) {
            controller.onFieldSubmitted(value);
            controller.checkAns(question, 0);
            FocusScope.of(context).unfocus();
          },
          controller: controller.textEditingController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: controller.getTheTextEditerBorderRightColor(),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: controller.getTheTextEditerBorderRightColor(),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            label: Text(
              '스펠링',
              style: TextStyle(
                color: AppColors.scaffoldBackground.withOpacity(0.5),
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
