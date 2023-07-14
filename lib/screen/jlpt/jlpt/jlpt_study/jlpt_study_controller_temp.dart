import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/admob/controller/ad_controller.dart';
import 'package:jonggack_toeic/common/common.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';
import 'package:jonggack_toeic/model/jlpt_step.dart';
import 'package:jonggack_toeic/model/my_word.dart';
import 'package:jonggack_toeic/screen/setting/services/setting_controller.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/jlpt_test/jlpt_test_screen.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/controller/jlpt_step_controller.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/jlpt_study/jlpt_study_sceen.dart';

import '../../../../config/colors.dart';
import '../../../../model/word.dart';
import '../../../../tts_controller.dart';
import '../../../user/controller/user_controller.dart';

class JlptStudyControllerTemp extends GetxController {
  JlptStepController jlptWordController = Get.find<JlptStepController>();
  AdController adController = Get.find<AdController>();
  SettingController settingController = Get.find<SettingController>();
  UserController userController = Get.find<UserController>();

  TtsController ttsController = Get.find<TtsController>();

  late PageController pageController;

  late JlptStep jlptStep;

  int currentIndex = 0;
  int correctCount = 0;

  List<Word> unKnownWords = [];
  List<Word> words = [];

  String transparentMean = '';
  String transparentYomikata = '';

  bool isShownMean = false;
  bool isShownYomikata = false;

  double getCurrentProgressValue() {
    return (currentIndex.toDouble() / words.length.toDouble()) * 100;
  }

  void saveCurrentWord() {
    userController.clickUnKnownButtonCount++;
    Word currentWord = words[currentIndex];
    MyWord.saveToMyVoca(currentWord);
  }

  void showMean() async {
    isShownMean = !isShownMean;
    update();
  }

  Future<void> speakMean() async {
    String mean = words[currentIndex].mean;
    String full = '';
    if (mean.contains('\n')) {
      List<String> aa = mean.split('\n');
      for (int i = 0; i < aa.length; i++) {
        full += '${aa[i]},';
      }
      await ttsController.speak(full, language: 'ko-KR');
    } else {
      await ttsController.speak(mean, language: 'ko-KR');
    }
  }

  Future<void> speakWord() async {
    await ttsController.speak(words[currentIndex].word);
  }

  @override
  void onClose() {
    pageController.dispose();
    ttsController.stop();
    super.onClose();
  }

  void onPageChanged(int page) {
    currentIndex = page;
  }

  Widget mean() {
    // 또,

    bool isMeanOverThree = words[currentIndex].mean.contains('\n3.');
    bool isMeanOverTwo = words[currentIndex].mean.contains('\n2.');

    double fontSize = Dimentions.height20;

    if (isMeanOverThree) {
      fontSize = Dimentions.height17;
      List<String> means = words[currentIndex].mean.split('\n');
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: List.generate(
                3,
                (index) => Text(
                  '${(index + 1).toString()}. ',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                3,
                (index) {
                  String mean = means[index].split('. ')[1];
                  return ZoomIn(
                    animate: isShownMean,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      mean,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w700,
                        color: isShownMean ? Colors.white : Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    } else if (isMeanOverTwo) {
      fontSize = Dimentions.height18;

      List<String> means = words[currentIndex].mean.split('\n');

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: List.generate(
                2,
                (index) => Text(
                  '${(index + 1).toString()}. ',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                2,
                (index) {
                  String mean = means[index].split('. ')[1];
                  return ZoomIn(
                    animate: isShownMean,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      mean,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w700,
                        color: isShownMean ? Colors.white : Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    }
    String mean = words[currentIndex].mean;

    return ZoomIn(
      animate: isShownMean,
      duration: const Duration(milliseconds: 300),
      child: Text(
        mean,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: isShownMean ? Colors.white : Colors.transparent,
        ),
      ),
    );
  }

  bool isAginText = false;

  @override
  void onInit() {
    super.onInit();

    // ttsController = Get.put(TtsController());
    pageController = PageController();
    jlptStep = jlptWordController.getJlptStep();

    if (jlptStep.unKnownWord.isNotEmpty) {
      isAginText = true;
      words = jlptStep.unKnownWord;
    } else {
      words = jlptStep.words;
    }
    if (settingController.isEnabledEnglishSound) {
      ttsController.speak(words[correctCount].word);
    }
  }

  Future<void> nextWord(bool isWordKnwon) async {
    isShownMean = false;
    isShownYomikata = false;

    Word currentWord = words[currentIndex];

    // [알아요] 버튼 클릭 시
    if (isWordKnwon) {
      correctCount++;
    }
    // [몰라요] 버튼 클릭 시
    else {
      Get.closeCurrentSnackbar();
      unKnownWords.add(currentWord);

      if (settingController.isAutoSave) {
        saveCurrentWord();
      }
    }

    currentIndex++;
    if (settingController.isEnabledEnglishSound) {
      ttsController.speak(words[currentIndex].word);
    }
    // 단어 학습 중. (남아 있는 단어 존재)
    if (currentIndex < words.length) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
    // 단어 학습 완료. (남아 있는 단어 없음)
    else {
      // 전부 다 [알아요] 버튼을 눌렀는 지
      if (unKnownWords.isEmpty) {
        jlptStep.unKnownWord = []; // 남아 있을 모르는 단어 삭제.
        bool result = await askToWatchMovieAndGetHeart(
          title: const Text('점수를 기록하고 하트를 채워요!'),
          content: const Text(
            '테스트 페이지로 넘어가시겠습니까?',
            style: TextStyle(color: AppColors.scaffoldBackground),
          ),
        );
        if (result) {
          bool result2 = await askToWatchMovieAndGetHeart(
              title: const Text('시험 유형을 선택해주세요.'),
              contentStrings: ['주관식', '객관식']);
          await goToTest(isSubjective: result2);
          return;
        } else {
          Get.back();
          return;
        }
      }

      // [몰라요] 버튼을 누른 적이 있는지
      else {
        int unKnownWordLength = unKnownWords.length > words.length
            ? words.length
            : unKnownWords.length;

        bool result = await askToWatchMovieAndGetHeart(
          title: Text('$unKnownWordLength개가 남아 있습니다.'),
          content: const Text(
            '모르는 단어를 다시 보시겠습니까?',
            style: TextStyle(color: AppColors.scaffoldBackground),
          ),
        );

        // 몰라요 단어 다시 학습.
        if (result) {
          unKnownWords.shuffle();

          currentIndex = 0; // 화면 에러 방지
          jlptStep.unKnownWord = unKnownWords;
          Get.offNamed(
            JLPT_STUDY_PATH,
            preventDuplicates: false,
          );
        } else {
          Get.closeAllSnackbars();
          jlptStep.unKnownWord = [];
          Get.back();
          return;
        }
      }
    }
    update();

    return;
  }

  Future<void> goToTest({bool isSubjective = false}) async {
    // 테스트를 본 적이 있으면.
    if (jlptStep.wrongQestion != null && jlptStep.scores != 0) {
      bool result = await askToWatchMovieAndGetHeart(
        title: const Text('과거에 테스트에서 틀린 문제들이 있습니다.'),
        content: const Text(
          '틀린 문제를 기준으로 다시 보시겠습니까 ?',
          style: TextStyle(
            color: AppColors.scaffoldBackground,
          ),
        ),
      );
      if (result) {
        // 과거에 틀린 문제로만 테스트 보기.
        Get.toNamed(
          JLPT_TEST_PATH,
          arguments: {
            CONTINUTE_JLPT_TEST: jlptStep.wrongQestion,
            'isSubjective': isSubjective,
          },
        );
      }
    }

    // 모든 문제로 테스트 보기.
    Get.toNamed(
      JLPT_TEST_PATH,
      arguments: {
        JLPT_TEST: jlptStep.words,
        'isSubjective': isSubjective,
      },
    );
  }
}
