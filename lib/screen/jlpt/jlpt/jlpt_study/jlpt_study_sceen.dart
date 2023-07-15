import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/voca_card.dart';

import 'package:jonggack_toeic/screen/jlpt/jlpt/jlpt_study/jlpt_study_controller_temp.dart';

import '../../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../../common/common.dart';
import '../../../../common/widget/app_bar_progress_bar.dart';
import '../../../../common/widget/heart_count.dart';
import '../../../../config/colors.dart';
import '../../../../tts_controller.dart';
import '../../../setting/services/setting_controller.dart';
import 'components/jlpt_study_buttons_temp.dart';

final String JLPT_STUDY_PATH = '/jlpt_study';

// ignore: must_be_immutable
class JlptStudyScreen extends StatelessWidget {
  final JlptStudyControllerTemp wordController =
      Get.put(JlptStudyControllerTemp());

  SettingController settingController = Get.find<SettingController>();

  JlptStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<JlptStudyControllerTemp>(builder: (controller) {
      double currentValue = controller.getCurrentProgressValue();
      return Scaffold(
        appBar: _appBar(size, currentValue),
        body: _body(context, controller),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }

  Widget _body(BuildContext context, JlptStudyControllerTemp controller) {
    return GetBuilder<TtsController>(builder: (ttsController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    if (ttsController.isPlaying)
                      const Align(
                          alignment: Alignment.bottomCenter,
                          child: SpinKitWave(
                            size: 30,
                            color: Colors.white,
                          )),
                    if (!settingController.isAutoSave)
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: OutlinedButton(
                          onPressed: () {
                            wordController.saveCurrentWord();
                          },
                          child: const Text(
                            '저장',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteGrey,
                            ),
                          ),
                        ),
                      ),
                    if (wordController.words.length >= 4)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: OutlinedButton(
                          onPressed: () async {
                            bool result = await askToWatchMovieAndGetHeart(
                              title: const Text('점수를 기록하고 하트를 채워요!'),
                              content: const Text(
                                '테스트 페이지로 넘어가시겠습니까?',
                                style: TextStyle(
                                    color: AppColors.scaffoldBackground),
                              ),
                            );

                            if (result) {
                              bool result2 = await askToWatchMovieAndGetHeart(
                                  title: const Text('시험 유형을 선택해주세요.'),
                                  contentStrings: ['주관식', '객관식']);
                              wordController.goToTest(isSubjective: result2);
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
                  ],
                )),
          ),
          Expanded(
            flex: 7,
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.words.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: ttsController.disalbe
                      ? null
                      : () {
                          wordController.speakWord();
                        },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          // TODO,
                          // onTap: () {
                          // Get.to(() =>
                          //     ExapleWords(voca: controller.words[index]));
                          // },
                          child: Text(
                            controller.words[index].word,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontSize: 50,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(child: controller.mean()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: JlptStudyButtonsTemp(wordController: controller),
          ),
          const Spacer(flex: 1),
        ],
      );
    });
  }

  AppBar _appBar(Size size, double currentValue) {
    return AppBar(
      // actions: const [HeartCount()],
      leading: IconButton(
        onPressed: () async {
          wordController.jlptStep.unKnownWord = [];
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: AppBarProgressBar(size: size, currentValue: currentValue),
    );
  }
}
