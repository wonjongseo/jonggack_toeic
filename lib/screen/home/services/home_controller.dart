import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/common.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/screen/setting/services/setting_controller.dart';

import '../../../common/admob/controller/ad_controller.dart';
import '../../user/controller/user_controller.dart';
import '../../../common/repository/local_repository.dart';
import '../../jlpt/common/book_step_screen.dart';

class HomeController extends GetxController {
  late PageController pageController;

  late AdController? adController;
  UserController userController = Get.find<UserController>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SettingController settingController = Get.find<SettingController>();
  late int currentPageIndex;
  late bool isSeenTutorial;

  Future settingFunctions() async {
    await Future.delayed(const Duration(milliseconds: 500));

    bool isJapaneseSoundActive = await alertSetting(
        title: '자동으로 발음 (영어) 음성 듣기 활성화 하시겠습니까?',
        content: '활성화 시 학습 페이지에서 [발음] 버튼을 누르면 자동적으로 영어 발음이 재생 됩니다.');

    if (isJapaneseSoundActive) {
      if (!settingController.isEnabledEnglishSound) {
        settingController.flipEnabledJapaneseSound();
      }
    } else {
      if (settingController.isEnabledEnglishSound) {
        settingController.flipEnabledJapaneseSound();
      }
    }

    Get.closeAllSnackbars();
    Get.snackbar(
      '초기 설정이 완료 되었습니다.',
      '해당 설정들은 설정 페이지에서 재설정 할 수 있습니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(seconds: 2),
    );
  }

  @override
  void onInit() {
    super.onInit();
    currentPageIndex = LocalReposotiry.getUserJlptLevel();
    pageController = PageController(initialPage: currentPageIndex);
    isSeenTutorial = LocalReposotiry.isSeenHomeTutorial();
  }

  void openDrawer() {
    if (scaffoldKey.currentState!.isEndDrawerOpen) {
      scaffoldKey.currentState!.closeEndDrawer();
      update();
    } else {
      scaffoldKey.currentState!.openEndDrawer();
      update();
    }
  }

  void pageChange(int page) async {
    currentPageIndex = page;

    pageController.jumpToPage(currentPageIndex);
    update();
    await LocalReposotiry.updateUserJlptLevel(page);
  }

  void goToJlptStudy(String index) {
    Get.to(
      () => BookStepScreen(
        level: index,
        isJlpt: true,
      ),
      duration: const Duration(milliseconds: 300),
    );
  }

  void goToKangiScreen(String level) {
    Get.to(
      () => BookStepScreen(
        level: level,
        isJlpt: false,
      ),
      duration: const Duration(milliseconds: 300),
    );
  }
}
