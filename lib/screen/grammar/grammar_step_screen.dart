import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/widget/heart_count.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/screen/grammar/controller/grammar_controller.dart';
import 'package:jonggack_toeic/model/jlpt_step.dart';
import 'package:jonggack_toeic/common/repository/local_repository.dart';
import '../../common/admob/banner_ad/global_banner_admob.dart';

// ignore: must_be_immutable
class GrammarStepSceen extends StatelessWidget {
  GrammarStepSceen({super.key, required this.level});

  final String level;
  late bool isSeenTutorial;

  @override
  Widget build(BuildContext context) {
    isSeenTutorial = LocalReposotiry.isSeenGrammarTutorial();
    Get.put(GrammarController(level: level));

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('N$level급 문법'),
        actions: const [HeartCount()],
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: _body(width, context),
    );
  }

  GetBuilder<GrammarController> _body(double width, BuildContext context) {
    return GetBuilder<GrammarController>(
      builder: (controller) {
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          children: List.generate(
            controller.grammers.length,
            (subStep) {
              if (subStep == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: InkWell(
                      onTap: () =>
                          controller.goToSturyPage(subStep, isSeenTutorial),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/calender.svg',
                            color: controller.isSuccessedAllGrammar(subStep)
                                ? AppColors.lightGreen
                                : Colors.white,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: width / 20),
                              Padding(
                                padding: EdgeInsets.only(top: width / 30),
                                child: Text(
                                    (controller.grammers[subStep].step + 1)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                          fontSize: (width / 10),
                                        )),
                              ),
                              SizedBox(height: width / 100),
                              Center(
                                child: Text(
                                  '${controller.grammers[subStep].scores.toString()} / ${controller.grammers[subStep].grammars.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: width / 40,
                                      ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InkWell(
                    // 이전 챕터를  풀었야만 접속 가능.
                    onTap: controller.isFinishedPreviousSubStep(subStep)
                        ? () {
                            if (!controller.restrictN1SubStep(subStep)) {
                              controller.goToSturyPage(subStep, isSeenTutorial);
                            }
                          }
                        : null,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/calender.svg',
                          color: controller.isSuccessedAllGrammar(subStep)
                              ? AppColors.lightGreen
                              : controller.isFinishedPreviousSubStep(subStep)
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.2),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: width / 20),
                            Padding(
                              padding: EdgeInsets.only(top: width / 30),
                              child: Text(
                                  (controller.grammers[subStep].step + 1)
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontSize: (width / 10),
                                        color: controller
                                                .isFinishedPreviousSubStep(
                                                    subStep)
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.2),
                                      )),
                            ),
                            SizedBox(height: width / 100),
                            Center(
                              child: Text(
                                '${controller.grammers[subStep].scores.toString()} / ${controller.grammers[subStep].grammars.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color:
                                          controller.isFinishedPreviousSubStep(
                                                  subStep)
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.2),
                                    ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              );
            },
          ),
        );
      },
    );
  }
}
