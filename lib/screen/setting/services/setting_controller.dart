import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';

import '../../../common/common.dart';
import '../../../config/colors.dart';
import '../../jlpt/jlpt/repository/jlpt_step_repository.dart';
import '../../../common/repository/local_repository.dart';
import '../../my_voca/repository/my_word_repository.dart';

class SettingController extends GetxController {
  bool isAutoSave = LocalReposotiry.getAutoSave();
  bool isEnabledEnglishSound = LocalReposotiry.getEnableEnglishSound();
  // 초기화 버튼을 눌렀는가
  bool isInitial = false;
  bool toggleAutoSave() {
    isAutoSave = LocalReposotiry.autoSaveOnOff();
    update();
    return isAutoSave;
  }

  UserController userController = Get.find<UserController>();

  void flipEnabledJapaneseSound() {
    isEnabledEnglishSound =
        LocalReposotiry.toggleEnableJapaneseSoundKey(isEnabledEnglishSound);
    update();
  }

  void flipAutoSave() {
    isAutoSave = toggleAutoSave();
  }

  Future<void> initJlptWord() async {
    bool result = await askToWatchMovieAndGetHeart(
        title: const Text(
          'TOEIC 단어를 초기화 하시겠습니까?',
          style: TextStyle(
              color: AppColors.scaffoldBackground, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          '점수들도 함께 사라집니다. 그래도 진행하시겠습니까?',
          style: TextStyle(
            color: AppColors.scaffoldBackground,
          ),
        ));
    if (result) {
      isInitial = true;
      userController.initializeProgress(TotalProgressType.JLPT);
      JlptStepRepositroy.deleteAllWord();

      successDeleteAndQuitApp();
    }
  }

  void successDeleteAndQuitApp() {
    Get.closeAllSnackbars();
    Get.snackbar(
      '초기화 완료, 재실행 해주세요!',
      '3초 뒤 자동적으로 앱이 종료됩니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.whiteGrey.withOpacity(0.7),
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(seconds: 2),
    );
    Future.delayed(const Duration(seconds: 4), () {
      if (kReleaseMode) {
        exit(0);
      }
    });
  }

  Future<void> initMyWords() async {
    bool result = await askToWatchMovieAndGetHeart(
      title: const Text(
        '나만의 단어를 초기화 하시겠습니까?',
        style: TextStyle(
            color: AppColors.scaffoldBackground, fontWeight: FontWeight.bold),
      ),
      content: const Text(
        '나만의 단어와 자주 틀리는 단어의 데이터가 제거 됩니다. 그래도 진행하시겠습니까?',
        style: TextStyle(
          color: AppColors.scaffoldBackground,
        ),
      ),
    );

    if (result) {
      isInitial = true;
      MyWordRepository.deleteAllMyWord();

      successDeleteAndQuitApp();
    }
  }

  void initAppDescription() async {
    bool result = await askToWatchMovieAndGetHeart(
        title: const Text(
      '앱 설명을 다시 보시겠습니까?',
      style: TextStyle(
          color: AppColors.scaffoldBackground, fontWeight: FontWeight.bold),
    ));

    if (result) {
      isInitial = true;
      await LocalReposotiry.initalizeTutorial();

      successDeleteAndQuitApp();
    }
  }
}
