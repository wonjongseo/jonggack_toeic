import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/screen/grammar/grammar_step_screen.dart';
import 'package:jonggack_toeic/screen/home/components/welcome_widget.dart';
import 'package:jonggack_toeic/screen/home/services/home_controller.dart';
import 'package:jonggack_toeic/screen/home/services/home_tutorial_service.dart';
import 'package:jonggack_toeic/screen/my_voca/my_voca_sceen.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';
import 'package:jonggack_toeic/screen/home/components/users_word_button.dart';

import '../../common/admob/banner_ad/global_banner_admob.dart';
import '../../common/widget/part_of_information.dart';
import '../../config/colors.dart';
import '../../config/theme.dart';
import '../../how_to_use_screen.dart';
import '../my_voca/controller/my_voca_controller.dart';
import '../setting/setting_screen.dart';

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
      homeController.homeTutorialService = HomeTutorialService();
      homeController.homeTutorialService?.initTutorial();
      homeController.homeTutorialService?.showTutorial(context);
      homeController.isSeenTutorial = true;
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: WelcomeWidget(
                isUserPremieum: homeController.userController.isUserPremieum(),
                // welcomeKey: homeController.homeTutorialService?.welcomeKey,
                settingKey: homeController.homeTutorialService?.settingKey,
                scaffoldKey: homeController.scaffoldKey),
          ),
          Expanded(
            flex: 9,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              controller: homeController.pageController,
              itemBuilder: (context, index) {
                const edgeInsets = EdgeInsets.symmetric(horizontal: 20 * 0.7);
                return GetBuilder<UserController>(
                  builder: (userController) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PartOfInformation(
                            goToSutdy: () => homeController
                                .goToJlptStudy((index + 1).toString()),
                            text: 'TOEIC 단어',
                            currentProgressCount: userController
                                .user.currentJlptWordScroes[index],
                            totalProgressCount:
                                userController.user.jlptWordScroes[index],
                            edgeInsets: edgeInsets,
                            homeTutorialService:
                                homeController.homeTutorialService,
                          ),
                          if (index < 3)
                            PartOfInformation(
                              goToSutdy: () => Get.to(() => GrammarStepSceen(
                                  level: (index + 1).toString())),
                              text: 'JLPT 문법',
                              currentProgressCount: userController
                                  .user.currentGrammarScores[index],
                              totalProgressCount:
                                  userController.user.grammarScores[index],
                              edgeInsets: edgeInsets,
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: FadeInLeft(
                      child: UserWordButton(
                        textKey: homeController.homeTutorialService?.myVocaKey,
                        text: '나만의 단어장',
                        onTap: () {
                          Get.toNamed(
                            MY_VOCA_PATH,
                            arguments: {MY_VOCA_TYPE: MyVocaEnum.MY_WORD},
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: FadeInLeft(
                      child: UserWordButton(
                        textKey:
                            homeController.homeTutorialService?.wrongWordKey,
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
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
