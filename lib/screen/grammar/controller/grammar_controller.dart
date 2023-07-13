import 'package:get/get.dart';
import 'package:jonggack_toeic/model/grammar_step.dart';
import 'package:jonggack_toeic/screen/grammar/repository/grammar_step_repository.dart';
import 'package:jonggack_toeic/tts_controller.dart';

import '../../../common/app_constant.dart';
import '../../user/controller/user_controller.dart';
import '../components/grammar_tutorial_screen.dart';
import '../grammar_stury_screen.dart';

class GrammarController extends GetxController {
  List<GrammarStep> grammers = [];
  late int step;
  late String level;
  GrammarRepositroy grammarRepositroy = GrammarRepositroy();

  UserController userController = Get.find<UserController>();

  GrammarController({required this.level}) {
    grammers = grammarRepositroy.getGrammarStepByLevel(level);
  }

  void setStep(int step) {
    this.step = step;

    if (grammers[step].scores == grammers[step].grammars.length) {
      clearScore();
    }
  }

  void clearScore() {
    int subtrackScore = grammers[step].scores;
    grammers[step].scores = 0;
    update();
    grammarRepositroy.updateGrammerStep(grammers[step]);
    userController.updateCurrentProgress(
        TotalProgressType.GRAMMAR, int.parse(level) - 1, -subtrackScore);
  }

  void updateScore(int score, {bool isRetry = false}) {
    int previousScore = grammers[step].scores;

    if (previousScore != 0) {
      userController.updateCurrentProgress(
          TotalProgressType.GRAMMAR, int.parse(level) - 1, -previousScore);
    }

    if (score == grammers[step].grammars.length) {
      grammers[step].isFinished = true;
    } else if (score > grammers[step].grammars.length) {
      score = grammers[step].grammars.length;
    }

    grammers[step].scores = score;

    update();
    grammarRepositroy.updateGrammerStep(grammers[step]);
    userController.updateCurrentProgress(
        TotalProgressType.GRAMMAR, int.parse(level) - 1, score);
  }

  GrammarStep getGrammarStep() {
    return grammers[step];
  }

  void setGrammarSteps(String level) {
    this.level = level;

    update();
  }

  bool isSuccessedAllGrammar(int subStep) {
    return grammers[subStep].scores == grammers[subStep].grammars.length;
  }

  bool isFinishedPreviousSubStep(int subStep) {
    return grammers[subStep - 1].isFinished ?? false;
  }

  void goToSturyPage(int subStep, bool isSeenTutorial) {
    setStep(subStep);

    if (!isSeenTutorial) {
      isSeenTutorial = true;
      Get.to(
        () => const GrammerTutorialScreen(),
        transition: Transition.circularReveal,
      );
    } else {
      // Get.put(TtsController());
      Get.toNamed(GRAMMER_STUDY_PATH);
    }
  }

  bool restrictN1SubStep(int subStep) {
    // 무료버전일 경우.
    if (level == '1' &&
        !userController.isUserPremieum() &&
        subStep > AppConstant.RESTRICT_SUB_STEP_INDEX) {
      userController.openPremiumDialog('N1급 모든 단어 활성화');
      return true;
    }
    return false;
  }
}
