// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jonggack_toeic/common/common.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/config/theme.dart';
import 'package:jonggack_toeic/model/Question.dart';

class GrammarTestCard extends StatefulWidget {
  GrammarTestCard(
      {Key? key,
      required this.questionIndex,
      required this.question,
      this.onChanged,
      required this.size,
      this.isCorrect = false,
      this.isSubmitted = false})
      : super(key: key);

  final int questionIndex;
  final Size size;
  final Question question;
  Function(int)? onChanged;

  final bool isCorrect;
  final bool isSubmitted;

  @override
  State<GrammarTestCard> createState() => _GrammarTestCardState();
}

class _GrammarTestCardState extends State<GrammarTestCard> {
  String selectedAnswer = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    String question = widget.question.question.word;
    return Padding(
      padding: EdgeInsets.only(right: 0, bottom: Dimentions.height60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // [제출] 버튼을 눌렀을 시
              if (widget.isSubmitted)
                Stack(
                  children: [
                    // 문제를 맞춤
                    if (widget.isCorrect)
                      Container(
                        width: Dimentions.height30,
                        height: Dimentions.height30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 3),
                        ),
                      )
                    // 문제를 틀림.
                    else
                      SvgPicture.asset(
                        'assets/svg/incorrect-icon.svg',
                        height: 25,
                        width: 25,
                      ),
                    // 1. OR 2.
                    questionNumberText(),
                  ],
                )
              else
                // 1. OR 2.
                questionNumberText(),
              // 문법 문제
              Expanded(
                child: InkWell(
                  onTap: () => copyWord(question),
                  child: Text(
                    question,
                    style: TextStyle(
                      color: AppColors.scaffoldBackground,
                      fontWeight: FontWeight.w700,
                      fontSize: Dimentions.width16,
                      fontFamily: AppFonts.japaneseFont,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 제출 되었으면 정답 공개.
          if (widget.isSubmitted)
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, bottom: 8, right: 10, top: 8),
              child: Text(
                'widget.question.question.yomikata',
                style: TextStyle(
                  color: AppColors.scaffoldBackground,
                  fontSize: Dimentions.width14,
                ),
              ),
            ),

          // 사지선다 버튼.
          Column(
            children: List.generate(
              widget.question.options.length,
              (index2) {
                String value =
                    '${index2 + 1}.  ${widget.question.options[index2].mean}';

                if (widget.isSubmitted) {
                  late Color color;
                  if (widget.isCorrect) {
                    // 맞으면 버튼 파란색
                    color = Colors.blue;
                  } else {
                    // 틀리면 버튼 빨간색 변경
                    color = Colors.red;
                  }
                  // 문제의 정답 보기.
                  if (widget.question.answer == index2) {
                    return ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                      title: Text(
                        value,
                        style: const TextStyle(
                          color: AppColors.scaffoldBackground,
                          fontFamily: AppFonts.japaneseFont,
                        ),
                      ),
                      leading: Radio<String>(
                        groupValue: value,
                        value: value,
                        activeColor: color,
                        focusColor: color,
                        onChanged: (String? value) {
                          if (widget.onChanged != null) {
                            widget.onChanged!(index2);
                            setState(() {
                              selectedAnswer = value!;
                            });
                          }
                        },
                      ),
                    );
                  } else {
                    // 문제의 정답 보기 외.
                    // 없애면 안됨.
                    return ListTile(
                      title: Text(
                        value,
                        style: const TextStyle(
                          color: AppColors.scaffoldBackground,
                          fontFamily: AppFonts.japaneseFont,
                        ),
                      ),
                      leading: Radio<String>(
                        groupValue: '',
                        value: value,
                        onChanged: (String? value) {
                          if (widget.isSubmitted == false) {
                            if (widget.onChanged != null) {
                              widget.onChanged!(index2);
                              setState(() {
                                selectedAnswer = value!;
                              });
                            }
                          }
                        },
                      ),
                    );
                  }
                } else {
                  // 제출 되기 전
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: InkWell(
                      onTap: () {
                        if (widget.isSubmitted == false) {
                          widget.onChanged!(index2);
                          setState(() {
                            selectedAnswer = value;
                          });
                        }
                      },
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: AppColors.scaffoldBackground,
                          fontFamily: AppFonts.japaneseFont,
                        ),
                      ),
                    ),
                    leading: Radio<String>(
                      groupValue: selectedAnswer,
                      value: value,
                      activeColor: AppColors.scaffoldBackground,
                      focusColor: AppColors.scaffoldBackground,
                      onChanged: (String? value) {
                        if (widget.isSubmitted == false) {
                          widget.onChanged!(index2);
                          setState(() {
                            selectedAnswer = value!;
                          });
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding questionNumberText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '${widget.questionIndex + 1}. ',
        style: const TextStyle(
          fontSize: 25,
          color: AppColors.scaffoldBackground,
        ),
      ),
    );
  }
}
