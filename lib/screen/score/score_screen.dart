import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jonggack_toeic/common/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_toeic/common/common.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/screen/jlpt_and_kangi/jlpt/jlpt_test/controller/jlpt_test_controller.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/screen/score/components/wrong_word_card.dart';

import '../../common/widget/exit_test_button.dart';
import '../my_voca/controller/my_voca_controller.dart';
import '../my_voca/my_voca_sceen.dart';

const SCORE_PATH = '/score';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    JlptTestController qnController = Get.find<JlptTestController>();

    Future.delayed(const Duration(milliseconds: 1000), () async {
      Random randDom = Random();

      int randomNumber = randDom.nextInt(20) + 20; // is >=20 and40

      if (qnController.userController.clickUnKnownButtonCount > randomNumber) {
        bool result = await askToWatchMovieAndGetHeart(
          title: const Text('저장한 단어를 복습하러 가요!'),
          content: const Text(
            '자주 틀리는 단어장에 가서 단어들을 복습 하시겠습니까?',
            style: TextStyle(color: AppColors.scaffoldBackground),
          ),
        );
        if (result) {
          qnController.userController.clickUnKnownButtonCount = 0;
          qnController.isMyWordTest ? getBacks(2) : getBacks(3);
          Get.toNamed(
            MY_VOCA_PATH,
            arguments: {
              MY_VOCA_TYPE: MyVocaEnum.WRONG_WORD,
            },
          );
        } else {
          randomNumber = randDom.nextInt(2) + 2;
          qnController.userController.clickUnKnownButtonCount =
              (qnController.userController.clickUnKnownButtonCount /
                      randomNumber)
                  .floor();
        }
      }
    });

    return Scaffold(
      appBar: _appBar(qnController),
      body: _body(qnController, size),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }

  Stack _body(JlptTestController qnController, Size size) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (qnController.wrongQuestions.isEmpty)
                      const SizedBox(width: double.infinity)
                    else
                      ...List.generate(qnController.wrongQuestions.length,
                          (index) {
                        String word = qnController.wrongWord(index);
                        String mean = qnController.wrongMean(index);
                        return WrongWordCard(
                          onTap: () => qnController.manualSaveToMyVoca(index),
                          textWidth: size.width / 2 - 20,
                          word: word,
                          mean: mean,
                        );
                      }),
                    const SizedBox(height: 20),
                    const ExitTestButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  AppBar _appBar(JlptTestController qnController) {
    return AppBar(
      title: Text(
        "점수 ${qnController.scoreResult}",
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B94BC)),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () => qnController.isMyWordTest ? getBacks(2) : getBacks(3),
      ),
    );
  }
}
