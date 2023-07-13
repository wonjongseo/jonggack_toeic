import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/app_constant.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';

import 'package:jonggack_toeic/config/colors.dart';

bool isKangi(String word) {
  return word.compareTo('一') >= 0 && word.compareTo('龥') <= 0;
}

bool isKatakana(String word) {
  return word.compareTo('\u30A0') >= 0 && word.compareTo('\u30FF') <= 0;
}

void getBacks(int count) {
  for (int i = 0; i < count; i++) {
    Get.back();
  }
}

Future<bool> alertSetting(
    {required String title, required String content}) async {
  return await Get.dialog(
    barrierDismissible: false,
    AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.scaffoldBackground,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(color: AppColors.scaffoldBackground),
      ),
      actions: [
        OutlinedButton(
            onPressed: () => Get.back(result: true), child: const Text('네')),
        OutlinedButton(
            onPressed: () => Get.back(result: false), child: const Text('아니요'))
      ],
    ),
  );
}

// 광고를 볼지 물어보고 하트를 제공
Future<bool> askToWatchMovieAndGetHeart(
    {Text? title,
    Text? content,
    List<String>? contentStrings = const ['네', '아니요']}) async {
  bool result = await Get.dialog(
    AlertDialog(
      title: title,
      titleTextStyle: TextStyle(
          fontSize: Dimentions.width18, color: AppColors.scaffoldBackground),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (content != null) content,
          SizedBox(height: Dimentions.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: threeWordButtonWidth,
                child: ElevatedButton(
                    onPressed: () => Get.back(result: true),
                    child: Text(contentStrings![0])),
              ),
              SizedBox(
                width: threeWordButtonWidth,
                child: ElevatedButton(
                    onPressed: () => Get.back(result: false),
                    child: Text(contentStrings[1])),
              ),
            ],
          )
        ],
      ),
    ),
    barrierDismissible: false,
  );

  return result;
}

Future<bool> reallyQuitText() async {
  bool result = await askToWatchMovieAndGetHeart(
      title: const Text('테스트를 그만두시겠습니까?'),
      content: const Text(
        '테스트 중간에 나가면 점수가 기록되지 않습니다. 그래도 나가시겠습니까?',
        style: TextStyle(color: AppColors.scaffoldBackground),
      ));

  return result;
}

void copyWord(String text) {
  Clipboard.setData(ClipboardData(text: text));

  if (!Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'Copied',
      '$text가 복사(Ctrl + C) 되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(seconds: 2),
    );
  }
}
