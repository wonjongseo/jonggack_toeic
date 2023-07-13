// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/admob/controller/ad_controller.dart';
import 'package:jonggack_toeic/common/common.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/screen/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:jonggack_toeic/screen/my_voca/controller/my_voca_controller.dart';
import 'package:jonggack_toeic/screen/setting/services/setting_controller.dart';
import 'package:jonggack_toeic/model/Question.dart';
import 'package:jonggack_toeic/model/word.dart';
import 'package:jonggack_toeic/screen/score/score_screen.dart';

import '../../../../common/app_constant.dart';
import '../../../../model/my_word.dart';
import '../../../../model/user.dart';
import '../../../user/controller/user_controller.dart';

class MyVocaTestController extends GetxController
    with SingleGetTickerProviderMixin {
  AdController adController = Get.find<AdController>();
  UserController userController = Get.find<UserController>();
  SettingController settingController = Get.find<SettingController>();
  MyVocaController myVocaController = Get.find<MyVocaController>();
  // 진행률 바
  late AnimationController animationController;
  // 진행률 바 애니메이션
  late Animation animation;

  bool isManual = false;

  // 문제 컨트롤러
  late PageController pageController;

  // 퀴즈를 위한 맵.
  List<Map<int, List<Word>>> map = List.empty(growable: true);

  late JlptStepController jlptWordController;

  TextEditingController? textEditingController;
  FocusNode? focusNode;
  String? inputValue;

  bool isSubmitted = false;
  bool isMyWordTest = false;
  // 읽는 법 값

  bool isWrong = false;
  List<Question> questions = [];
  List<Question> wrongQuestions = [];

  late Word correctQuestion;
  int step = 0;
  bool isAnswered = false;
  int correctAns = 0;
  late int selectedAns;
  RxInt questionNumber = 1.obs;
  int numOfCorrectAns = 0;
  String text = 'skip';
  Color color = Colors.white;
  int day = 0;

  void startMyVocaQuiz(List<MyWord> myWords, bool isKnwon, bool isUnKnwon) {
    isMyWordTest = true;
    List<Word> tempWords = [];
    int wordCount = 0;
    if (isKnwon == true && isUnKnwon == true) {
      tempWords = List.generate(
        myWords.length,
        (i) => Word(
          word: myWords[i].word,
          mean: myWords[i].mean,
        ),
      );
    } else if (isKnwon == true && isUnKnwon == false) {
      for (MyWord myWord in myWords) {
        if (myWord.isKnown) {
          tempWords.add(
            Word(
              word: myWord.word,
              mean: myWord.mean,
            ),
          );
        }
      }
    } else {
      for (MyWord myWord in myWords) {
        if (!myWord.isKnown) {
          tempWords.add(Word(
            word: myWord.word,
            mean: myWord.mean,
          ));
        }
      }
    }

    wordCount = tempWords.length;
    if (wordCount < 4) {
      return;
    }
    map = Question.generateQustion(tempWords, false);
    setQuestions();
  }

  void onFieldSubmitted(String value) {
    inputValue = value;
  }

  @override
  void onInit() {
    animationController =
        AnimationController(duration: const Duration(seconds: 30), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        update();
      });

    animationController.forward().whenComplete(nextQuestion);
    pageController = PageController();

    if (isManual) {
      textEditingController = TextEditingController();
      focusNode = FocusNode();
    }

    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    pageController.dispose();
    textEditingController?.dispose();
    focusNode?.dispose();
    super.onClose();
  }

  void setQuestions() {
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
  }

  void saveWrongQuestion() {
    if (!wrongQuestions.contains(questions[questionNumber.value - 1])) {
      wrongQuestions.add(questions[questionNumber.value - 1]);
    }
  }

  Color getTheTextEditerBorderRightColor({bool isBorder = true}) {
    if (isAnswered) {
      if (formattingQuestion('correctQuestion.yomikata', inputValue!)) {
        return const Color(0xFF6AC259);
      } else {
        return const Color(0xFFE92E30);
      }
    }
    return isBorder
        ? AppColors.scaffoldBackground.withOpacity(0.5)
        : AppColors.scaffoldBackground;
  }

  void requestFocus() {
    focusNode?.requestFocus();
  }

  void checkAns(Question question, int selectedIndex) {
    isSubmitted = true;
    correctAns = question.answer;
    selectedAns = selectedIndex;
    isAnswered = true;

    correctQuestion = question.options[correctAns];

    if (isManual) {
      if (textEditingController!.text.isEmpty) {
        requestFocus();
        return;
      }
    }

    animationController.stop();
    update();

    // if 설정에서 읽는법도 테스트에 포함
    if (isManual) {
      if (correctAns == selectedAns &&
          formattingQuestion(correctQuestion.word, inputValue!)) {
        testCorect();
      } else {
        textWrong();
      }
    }
    // if 설정에서 읽는법도 테스트에 포함하지 않았나.
    else if (correctAns == selectedAns) {
      testCorect();
    } else {
      textWrong();
    }
  }

  textWrong() {
    myVocaController.updateWord(correctQuestion.word, false);
    saveWrongQuestion();
    isWrong = true;
    color = Colors.pink;
    text = 'next';
    Future.delayed(const Duration(milliseconds: 1500), () {
      nextQuestion();
    });
  }

  testCorect() {
    text = 'skip';
    numOfCorrectAns++;
    color = Colors.blue;
    text = 'next';
    myVocaController.updateWord(correctQuestion.word, true);
    Future.delayed(const Duration(milliseconds: 800), () {
      nextQuestion();
    });
  }

  bool formattingQuestion(String correct, String answer) {
    correct.trim();

    answer.trim();

    correct = correct.replaceAll('-', '');
    correct = correct.replaceAll('ー', '');
    correct = correct.replaceAll('　', '');
    correct = correct.replaceAll(' ', '');

    answer = answer.replaceAll('-', '');
    answer = answer.replaceAll('ー', '');
    answer = answer.replaceAll(' ', '');
    answer = answer.replaceAll('　', '');

    return answer == correct;
  }

  void skipQuestion() {
    isAnswered = true;

    animationController.stop();
    saveWrongQuestion();
    isWrong = true;
    color = Colors.pink;
    text = 'next';
    nextQuestion();
  }

  void nextQuestion() {
    isSubmitted = false;
    /**
     * if 테스트 문제가 남아 있다면.
     *  if 정답을 틀렸다면
     * 
     * 초기화
     * 
     */
    if (questionNumber.value != questions.length) {
      if (!isAnswered) {
        saveWrongQuestion();
      }
      isWrong = false;
      text = 'skip';
      color = Colors.white;
      isAnswered = false;

      textEditingController?.clear();

      pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      animationController.reset();
      animationController.forward().whenComplete(nextQuestion);
    }
    // 테스트를 다 풀 었으면
    else {
      // AD
      adController.showRewardedInterstitialAd();
      if (!isMyWordTest) {
        jlptWordController.updateScore(numOfCorrectAns, wrongQuestions);
      }

      if (numOfCorrectAns == questions.length) {
        userController.plusHeart(plusHeartCount: AppConstant.HERAT_COUNT_AD);
        getBacks(2);
        return;
      }
      Get.toNamed(SCORE_PATH);
    }
  }

  void updateTheQnNum(int index) {
    questionNumber.value = index + 1;
  }

  String get scoreResult => '$numOfCorrectAns / ${questions.length}';

  String wrongMean(int index) {
    return wrongQuestions[index].options[wrongQuestions[index].answer].mean;
  }

  String wrongWord(int index) {
    return wrongQuestions[index].question.word;
  }
}
