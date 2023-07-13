import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/common.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/screen/grammar/controller/grammar_controller.dart';
import 'package:jonggack_toeic/model/Question.dart';
import 'package:jonggack_toeic/model/example.dart';
import 'package:jonggack_toeic/model/grammar.dart';
import 'package:jonggack_toeic/model/word.dart';

import '../../../../common/admob/controller/ad_controller.dart';
import '../../../user/controller/user_controller.dart';
import '../grammar_test_screen.dart';

class GrammarTestController extends GetxController {
  late ScrollController scrollController;

  List<Question> questions = [];

  bool isKorean = true;

  List<Map<int, List<Word>>> map = List.empty(growable: true);

  // [제출] 버튼 누르면 true
  bool isSubmitted = false;
  bool isTestAgain = false;

  // 틀린 문제
  late List<int> wrongQuetionIndexList;
  // 선택된 인덱스
  late List<int> checkedQuestionNumberIndexList;

  UserController userController = Get.find<UserController>();

  late AdController? adController;

  void submit(double score) async {
    if (checkedQuestionNumberIndexList.isNotEmpty) {
      String remainQuestions =
          checkedQuestionNumberIndexList.map((e) => '${e + 1}').toString();

      bool result = await askToWatchMovieAndGetHeart(
          title: const Text('제출 하시겠습니까?'),
          content: Text(
            '$remainQuestions번이 남아있습니다. 그래도 제출 하시겠습니까?',
            style: const TextStyle(
              color: AppColors.scaffoldBackground,
            ),
          ));

      if (!result) {
        return;
      }
    }
    if (!userController.isUserPremieum()) {
      if (score == 100) {
        userController.plusHeart(plusHeartCount: 3);
      }
      // 한페이지에서 테스트 두번 진행 시 광고 없음.
      if (adController!.randomlyPassAd() || !isTestAgain) {
        adController!.showRewardedInterstitialAd();
      }
    }

    isSubmitted = true;
    scrollController.jumpTo(0);
    update();
  }

  void againTest() {
    saveScore();
    Get.offNamed(
      GRAMMAR_TEST_SCREEN,
      preventDuplicates: false,
      arguments: {
        'grammar': Get.arguments['grammar'],
        'isTestAgain': true,
      },
    );
  }

  void saveScore() {
    grammarController.updateScore(
      questions.length - wrongQuetionIndexList.length,
      isRetry: isTestAgain,
    );
  }

  void init(dynamic arguments) {
    if (!userController.isUserPremieum()) {
      adController = Get.find<AdController>();
    }
    scrollController = ScrollController();
    // GrammerScreen 에서 grammar 파라티머 받음.
    startGrammarTest(arguments['grammar']);
    if (arguments['isTestAgain'] != null) {
      isTestAgain = true;
    }

    wrongQuetionIndexList = List.generate(questions.length, (index) => index);
    checkedQuestionNumberIndexList =
        List.generate(questions.length, (index) => index);
  }

/*
  * 사지선다 문제 중 클릭 할 때마다 함수 발생
  * 정답 맞추면 리스트에서 제거
  * 틀리면 리스트에 추가 (중복 체크 불가) 
  */

  void clickButton(int questionIndex, int selectedAnswerIndex) {
    Question question = questions[questionIndex];
    int correctAns = question.answer;

    if (correctAns == selectedAnswerIndex) {
      wrongQuetionIndexList.remove(questionIndex);
    } else {
      if (!wrongQuetionIndexList.contains(questionIndex)) {
        wrongQuetionIndexList.add(questionIndex);
      }
    }
    checkedQuestionNumberIndexList.remove(questionIndex);
    print('checkedQuestionNumberIndexList: ${checkedQuestionNumberIndexList}');

    update();
  }

  double getCurrentProgressValue() {
    double currentProgressValue =
        ((questions.length - checkedQuestionNumberIndexList.length).toDouble() /
                questions.length.toDouble()) *
            100;

    return currentProgressValue;
  }

  double getScore() {
    double score =
        ((questions.length - wrongQuetionIndexList.length).toDouble() /
                questions.length.toDouble()) *
            100;

    return score;
  }

  bool isGrammer = false;
  late GrammarController grammarController;

  void startGrammarTest(List<Grammar> grammars) {
    print('startGrammarTest');
    isGrammer = true;
    Random random = Random();
    grammarController = Get.find<GrammarController>();

    List<Word> words = [];

    for (int i = 0; i < grammars.length; i++) {
      List<Example> examples = grammars[i].examples;

      int randomExampleIndex = random.nextInt(examples.length);
      String word = examples[randomExampleIndex].word;
      String answer = examples[randomExampleIndex].answer;

      word = word.replaceAll(answer, '_____');

      String yomikata = examples[randomExampleIndex].mean;

      Word tempWord = Word(
        word: word,
        mean: answer,
      );

      words.add(tempWord);
    }

    map = Question.generateQustion(words, false);
    setQuestions(isKorean);
  }

  void setQuestions(bool isKorean) {
    this.isKorean = isKorean;
    for (var vocas in map) {
      for (var e in vocas.entries) {
        List<Word> optionsVoca = e.value;
        Word questionVoca = optionsVoca[e.key];

        Question question = Question(
          question: questionVoca,
          answer: e.key,
          options: optionsVoca,
        );

        questions.add(question);
      }
    }
    for (int i = 0; i < questions.length; i++) {
      print('${i + 1} ${questions[i].answer + 1}');
    }
  }
}
