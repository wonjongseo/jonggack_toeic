import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/app_constant.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';
import 'package:jonggack_toeic/common/widget/tutorial_text.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/jlpt_study/jlpt_study_sceen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../common/widget/app_bar_progress_bar.dart';
import '../../../../config/colors.dart';
import 'components/jlpt_study_buttons_temp.dart';

class JlptStudyTutorialSceen extends StatefulWidget {
  const JlptStudyTutorialSceen({super.key});

  @override
  State<JlptStudyTutorialSceen> createState() => _JlptStudyTutorialSceenState();
}

class _JlptStudyTutorialSceenState extends State<JlptStudyTutorialSceen> {
  List<TargetFocus> targets = [];
  GlobalKey? meanKey = GlobalKey();
  GlobalKey? unKnownKey = GlobalKey();
  GlobalKey? knownKey = GlobalKey();
  GlobalKey? kangiKey = GlobalKey();
  GlobalKey? testKey = GlobalKey();
  GlobalKey? saveKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initTutorial();
  }

  bool isShownYomikata = false;
  bool isShownMean = false;

  void showTutorial() {
    TutorialCoachMark(
      alignSkip: Alignment.topLeft,
      textStyleSkip: const TextStyle(
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
      targets: targets,
      onClickTarget: (target) {
        if (target.identify == 'kangi') {}
      },
      onSkip: () {
        meanKey = null;
        unKnownKey = null;
        knownKey = null;
        kangiKey = null;
        testKey = null;
        saveKey = null;

        Get.offAndToNamed(JLPT_STUDY_PATH);
      },
      onFinish: () {
        meanKey = null;
        unKnownKey = null;
        knownKey = null;
        kangiKey = null;
        testKey = null;
        saveKey = null;
        Get.offAndToNamed(JLPT_STUDY_PATH);
      },
    ).show(context: context);
  }

  void initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "kangi",
          keyTarget: kangiKey,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '발음 듣기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(text: '화면을 클릭해서 '),
                          TextSpan(
                              text: '발음',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: '을 들을 수 있습니다.'),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),

        // 몰라요
        TargetFocus(
          identify: "unKnown",
          keyTarget: unKnownKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '단어 한번 더 보기',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15.0),
                      children: [
                        TextSpan(
                            text: '몰라요',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: ' 버튼을 눌러서 해당 단어를 '),
                        TextSpan(
                            text: '한번 더',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: ' 확인 할 수 있습니다.')
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

        // 알아요
        TargetFocus(
          identify: "known",
          keyTarget: knownKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '단어 넘어가기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '알아요',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 버튼을 눌러서 다음 단어로 넘어갈 수 있습니다.')
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),

        // 의미
        TargetFocus(
          identify: "mean",
          keyTarget: meanKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '의미 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '의미',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 버튼을 눌러서 의미를 확인 할 수 있습니다.')
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),

        TargetFocus(
          identify: "test",
          keyTarget: testKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '단어 테스트 하기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "시험보기 버튼을 클릭하면 ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '주관식',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 혹은 '),
                          TextSpan(
                              text: '객관식',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: '으로 테스트를 진행할 수 있습니다 ')
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
        TargetFocus(
          identify: "save",
          keyTarget: saveKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const TutorialText(
                  title: '[자주 틀리는 단어장]', subTitles: [' 에 단어가 저장됩니다.']),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double buttonWidth = threeWordButtonWidth;
    double buttonHeight = 55;
    showTutorial();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: AppBarProgressBar(
            size: size,
            currentValue: 40,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          '저장',
                          key: saveKey,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteGrey,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: OutlinedButton(
                        onPressed: () async {},
                        child: Text(
                          '시험',
                          key: testKey,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          'English',
                          key: kangiKey,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                fontSize: 50,
                                color: Colors.white,
                              ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        child: Text('영어',
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                color: isShownMean
                                    ? Colors.white
                                    : Colors.transparent))),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            key: unKnownKey,
                            '몰라요',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimentions.width15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimentions.width10),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            key: meanKey,
                            '의미',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimentions.width15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimentions.width10),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            key: knownKey,
                            '알아요',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimentions.width15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
