import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jonggack_toeic/common/common.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/jlpt_test/controller/jlpt_test_controller.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/jlpt_test/components/jlpt_test_body.dart';
import 'package:jonggack_toeic/screen/jlpt/common/progress_bar.dart';

import '../../../../common/admob/banner_ad/test_banner_ad_controller.dart';
import '../../../../config/colors.dart';

const JLPT_TEST_PATH = '/test';
const JLPT_TEST = 'jlpt';
const CONTINUTE_JLPT_TEST = 'continue_jlpt_test';
const MY_VOCA_TEST = 'my_vcoa_test';
const MY_VOCA_TEST_KNOWN = 'known';
const MY_VOCA_TEST_UNKNWON = 'un_known';

class JlptTestScreen extends StatelessWidget {
  const JlptTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JlptTestController jlptTestController = Get.put(JlptTestController());
    jlptTestController.init(Get.arguments);

    return Scaffold(
      appBar: _appBar(context, jlptTestController),
      body: const JlptTestBody(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appBar(BuildContext context, JlptTestController questionController) {
    return AppBar(
      title: const ProgressBar(isKangi: false),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () async {
          if (questionController.isMyWordTest) {
            getBacks(1);
            return;
          }
          bool result = await reallyQuitText();
          if (result) {
            getBacks(2);
            return;
          }
        },
      ),
      iconTheme: const IconThemeData(color: AppColors.scaffoldBackground),
      actions: [
        GetBuilder<JlptTestController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: TextButton(
              onPressed: questionController.skipQuestion,
              child: Text(
                controller.nextOrSkipText,
                style: TextStyle(color: controller.color, fontSize: 20),
              ),
            ),
          );
        })
      ],
    );
  }

  GetBuilder<TestBannerAdController> _bottomNavigationBar() {
    return GetBuilder<TestBannerAdController>(builder: (controller) {
      return BannerContainer(bannerAd: controller.testBanner);
    });
  }
}
