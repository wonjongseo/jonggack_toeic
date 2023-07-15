import 'package:get/get.dart';
import 'package:jonggack_toeic/model/jlpt_step.dart';
import 'package:jonggack_toeic/screen/jlpt/jlpt/repository/jlpt_step_repository.dart';

import '../../../../common/app_constant.dart';
import '../../../../model/Question.dart';
import '../jlpt_study/jlpt_study_sceen.dart';
import '../../../user/controller/user_controller.dart';

class JlptStepController extends GetxController {
  List<JlptStep> jlptSteps = [];
  List<List<JlptStep>> allJlptSteps = [];
  final String level;
  late String headTitle;
  late int headTitleCount;
  late int step;

  JlptStepRepositroy jlptStepRepositroy = JlptStepRepositroy();
  UserController userController = Get.find<UserController>();

  JlptStepController({required this.level}) {
    headTitleCount = jlptStepRepositroy.getCountByJlptHeadTitle(level);

    for (int i = 0; i < headTitleCount; i++) {
      String a = '챕터$i';

      allJlptSteps.add(jlptStepRepositroy.getJlptStepByHeadTitle(level, a));
    }
  }

  void goToStudyPage(int subStep, bool isSeenTutorial) {
    setStep(subStep);
    if (isSeenTutorial) {
      Get.toNamed(JLPT_STUDY_PATH);
    } else {
      // isSeenTutorial = true;
      // Get.to(
      //   () => const JlptStudyTutorialSceen(),
      //   transition: Transition.circularReveal,
      // );
    }
  }

  void setStep(int step) {
    this.step = step;

    if (jlptSteps[step].scores == jlptSteps[step].words.length) {
      clearScore();
    }
  }

  /*
   * 테스트로 만점이면 초기화.
   */
  void clearScore() {
    int score = jlptSteps[step].scores;
    jlptSteps[step].scores = 0;
    update();
    jlptStepRepositroy.updateJlptStep(level, jlptSteps[step]);
    userController.updateCurrentProgress(
        TotalProgressType.JLPT, int.parse(level) - 1, -score);
  }

  void updateScore(int score, List<Question> wrongQestion) {
    // 모든 점수에 해당 점수가 이미 기록 되어 있던가 ?
    int previousScore = jlptSteps[step].scores;

    if (previousScore != 0) {
      userController.updateCurrentProgress(
          TotalProgressType.JLPT, int.parse(level) - 1, -previousScore);
    }

    score = score + previousScore;

    // 다 맞췄으면
    if (score == jlptSteps[step].words.length) {
      jlptSteps[step].isFinished = true;
    }
    // 에러 발생.
    else if (score > jlptSteps[step].words.length) {
      score = jlptSteps[step].words.length;
    }

    if (jlptSteps[step].wrongQestion != null) {
      for (int i = 0; i < jlptSteps[step].wrongQestion!.length; i++) {
        for (int j = 0; j < wrongQestion.length; j++) {
          if (jlptSteps[step].wrongQestion![i] == wrongQestion[j]) {}
        }
      }
    }

    jlptSteps[step].wrongQestion = wrongQestion;
    jlptSteps[step].scores = score;
    update();
    jlptStepRepositroy.updateJlptStep(level, jlptSteps[step]);
    userController.updateCurrentProgress(
        TotalProgressType.JLPT, int.parse(level) - 1, score);

    // 처음 보던가
  }

  JlptStep getJlptStep() {
    return jlptSteps[step];
  }

  void setJlptSteps(String chapter) {
    // this.headTitle = headTitle;
    jlptSteps = allJlptSteps[int.parse(chapter)];
    // jlptSteps =
    //     jlptStepRepositroy.getJlptStepByHeadTitle(level, this.headTitle);

    // update();
  }

  // ---------

  bool restrictN1SubStep(int subStep) {
    if (userController.user.isFake) {
      return false;
    }
    // 무료버전일 경우.
    if ((level == '1' &&
        !userController.isUserPremieum() &&
        subStep > AppConstant.RESTRICT_SUB_STEP_INDEX)) {
      userController.openPremiumDialog('N1급 모든 단어 활성화',
          messages: ['N1 단어의 다른 챕터에서 무료버전의 일부를 학습 할 수 있습니다.']);
      return true;
    }
    return false;
  }
}
