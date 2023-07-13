import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/config/theme.dart';
import 'package:jonggack_toeic/screen/grammar/grammar_test/components/grammar_example_card.dart';
import 'package:jonggack_toeic/model/grammar.dart';

import '../../../common/admob/controller/ad_controller.dart';
import '../../../common/app_constant.dart';
import '../../../common/common.dart';
import '../../../common/widget/dimentions.dart';
import '../../../tts_controller.dart';
import '../../user/controller/user_controller.dart';
import 'grammar_description_card.dart';

// ignore: must_be_immutable
class GrammarCard extends StatefulWidget {
  GrammarCard({
    super.key,
    this.onPress,
    this.onPressLike,
    required this.grammar,
  });

  VoidCallback? onPress;
  final Grammar grammar;
  VoidCallbackIntent? onPressLike;

  @override
  State<GrammarCard> createState() => _GrammarCardState();
}

class _GrammarCardState extends State<GrammarCard> {
  UserController userController = Get.find<UserController>();
  AdController adController = Get.find<AdController>();
  TtsController ttsController = Get.find<TtsController>();
  bool isClick = false;
  bool isClickExample = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: AnimatedSize(
        alignment: const Alignment(0, -1),
        duration: const Duration(milliseconds: 500),
        child: InkWell(
          onTap: () {
            isClick = !isClick;
            isClickExample = false;
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.scaffoldBackground.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(1, 1),
                )
              ],
              borderRadius: BorderRadius.circular(Dimentions.height20),
            ),
            child: Column(
              children: [
                Text(
                  widget.grammar.grammar,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.scaffoldBackground,
                    fontFamily: AppFonts.japaneseFont,
                  ),
                ),
                Visibility(
                  visible: isClick,
                  child: Divider(height: Dimentions.height20),
                ),
                Visibility(
                  visible: isClick,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.grammar.connectionWays.isNotEmpty)
                        GrammarDescriptionCard(
                            fontSize: size.width / 300 + 11,
                            title: '접속 형태',
                            content: widget.grammar.connectionWays),
                      if (widget.grammar.connectionWays.isNotEmpty)
                        const Divider(height: 20),
                      if (widget.grammar.means.isNotEmpty)
                        GrammarDescriptionCard(
                            fontSize: size.width / 300 + 12,
                            title: '뜻',
                            content: widget.grammar.means),
                      if (widget.grammar.means.isNotEmpty)
                        const Divider(height: 20),
                      if (widget.grammar.description.isNotEmpty)
                        GrammarDescriptionCard(
                            fontSize: size.width / 300 + 13,
                            title: '설명',
                            content: widget.grammar.description),
                      Divider(height: Dimentions.height20),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.scaffoldBackground
                                      .withOpacity(0.3),
                                  blurRadius: 1,
                                  offset: const Offset(1, 1),
                                ),
                                BoxShadow(
                                  color: AppColors.scaffoldBackground
                                      .withOpacity(0.3),
                                  blurRadius: 1,
                                  offset: const Offset(-1, -1),
                                )
                              ],
                              borderRadius:
                                  BorderRadius.circular(Dimentions.height10)),
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(Dimentions.height30 / 2),
                            child: const Text(
                              '예제',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (await userController.useHeart()) {
                            await Get.bottomSheet(
                              backgroundColor: AppColors.scaffoldBackground,
                              Padding(
                                padding: EdgeInsets.all(Dimentions.height16)
                                    .copyWith(right: 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...List.generate(
                                            widget.grammar.examples.length,
                                            (index) {
                                          return GrammarExampleCard(
                                            example:
                                                widget.grammar.examples[index],
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                            ttsController.stop();
                          } else {
                            bool result = await askToWatchMovieAndGetHeart(
                              title: const Text('하트가 부족해요!!'),
                              content: const Text(
                                  '광고를 시청하고 하트 ${AppConstant.HERAT_COUNT_AD}개를 채우시겠습니까 ?',
                                  style: TextStyle(
                                      color: AppColors.scaffoldBackground)),
                            );

                            if (result) {
                              adController.showRewardedAd();
                              userController.plusHeart(
                                  plusHeartCount: AppConstant.HERAT_COUNT_AD);
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
