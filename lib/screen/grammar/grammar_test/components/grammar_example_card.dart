import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:jonggack_toeic/common/widget/dimentions.dart';
import 'package:jonggack_toeic/model/example.dart';
import 'package:jonggack_toeic/tts_controller.dart';

import '../../../../config/theme.dart';

class GrammarExampleCard extends StatefulWidget {
  const GrammarExampleCard({super.key, required this.example});
  final Example example;
  @override
  State<GrammarExampleCard> createState() => _GrammarExampleCardState();
}

class _GrammarExampleCardState extends State<GrammarExampleCard> {
  bool isClick = false;

  TtsController ttsController = Get.find<TtsController>();
  @override
  Widget build(BuildContext context) {
    double fontSize = Dimentions.width17;

    return Padding(
      padding: EdgeInsets.only(bottom: Dimentions.height16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                    onTap: isClick != false
                        ? null
                        : () {
                            isClick = true;
                            setState(() {});
                          },
                    child: Text(
                      widget.example.word,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontFamily: AppFonts.japaneseFont,
                      ),
                    )),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      ttsController.speak(widget.example.word);
                    },
                    icon: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
          if (isClick)
            ZoomIn(
              child: Text(
                widget.example.mean,
                style: TextStyle(
                    color: Colors.grey, fontSize: Dimentions.height16),
              ),
            ),
        ],
      ),
    );
  }
}
