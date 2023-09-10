import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/screen/jlpt/common/calendar_step_sceen.dart';
import 'package:jonggack_toeic/screen/my_voca/my_voca_sceen.dart';

import 'package:jonggack_toeic/screen/jlpt/jlpt/jlpt_test/jlpt_test_screen.dart';
import 'package:jonggack_toeic/screen/score/score_screen.dart';
import 'package:jonggack_toeic/screen/setting/setting_screen.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/jlpt_study/jlpt_study_sceen.dart';

import 'screen/home/home_screen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> getPages = [
    GetPage(
      name: HOME_PATH,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: MY_VOCA_PATH,
      page: () => MyVocaPage(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: JLPT_CALENDAR_STEP_PATH,
      page: () => CalendarStepSceen(),
    ),
    GetPage(
      name: JLPT_STUDY_PATH,
      page: () => JlptStudyScreen(),
    ),
    GetPage(
      name: JLPT_TEST_PATH,
      page: () => const JlptTestScreen(),
    ),
    GetPage(
      name: SCORE_PATH,
      page: () => const ScoreScreen(),
    ),
    GetPage(
      name: SETTING_PATH,
      page: () => const SettingScreen(),
    ),
  ];
}
