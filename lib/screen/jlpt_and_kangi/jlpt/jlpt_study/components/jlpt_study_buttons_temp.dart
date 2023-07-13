import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/app_constant.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';
import 'package:jonggack_toeic/tts_controller.dart';

import '../jlpt_study_controller_temp.dart';

class JlptStudyButtonsTemp extends StatelessWidget {
  const JlptStudyButtonsTemp({
    Key? key,
    required this.wordController,
  }) : super(key: key);

  final JlptStudyControllerTemp wordController;
  @override
  Widget build(BuildContext context) {
    double buttonWidth = threeWordButtonWidth;
    double buttonHeight = 55;
    return GetBuilder<TtsController>(builder: (ttsController) {
      return Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: ttsController.disalbe
                      ? null
                      : () async {
                          await wordController.nextWord(false);
                        },
                  child: Text(
                    '몰라요',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimentions.width15,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimentions.width10),
              ZoomOut(
                animate: wordController.isShownMean,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!wordController.isShownMean) {
                        wordController.showMean();
                      }
                    },
                    child: Text(
                      '의미',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimentions.width15,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimentions.width10),
              SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: ttsController.disalbe
                      ? null
                      : () async {
                          await wordController.nextWord(true);
                        },
                  child: Text(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          )
        ],
      );
    });
  }
}
