import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/common.dart';
import 'package:jonggack_toeic/common/widget/app_bar_progress_bar.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/screen/grammar/grammar_test/controller/grammar_test_controller.dart';
import 'package:jonggack_toeic/screen/grammar/grammar_test/components/grammar_test_card.dart';
import 'package:jonggack_toeic/screen/grammar/components/score_and_message.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../tts_controller.dart';

const GRAMMAR_TEST_SCREEN = '/grammar_test';

// ignore: must_be_immutable
class GrammarTestScreen extends StatelessWidget {
  late GrammarTestController grammarTestController;
  GrammarTestScreen({super.key}) {
    grammarTestController = Get.put(GrammarTestController());

    grammarTestController.init(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.put(TtsController());
    // 점수 백분율

    return Scaffold(
      appBar: _appBar(size),
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: _body(size),
    );
  }

  Widget _body(Size size) {
    return GetBuilder<GrammarTestController>(builder: (controller) {
      double score = grammarTestController.getScore();
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Container(
              color: AppColors.whiteGrey,
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (controller.isSubmitted)
                        // 점수와 격려의 메세지 출력.
                        ScoreAndMessage(
                          score: score,
                          size: size,
                        )
                      else
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '빈칸에 맞는 답을 선택해 주세요.',
                              style: TextStyle(
                                color: AppColors.scaffoldBackground,
                              ),
                            ),
                          ),
                        ),
                      ...List.generate(
                        controller.questions.length,
                        (questionIndex) {
                          return GrammarTestCard(
                            size: size,
                            questionIndex: questionIndex,
                            question: controller.questions[questionIndex],
                            onChanged: (int selectedAnswerIndex) {
                              controller.clickButton(
                                  questionIndex, selectedAnswerIndex);
                            },
                            isCorrect: !controller.wrongQuetionIndexList
                                .contains(questionIndex),
                            isSubmitted: controller.isSubmitted,
                          );
                        },
                      ),
                      const SizedBox(height: 16)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: controller.isSubmitted
                ? Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                          ),
                          child: const Text(
                            '나가기',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            controller.saveScore();
                            getBacks(2);
                          },
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                            ),
                            onPressed: () {
                              controller.againTest();
                            },
                            child: const Text(
                              '다시 하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    ),
                  )
                : Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                      ),
                      onPressed: () => controller.submit(score),
                      child: const Text(
                        '제출',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      );
    });
  }

  AppBar _appBar(Size size) {
    // 진행률 백분율

    return AppBar(
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () async {
            if (grammarTestController.isSubmitted) {
              grammarTestController.saveScore();
              getBacks(2);
              return;
            }
            bool result = await reallyQuitText();
            if (result) {
              getBacks(2);
              return;
            }
          }),
      title:
          GetBuilder<GrammarTestController>(builder: (grammarTestController) {
        double currentProgressValue =
            grammarTestController.getCurrentProgressValue();
        return AppBarProgressBar(
          size: size,
          currentValue: currentProgressValue,
        );
      }),
    );
  }
}
