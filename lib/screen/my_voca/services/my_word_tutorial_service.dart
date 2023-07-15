import 'package:flutter/material.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';
import 'package:jonggack_toeic/common/widget/tutorial_text.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class MyVocaTutorialService {
  GlobalKey? inputIconKey = GlobalKey(debugLabel: 'inputIconKey');
  GlobalKey? calendarTextKey = GlobalKey(debugLabel: 'calendarTextKey');
  GlobalKey? myVocaTouchKey = GlobalKey(debugLabel: 'myVocaTouchKey');
  GlobalKey? flipKey = GlobalKey(debugLabel: 'flipKey');
  GlobalKey? excelMyVocaKey = GlobalKey(debugLabel: 'flipKey');

  List<TargetFocus> targets = [];

  initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "calendarTextKey",
          keyTarget: calendarTextKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '달력 열고 접기',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '나만의 달력',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: '을 클릭하여 '),
                        TextSpan(
                            text: '달력',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: '을 표시 / 미표시 할 수 있습니다.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "inputIconKey",
          keyTarget: inputIconKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '나만의 단어 저장',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '단어와 의미',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: '를 입력하여 나만의 단어를 저장 할 수 있습니다.')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "myVocaTouchKey",
          keyTarget: myVocaTouchKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '나만의 단어',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  const Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      text: '1. ',
                      children: [
                        TextSpan(
                            text: '오른쪽으로 슬라이드',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: ' 하여 '),
                        TextSpan(
                            text: '암기',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: ' 또는 '),
                        TextSpan(
                            text: '미암기',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: ' 으로 설정 할 수 있습니다.')
                      ],
                    ),
                  ),
                  SizedBox(height: Dimentions.height10),
                  const Text.rich(
                    TextSpan(
                      text: '2. ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '왼쪽으로 슬라이드',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: ' 하여 '),
                        TextSpan(
                            text: '삭제',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: ' 할 수 있습니다.')
                      ],
                    ),
                  ),
                  SizedBox(height: Dimentions.height10),
                  const Text.rich(
                    TextSpan(
                      text: '3. ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '클릭',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: '하여 나만의 단어 정보를 볼 수 있습니다.')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "flipKey",
          keyTarget: flipKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const TutorialText(
                title: '플립 기능',
                subTitles: [
                  '암기된 단어만 보기',
                  '미암기된 단어만 보기',
                  '모든 단어를 보기',
                  '단어와 의미을 뒤집어서 보기',
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "excelMyVocaKey",
          keyTarget: excelMyVocaKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Excel파일 데이터 나만의 단어장에 저장',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'Excel 파일',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: '의 단어를 '),
                        TextSpan(
                            text: '저장',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: '하여 학습 할 수 있습니다.')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showTutorial(BuildContext context, Function() onFlish) {
    TutorialCoachMark(
      onFinish: () {
        inputIconKey = null;
        calendarTextKey = null;
        myVocaTouchKey = null;
        flipKey = null;
        excelMyVocaKey = null;
        onFlish();
      },
      onSkip: () {
        inputIconKey = null;
        calendarTextKey = null;
        myVocaTouchKey = null;
        flipKey = null;
        excelMyVocaKey = null;
        onFlish();
      },
      alignSkip: Alignment.topLeft,
      textStyleSkip: const TextStyle(
          color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
      targets: targets,
    ).show(context: context);
  }
}
