import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/widget/heart_count.dart';
import 'package:jonggack_toeic/screen/grammar/controller/grammar_controller.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';
import 'package:jonggack_toeic/screen/grammar/grammar_test/grammar_test_screen.dart';
import 'package:jonggack_toeic/model/grammar_step.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jonggack_toeic/screen/grammar/components/grammar_card.dart';

import '../../common/admob/banner_ad/global_banner_admob.dart';
import '../../common/common.dart';
import '../../config/colors.dart';
import '../../tts_controller.dart';

const String GRAMMER_STUDY_PATH = '/grammar';

class GrammerStudyScreen extends StatefulWidget {
  const GrammerStudyScreen({super.key});

  @override
  State<GrammerStudyScreen> createState() => _GrammerStudyScreenState();
}

class _GrammerStudyScreenState extends State<GrammerStudyScreen> {
  GrammarController grammarController = Get.find<GrammarController>();
  UserController userController = Get.find<UserController>();
  TtsController ttsController = Get.put(TtsController());

  late GrammarStep grammarStep;
  bool isEnglish = true;

  @override
  void initState() {
    super.initState();
    grammarStep = grammarController.getGrammarStep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      appBar: _appBar(),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('N${grammarStep.level}문법 - 챕터${grammarStep.step + 1} '),
      actions: [
        const HeartCount(),
        if (grammarController.grammers.length >= 4)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () async {
                  // TODO
                  bool result = await askToWatchMovieAndGetHeart(
                    title: const Text('점수를 기록하고 하트를 채워요!'),
                    content: const Text(
                      '테스트 페이지로 넘어가시겠습니까?',
                      style: TextStyle(color: AppColors.scaffoldBackground),
                    ),
                  );
                  if (result) {
                    Get.toNamed(
                      GRAMMAR_TEST_SCREEN,
                      arguments: {
                        'grammar': grammarStep.grammars,
                      },
                    );
                  }
                },
                child: const Text(
                  '시험',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteGrey,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: GetBuilder<TtsController>(builder: (ttsController) {
        return Column(
          children: [
            if (ttsController.isPlaying)
              const SpinKitWave(
                size: 30,
                color: Colors.white,
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    grammarStep.grammars.length,
                    (index) {
                      return GrammarCard(
                        grammar: grammarStep.grammars[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
