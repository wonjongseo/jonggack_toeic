import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/screen/home/components/welcome_widget.dart';
import 'package:jonggack_toeic/screen/home/services/home_controller.dart';
import 'package:jonggack_toeic/screen/my_voca/my_voca_sceen.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';
import 'package:jonggack_toeic/screen/home/components/users_word_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/admob/banner_ad/global_banner_admob.dart';
import '../../common/widget/part_of_information.dart';
import '../my_voca/controller/my_voca_controller.dart';

const String HOME_PATH = '/home2';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      key: homeController.scaffoldKey,
      body: _body(context, homeController),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }

  SafeArea _body(BuildContext context, HomeController homeController) {
    if (!homeController.isSeenTutorial) {
      homeController.settingFunctions();
    }
    const edgeInsets = EdgeInsets.symmetric(horizontal: 20 * 0.7);
    return SafeArea(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: WelcomeWidget(
              scaffoldKey: homeController.scaffoldKey,
            ),
          ),
          Expanded(
            flex: 9,
            child: GetBuilder<UserController>(
              builder: (userController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PartOfInformation(
                        goToSutdy: () =>
                            homeController.goToJlptStudy((0 + 1).toString()),
                        text: 'TOEIC 단어',
                        currentProgressCount:
                            userController.user.currentJlptWordScroes[0],
                        totalProgressCount:
                            userController.user.jlptWordScroes[0],
                        edgeInsets: edgeInsets,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: UserWordButton(
                      text: '나만의 단어장',
                      onTap: () {
                        Get.toNamed(
                          MY_VOCA_PATH,
                          arguments: {MY_VOCA_TYPE: MyVocaEnum.MY_WORD},
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: UserWordButton(
                      text: '자주 틀리는 단어',
                      onTap: () {
                        Get.toNamed(
                          MY_VOCA_PATH,
                          arguments: {
                            MY_VOCA_TYPE: MyVocaEnum.WRONG_WORD,
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '일본어 공부하러 가기',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
              onPressed: () {
                if (GetPlatform.isIOS) {
                  launchUrl(
                      Uri.parse('https://apps.apple.com/app/id6449939963'));
                } else if (GetPlatform.isAndroid) {
                  launchUrl(Uri.parse(
                      'https://play.google.com/store/apps/details?id=com.wonjongseo.jlpt_jonggack'));
                } else {
                  launchUrl(Uri.parse(
                      'https://play.google.com/store/apps/details?id=com.wonjongseo.jlpt_jonggack'));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
