import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';
import 'package:jonggack_toeic/tts_controller.dart';

import '../common/app_constant.dart';
import '../model/word.dart';
import 'jlpt/jlpt/controller/jlpt_step_controller.dart';

class ListenController extends GetxController {
  List<Word> words = [];
  JlptStepController jlptWordController = Get.find<JlptStepController>();

  final String chapter;

  ListenController({required this.chapter});

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    words = jlptWordController.jlptStepRepositroy
        .correctAllStepData(jlptWordController.level, chapter);
    // update();
  }

  UserController userController = Get.find<UserController>();
  TtsController ttsController = Get.find<TtsController>();
  // TtsController ttsController = Get.put(TtsController());

  void changeVolumn(double newValue) {
    userController.updateSoundValues(SOUND_OPTIONS.VOLUMN, newValue);

    update();
  }

  void changePitch(double newPitch) {
    userController.updateSoundValues(SOUND_OPTIONS.PITCH, newPitch);
    update();
  }

  void changeRate(double newRate) {
    userController.updateSoundValues(SOUND_OPTIONS.RATE, newRate);

    update();
  }

  int currentPageIndex = 0;

  bool isAutoPlay = false;

  void onPageChange(int value) {
    currentPageIndex = value;
    if (!userController.isUserPremieum() && jlptWordController.level == '1') {
      // /AppConstant.MINIMUM_STEP_COUNT * AppConstant.RESTRICT_SUB_STEP_INDEX

      int limitedIndex = AppConstant.MINIMUM_STEP_COUNT *
              (AppConstant.RESTRICT_SUB_STEP_INDEX + 1) -
          1;
      if (currentPageIndex > limitedIndex) {
        currentPageIndex = limitedIndex;
        isAutoPlay = false;
        update();
        userController.openPremiumDialog('N1급 모든 단어 활성화');

        return;
      }
    }

    update();
  }

  Word? newWord;

  late PageController pageController;

  void startListenWords() async {
    isAutoPlay = true;
    update();
    for (int i = currentPageIndex; i < words.length; i++) {
      if (!isAutoPlay) return;
      newWord = words[currentPageIndex];
      if (newWord != null) {
        await ttsController.japaneseSpeak(newWord!);
        await Future.delayed(const Duration(milliseconds: 150));
      }

      if (currentPageIndex < words.length - 1) {
        currentPageIndex++;
      } else {
        currentPageIndex = 0;
        i = 0;
      }

      if (pageController.hasClients) {
        onPageChange(currentPageIndex);
      }
    }
  }

  Future stop() async {
    print('STOP');
    isAutoPlay = false;
    // await pause();

    var result = await ttsController.flutterTts.stop();
    if (result == 1) {
      ttsController.ttsState = TtsState.stopped;
      if (!isClosed) {
        update();
      }
    }
  }

  void autuPlayStop() {
    isAutoPlay = false;
    update();

    stop();
    stop();
  }

  Future pause() async {
    var result = await ttsController.pause();
    if (result == 1) {
      ttsController.ttsState = TtsState.paused;
      update();
    }
  }

  void stopAllSound() async {
    await pause();
    await stop();
  }

  @override
  void onClose() {
    super.onClose();
    stopAllSound();
    pageController.dispose();
  }
}
