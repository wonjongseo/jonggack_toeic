import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/widget/book_card.dart';
import 'package:jonggack_toeic/common/widget/heart_count.dart';
import 'package:jonggack_toeic/model/jlpt_step.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/controller/jlpt_step_controller.dart';
import 'package:jonggack_toeic/screen/jlpt/common/calendar_step_sceen.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';
import 'package:jonggack_toeic/tts_controller.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../common/admob/native_ad/native_ad_widget.dart';
import '../../../common/app_constant.dart';
import '../jlpt/repository/jlpt_step_repository.dart';

final String BOOK_STEP_PATH = '/book-step';

// ignore: must_be_immutable
class BookStepScreen extends StatelessWidget {
  late JlptStepController jlptWordController;
  JlptStepRepositroy jlptStepRepositroy = JlptStepRepositroy();
  UserController userController = Get.find<UserController>();

  final String level;

  BookStepScreen({super.key, required this.level}) {
    jlptWordController = Get.put(JlptStepController(level: level));
  }

  void goTo(int index, String chapter) {
    Get.toNamed(JLPT_CALENDAR_STEP_PATH,
        arguments: {'chapter': index.toString()});
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TtsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('TOEIC 단어'),
        // actions: const [HeartCount()],
      ),
      body: GetBuilder<JlptStepController>(builder: (context) {
        return ListView.separated(
          itemCount: jlptWordController.headTitleCount,
          separatorBuilder: (context, index) {
            if (index % AppConstant.PER_COUNT_NATIVE_ND == 2) {
              return NativeAdWidget();
            }
            return Container();
          },
          itemBuilder: (context, index) {
            bool isAllFinished = true;
            List<JlptStep> jlptSteps = jlptWordController.allJlptSteps[index];

            for (JlptStep jlptStep in jlptSteps) {
              if (jlptStep.isFinished! == false) {
                isAllFinished = false;
                break;
              }
            }

            String chapter = '$index';

            return FadeInLeft(
              delay: Duration(milliseconds: 200 * index),
              child: BookCard(
                  level: index,
                  isAllFinished: isAllFinished,
                  onTap: () => goTo(index, chapter)),
            );
          },
        );
      }),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}
