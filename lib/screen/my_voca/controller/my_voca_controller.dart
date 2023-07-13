import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/admob/controller/ad_controller.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/config/theme.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/my_word.dart';

import '../repository/my_word_repository.dart';
import '../components/flip_button.dart';
import '../services/my_word_tutorial_service.dart';

const MY_VOCA_TYPE = 'my-voca-type';

enum MyVocaEnum { MY_WORD, WRONG_WORD }

class MyVocaController extends GetxController {
  void openDialogForclickMyWord(BuildContext context, MyWord myWord) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            myWord.word,
            style: TextStyle(color: Colors.black, fontSize: 40),
          ),
          // title: KangiText(
          //   fontSize: 40,
          //   color: AppColors.scaffoldBackground,
          //   japanese: myWord.word,
          //   clickTwice: false,
          // ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '의미 :\n${myWord.mean}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.scaffoldBackground,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // for ad
  int saveWordCount = 0;
  final bool isMyVocaPage;

  // 키보드 On / OF
  bool isCalendarOpen = true;

  // Flip 기능 종류
  bool isOnlyKnown = false;
  bool isOnlyUnKnown = false;
  bool isWordFlip = false;

  MyWordRepository myWordReposotiry = MyWordRepository();
  UserController userController = Get.find<UserController>();

  late TextEditingController wordController;
  late TextEditingController yomikataController;
  late TextEditingController meanController;

  late FocusNode wordFocusNode;
  late FocusNode yomikataFocusNode;
  late FocusNode meanFocusNode;

  late MyVocaTutorialService? myVocaTutorialService = null;

  AdController? adController;

  Map<DateTime, List<MyWord>> kEvents = {};
  List<MyWord> myWords = [];

  MyVocaController({required this.isMyVocaPage});

  void flipCalendar() {
    isCalendarOpen = !isCalendarOpen;
    update();
  }

  void loadData() async {
    myWords = await myWordReposotiry.getAllMyWord(isMyVocaPage);
    DateTime now = DateTime.now();

    kEvents = LinkedHashMap<DateTime, List<MyWord>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    for (int i = 0; i < myWords.length; i++) {
      if (myWords[i].createdAt == null) {
        DateTime savedDate = DateTime.utc(now.year, now.month, now.day);
        kEvents.addAll({
          savedDate: [...kEvents[savedDate] ?? [], myWords[i]]
        });
      } else {
        DateTime savedDate = DateTime.utc(myWords[i].createdAt!.year,
            myWords[i].createdAt!.month, myWords[i].createdAt!.day);
        kEvents.addAll(
          {
            savedDate: [...kEvents[savedDate] ?? [], myWords[i]]
          },
        );
      }
    }
    update();
  }

  void showTutirial(BuildContext context) async {
    MyWord tempWord = MyWord(word: '食べる', mean: '먹다');
    tempWord.isKnown = true;
    DateTime now = DateTime.now();

    DateTime time = DateTime.utc(now.year, now.month, now.day);

    tempWord.createdAt = time;
    kEvents[time] = [];
    kEvents[time]!.add(tempWord);
    selectedEvents.value.add(tempWord);

    update();
    myVocaTutorialService = MyVocaTutorialService();
    myVocaTutorialService!.initTutorial();
    myVocaTutorialService!.showTutorial(context, () {
      selectedEvents.value.remove(tempWord);
      update();
    });
  }

  @override
  void onInit() async {
    super.onInit();
    loadData();
    if (!userController.isUserPremieum()) {
      adController = Get.find<AdController>();
    }
    wordController = TextEditingController();
    yomikataController = TextEditingController();
    meanController = TextEditingController();
    wordFocusNode = FocusNode();
    yomikataFocusNode = FocusNode();
    meanFocusNode = FocusNode();
  }

  @override
  void onClose() {
    wordController.dispose();
    yomikataController.dispose();
    meanController.dispose();
    wordFocusNode.dispose();
    yomikataFocusNode.dispose();
    meanFocusNode.dispose();
    super.onClose();
  }

// 직접 일본어 단어 저장
  void manualSaveMyWord() async {
    String word = wordController.text;
    String yomikata = yomikataController.text;
    String mean = meanController.text;

    if (word.isEmpty) {
      wordFocusNode.requestFocus();
      return;
    }
    if (yomikata.isEmpty) {
      yomikataFocusNode.requestFocus();
      return;
    }
    if (mean.isEmpty) {
      meanFocusNode.requestFocus();
      return;
    }

    MyWord newWord = MyWord(
      word: word,
      mean: mean,
      isManuelSave: true,
    );

    if (kEvents[newWord.createdAt] == null) {
      kEvents[newWord.createdAt!] = [];
    }

    kEvents[newWord.createdAt]!.add(newWord);
    myWords.add(newWord);
    MyWordRepository.saveMyWord(newWord);

    selectedEvents.value.add(newWord);
    update();

    wordController.clear();
    meanController.clear();
    yomikataController.clear();
    wordFocusNode.requestFocus();
    saveWordCount++;

    if (!userController.isUserPremieum()) {
      if (saveWordCount > 7) {
        adController!.showIntersistialAd();
        saveWordCount = 0;
      }
    }

    update();
  }

// 일본어 단어 삭제
  void deleteWord(MyWord myWord) {
    DateTime time = DateTime.utc(
        myWord.createdAt!.year, myWord.createdAt!.month, myWord.createdAt!.day);

    kEvents[time]!.remove(myWord);
    selectedEvents.value.remove(myWord);

    myWordReposotiry.deleteMyWord(myWord);
    update();
  }

  void updateWord(String word, bool isTrue) {
    myWordReposotiry.updateKnownMyVoca(word, isTrue);
    update();
  }

  void openDialogForchangeFunc() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlipButton(
                    text: '암기 단어',
                    onTap: () {
                      isOnlyKnown = true;
                      isOnlyUnKnown = false;
                      update();
                      Get.back();
                    }),
                const SizedBox(width: 10),
                FlipButton(
                    text: '미암기 단어',
                    onTap: () {
                      isOnlyUnKnown = true;
                      isOnlyKnown = false;
                      update();
                      Get.back();
                    }),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlipButton(
                    text: '모든 단어',
                    onTap: () {
                      isOnlyKnown = false;

                      isOnlyUnKnown = false;
                      update();
                      Get.back();
                    }),
                const SizedBox(width: 10),
                FlipButton(
                    text: '뒤집기',
                    onTap: () {
                      isWordFlip = !isWordFlip;
                      update();
                      Get.back();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  // String aaa () {
  //   if()
  // }

  seeToReverse() {
    isWordFlip = !isWordFlip;

    update();
    Get.back();
  }

  // Initaialize Calendar Things.

  final kToday = DateTime.now();

  CalendarFormat calendarFormat = CalendarFormat.twoWeeks;

  final ValueNotifier<List<MyWord>> selectedEvents = ValueNotifier([]);

  DateTime focusedDay = DateTime.now();
  final Set<DateTime> selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
  );
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<MyWord> getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<MyWord> getEventsForDays(Set<DateTime> days) {
    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  void onFormatChanged(format) {
    if (calendarFormat != format) {
      calendarFormat = format;

      update();
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    focusedDay = focusedDay;
    if (selectedDays.contains(selectedDay)) {
      selectedDays.remove(selectedDay);
    } else {
      selectedDays.add(selectedDay);
    }

    update();

    selectedEvents.value = getEventsForDays(selectedDays);
  }
}
