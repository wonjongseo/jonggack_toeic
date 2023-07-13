import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/config/theme.dart';
import 'package:jonggack_toeic/screen/jlpt_and_kangi/jlpt/jlpt_test/controller/jlpt_test_controller.dart';
import 'package:jonggack_toeic/model/Question.dart';

import 'jlpt_test_option.dart';
import 'jlpt_test_text_form_field.dart';

class JlptTestCard extends StatelessWidget {
  JlptTestCard({super.key, required this.question});

  final Question question;
  final JlptTestController controller = Get.find<JlptTestController>();

  @override
  Widget build(BuildContext context) {
    String qustionWord = question.question.word;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimentions.width20),
      padding: EdgeInsets.all(Dimentions.width20),
      decoration: BoxDecoration(
        color: AppColors.whiteGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimentions.width24),
          topRight: Radius.circular(Dimentions.width24),
        ),
      ),
      child: Column(
        children: [
          Text(
            qustionWord,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color(0xFF101010),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.japaneseFont,
                ),
          ),
          SizedBox(height: Dimentions.height40),
          if (controller.isSubjective)
            GetBuilder<JlptTestController>(builder: (qnController) {
              return Column(
                children: [
                  JlptTestTextFormField(question: question),
                  const SizedBox(height: 10),
                  if (qnController.isWrong)
                    Text(
                      '정답: ${qnController.correctQuestion.mean}',
                      style: TextStyle(color: Color(0xFFE92E30), fontSize: 16),
                    )
                  // if(qnController.isWrong)
                ],
              );
            })
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: List.generate(
                  question.options.length,
                  (index) => JlptTestOption(
                    test: question.options[index],
                    index: index,
                    press: () {
                      controller.checkAns(question, index);
                    },
                  ),
                )),
              ),
            ),
        ],
      ),
    );
  }
}
