import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:jonggack_toeic/model/jlpt_step.dart';
import 'package:jonggack_toeic/model/word.dart';

import '../../../../common/app_constant.dart';

class JlptStepRepositroy {
  static Future<bool> isExistData() async {
    final box = Hive.box(JlptStep.boxKey);
    return box.isNotEmpty;
  }

  static void deleteAllWord() {
    log('deleteAllWord start');

    final list = Hive.box(JlptStep.boxKey);
    list.deleteAll(list.keys);
    list.deleteFromDisk();
    log('deleteAllWord success');
  }

  static Future<int> init(String nLevel) async {
    log('JlptStepRepositroy ${nLevel}N init');

    final box = Hive.box(JlptStep.boxKey);

    List<List<Word>> words = Word.jsonToObject(nLevel);
    int totalCount = 0;
    for (int i = 0; i < words.length; i++) {
      totalCount += words[i].length;
    }
    // 31
    box.put('$nLevel-step-count', words.length);

    for (int dayIndex = 0; dayIndex < words.length; dayIndex++) {
      String day = "$dayIndex";

      int wordsLengthByDay = words[dayIndex].length;
      int stepCount = 0;

      words[dayIndex].shuffle();

      for (int step = 0;
          step < wordsLengthByDay;
          step += AppConstant.MINIMUM_STEP_COUNT) {
        List<Word> currentWords = [];

        if (step + AppConstant.MINIMUM_STEP_COUNT > wordsLengthByDay) {
          currentWords = words[dayIndex].sublist(step);
        } else {
          currentWords = words[dayIndex]
              .sublist(step, step + AppConstant.MINIMUM_STEP_COUNT);
        }
        currentWords.shuffle();

        JlptStep tempJlptStep = JlptStep(
            headTitle: day, step: stepCount, words: currentWords, scores: 0);

        String key = '$nLevel-$day-$stepCount';
        await box.put(key, tempJlptStep);
        stepCount++;
      }

      await box.put('$nLevel-$day', stepCount);
    }
    return totalCount;
  }

  List<JlptStep> getJlptStepByHeadTitle(String nLevel, String headTitle) {
    final box = Hive.box(JlptStep.boxKey);
    int headTitleStepCount = box.get('1-${int.parse(headTitle)}');

    List<JlptStep> jlptStepList = [];
    for (int step = 0; step < headTitleStepCount; step++) {
      String key = '1-${int.parse(headTitle)}-$step';
      JlptStep jlptStep = box.get(key);
      jlptStepList.add(jlptStep);
    }
    return jlptStepList;
  }

  List<Word> correctAllStepData(String level, String chapter) {
    List<JlptStep> jlptSteps = getJlptStepByHeadTitle(level, chapter);

    List<Word> words = [];
    for (int i = 0; i < jlptSteps.length; i++) {
      words.addAll(jlptSteps[i].words);
    }
    return words;
  }

  int getCountByJlptHeadTitle(String nLevel) {
    final box = Hive.box(JlptStep.boxKey);

    int jlptHeadTieleCount = box.get('$nLevel-step-count', defaultValue: 0);

    return jlptHeadTieleCount;
  }

  void updateJlptStep(String nLevel, JlptStep newJlptStep) {
    final box = Hive.box(JlptStep.boxKey);

    String key = '$nLevel-${newJlptStep.headTitle}-${newJlptStep.step}';
    box.put(key, newJlptStep);
  }
}
