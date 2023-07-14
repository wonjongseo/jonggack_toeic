import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/widget/book_card.dart';
import 'package:jonggack_toeic/common/widget/heart_count.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/controller/jlpt_step_controller.dart';
import 'package:jonggack_toeic/screen/jlpt/common/calendar_step_sceen.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';
import 'package:jonggack_toeic/tts_controller.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../common/admob/native_ad/native_ad_widget.dart';
import '../../../common/app_constant.dart';

final String BOOK_STEP_PATH = '/book-step';

// ignore: must_be_immutable
class BookStepScreen extends StatelessWidget {
  late JlptStepController jlptWordController;

  UserController userController = Get.find<UserController>();

  final String level;
  final bool isJlpt;

  BookStepScreen({super.key, required this.level, required this.isJlpt}) {
    jlptWordController = Get.put(JlptStepController(level: level));
  }

  void goTo(int index, String chapter) {
    Get.toNamed(JLPT_CALENDAR_STEP_PATH,
        arguments: {'chapter': chapter, 'isJlpt': true});
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TtsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('TOEIC 단어'),
        actions: const [HeartCount()],
      ),
      body: ListView.separated(
        itemCount: jlptWordController.headTitleCount,
        separatorBuilder: (context, index) {
          if (index % AppConstant.PER_COUNT_NATIVE_ND == 2) {
            return NativeAdWidget();
          }
          return Container();
        },
        itemBuilder: (context, index) {
          String chapter = '챕터${index + 1}';

          return FadeInLeft(
            delay: Duration(milliseconds: 200 * index),
            child: BookCard(level: chapter, onTap: () => goTo(index, chapter)),
          );
        },
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}
