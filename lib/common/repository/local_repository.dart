import 'dart:developer';

import 'package:get/get_utils/src/platform/platform.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jonggack_toeic/model/Question.dart';
import 'package:jonggack_toeic/model/hive_type.dart';
import 'package:jonggack_toeic/model/my_word.dart';
import 'package:jonggack_toeic/model/jlpt_step.dart';
import 'package:jonggack_toeic/model/word.dart';
import '../../model/user.dart';

class LocalReposotiry {
  static Future<void> init() async {
    if (GetPlatform.isMobile) {
      await Hive.initFlutter();
    } else if (GetPlatform.isWindows) {
      Hive.init("C:/Users/kissco/Desktop/learning/jlpt_app/assets/hive");
    }

    if (!Hive.isAdapterRegistered(UserTypeId)) {
      Hive.registerAdapter(UserAdapter());
    }

    if (!Hive.isAdapterRegistered(WordTypeId)) {
      Hive.registerAdapter(WordAdapter());
    }

    if (!Hive.isAdapterRegistered(MyWordTypeId)) {
      Hive.registerAdapter(MyWordAdapter());
    }

    if (!Hive.isAdapterRegistered(JlptStepTypeId)) {
      Hive.registerAdapter(JlptStepAdapter());
    }

    if (!Hive.isAdapterRegistered(QuestionTypeId)) {
      Hive.registerAdapter(QuestionAdapter());
    }

    if (!Hive.isBoxOpen('homeTutorialKey')) {
      log("await Hive.openBox('homeTutorialKey')");
      await Hive.openBox('homeTutorialKey');
    }

    if (!Hive.isBoxOpen('wordStudyTutorialKey')) {
      log("await Hive.openBox('wordStudyTutorialKey')");
      await Hive.openBox('wordStudyTutorialKey');
    }

    if (!Hive.isBoxOpen('myWordTutorialKey')) {
      log("await Hive.openBox('myWordTutorialKey')");
      await Hive.openBox('myWordTutorialKey');
    }

    if (!Hive.isBoxOpen('autoSaveKey')) {
      log("await Hive.openBox('autoSaveKey')");
      await Hive.openBox('autoSaveKey');
    }

    if (!Hive.isBoxOpen('textKeyBoardKey')) {
      log("await Hive.openBox('textKeyBoardKey')");
      await Hive.openBox('textKeyBoardKey');
    }

    if (!Hive.isBoxOpen('userJlptLevelKey')) {
      log("await Hive.openBox('userJlptLevelKey')");
      await Hive.openBox('userJlptLevelKey');
    }

    // SOUND
    if (!Hive.isBoxOpen('volumnKey')) {
      log("await Hive.openBox('volumnKey')");
      await Hive.openBox('volumnKey');
    }

    if (!Hive.isBoxOpen('pitchKey')) {
      log("await Hive.openBox('pitchKey')");
      await Hive.openBox('pitchKey');
    }

    if (!Hive.isBoxOpen('rateKey')) {
      log("await Hive.openBox('rateKey')");
      await Hive.openBox('rateKey');
    }

    if (!Hive.isBoxOpen('enableJapaneseSoundKey')) {
      log("await Hive.openBox('enableJapaneseSoundKey')");
      await Hive.openBox('enableJapaneseSoundKey');
    }

    if (!Hive.isBoxOpen(User.boxKey)) {
      log("await Hive.openBox(User.boxKey)");
      await Hive.openBox(User.boxKey);
    }

    if (!Hive.isBoxOpen(JlptStep.boxKey)) {
      log("await Hive.openBox(JlptStep.boxKey)");
      await Hive.openBox(JlptStep.boxKey);
    }

    if (!Hive.isBoxOpen(Word.boxKey)) {
      log("await Hive.openBox<Word>(Word.boxKey)");
      await Hive.openBox<Word>(Word.boxKey);
    }

    if (!Hive.isBoxOpen(MyWord.boxKey)) {
      log("await Hive.openBox<MyWord>(MyWord.boxKey)");
      await Hive.openBox<MyWord>(MyWord.boxKey);
    }
  }

  static bool isSeenHomeTutorial() {
    final homeTutorialBox = Hive.box('homeTutorialKey');
    String key = 'homeTutorial';

    if (!homeTutorialBox.containsKey(key)) {
      homeTutorialBox.put(key, true);
      return false;
    }

    if (homeTutorialBox.get(key) == false) {
      homeTutorialBox.put(key, true);
      return false;
    }

    return true;
  }

  static bool isSeenWordStudyTutorialTutorial() {
    return false;
    final wordStudyTutorialBox = Hive.box('wordStudyTutorialKey');
    String key = 'wordStudyTutorialKey';

    if (!wordStudyTutorialBox.containsKey(key)) {
      wordStudyTutorialBox.put(key, true);
      return false;
    }

    if (wordStudyTutorialBox.get(key) == false) {
      wordStudyTutorialBox.put(key, true);
      return false;
    }

    return true;
  }

  static bool isSeenMyWordTutorial({bool isRestart = false}) {
    return false;

    final myWordTutorialBox = Hive.box('myWordTutorialKey');

    String key = 'myWordTutorial';
    if (!myWordTutorialBox.containsKey(key)) {
      myWordTutorialBox.put(key, true);
      return false;
    }

    if (myWordTutorialBox.get(key) == false) {
      myWordTutorialBox.put(key, true);
      return false;
    }

    return true;
  }

  static Future<void> initalizeTutorial() async {
    final homeTutorialBox = Hive.box('homeTutorialKey');
    String homeTutorialBoxkey = 'homeTutorial';
    await homeTutorialBox.put(homeTutorialBoxkey, false);

    final wordStudyTutorialBox = Hive.box('wordStudyTutorialKey');
    String wordStudyTutorialBoxkey = 'wordStudyTutorialKey';
    await wordStudyTutorialBox.put(wordStudyTutorialBoxkey, false);

    final myWordTutorialBox = Hive.box('myWordTutorialKey');
    String myWordTutorialBoxkey = 'myWordTutorial';
    await myWordTutorialBox.put(myWordTutorialBoxkey, false);
  }

  static bool autoSaveOnOff() {
    final list = Hive.box('autoSaveKey');
    String key = 'autoSave';

    bool isAutoSave = list.get(key);

    isAutoSave = !isAutoSave;

    list.put(key, isAutoSave);
    return isAutoSave;
  }

  static bool getAutoSave() {
    final list = Hive.box('autoSaveKey');
    String key = 'autoSave';

    if (!list.containsKey(key)) {
      list.put(key, false);
      return false;
    }

    bool isAutoSave = list.get(key, defaultValue: false);

    return isAutoSave;
  }

  static int getUserJlptLevel() {
    final list = Hive.box('userJlptLevelKey');
    String key = 'userJlptLevel';
    int level = list.get(key, defaultValue: 2);

    return level;
  }

  static Future<void> updateUserJlptLevel(int level) async {
    final list = Hive.box('userJlptLevelKey');
    String key = 'userJlptLevel';

    await list.put(key, level);
  }

  static double getVolumn() {
    final list = Hive.box('volumnKey');
    String key = 'volumn';
    double volumn = list.get(key, defaultValue: 1.0);

    return volumn;
  }

  static bool updateVolumn(double newValue) {
    final list = Hive.box('volumnKey');
    String key = 'volumn';
    try {
      list.put(key, newValue);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static double getPitch() {
    final list = Hive.box('pitchKey');
    String key = 'pitch';
    double pitch = list.get(key, defaultValue: 1.0);

    return pitch;
  }

  static bool updatePitch(double newValue) {
    final list = Hive.box('pitchKey');
    String key = 'pitch';
    try {
      list.put(key, newValue);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static double getRate() {
    final list = Hive.box('rateKey');
    String key = 'rate';
    double rate = list.get(key, defaultValue: 0.5);

    return rate;
  }

  static bool updateRate(double newValue) {
    final list = Hive.box('rateKey');
    String key = 'rate';
    try {
      list.put(key, newValue);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static bool getEnableEnglishSound() {
    final list = Hive.box('enableJapaneseSoundKey');
    String key = 'enableJapaneseSound';
    bool isEnableSound = list.get(key, defaultValue: true);

    return isEnableSound;
  }

  static bool toggleEnableJapaneseSoundKey(bool isEnableSound) {
    final list = Hive.box('enableJapaneseSoundKey');
    String key = 'enableJapaneseSound';
    isEnableSound = !isEnableSound;
    try {
      list.put(key, isEnableSound);
      return isEnableSound;
    } catch (e) {
      log(e.toString());
      throw Error();
    }
  }
}
