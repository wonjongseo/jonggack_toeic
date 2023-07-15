// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/screen/setting/setting_screen.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';
import 'package:jonggack_toeic/tts_controller.dart';

import '../common/admob/banner_ad/global_banner_admob.dart';
import 'listen_controller.dart';

// ignore: must_be_immutable
class WordListenScreen extends StatelessWidget {
  late ListenController wordListenController;

  final String chapter;
  WordListenScreen({super.key, required this.chapter}) {
    wordListenController = Get.put(ListenController(chapter: chapter));
  }

  @override
  Widget build(BuildContext context) {
    print('chapter: ${chapter}');
    return WillPopScope(
      onWillPop: () async {
        await wordListenController.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${chapter} 반복 듣기'),
        ),
        body: SafeArea(
          child: GetBuilder<ListenController>(builder: (tController) {
            return tController.words.isEmpty
                ? Container()
                : Column(
                    children: [
                      //
                      Expanded(
                        flex: 1,
                        child:
                            GetBuilder<TtsController>(builder: (ttsController) {
                          return Stack(
                            children: [
                              if (tController.isAutoPlay ||
                                  ttsController.isPlaying)
                                const Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SpinKitWave(
                                      size: 30,
                                      color: Colors.white,
                                    )),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: OutlinedButton(
                                    child: !tController.isAutoPlay
                                        ? const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('자동 재생',
                                                  style: TextStyle(
                                                      color: Colors.green)),
                                              SizedBox(width: 10),
                                              Icon(
                                                Icons.play_arrow,
                                                color: Colors.greenAccent,
                                              )
                                            ],
                                          )
                                        : const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('정지',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              SizedBox(width: 10),
                                              Icon(
                                                Icons.stop,
                                                color: Colors.redAccent,
                                              )
                                            ],
                                          ),
                                    onPressed: () {
                                      if (tController.isAutoPlay) {
                                        tController.autuPlayStop();
                                      } else {
                                        tController.startListenWords();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),

                      Expanded(
                        flex: 10,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 12,
                              child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                onPageChanged: tController.onPageChange,
                                controller: tController.pageController,
                                itemCount: tController.words.length,
                                itemBuilder: (context, index) {
                                  tController.newWord = tController
                                      .words[tController.currentPageIndex];

                                  String mean = tController.newWord!.mean;

                                  String word = tController.newWord!.word;
                                  if (word.contains('·')) {
                                    word = word.split('·')[0];
                                  }

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          word,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                fontSize: 45,
                                                color: Colors.white,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        mean,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${(tController.currentPageIndex) + 1} 번째'),
                                Text('총 ${wordListenController.words.length}개')
                              ],
                            ),
                          ),
                          Slider(
                              label:
                                  '챕터 ${(((tController.currentPageIndex) / 15)).ceil() + 1}',
                              divisions:
                                  wordListenController.words.length ~/ 15,
                              min: 0,
                              max:
                                  wordListenController.words.length.toDouble() -
                                      1,
                              value: tController.currentPageIndex.toDouble(),
                              onChanged: (v) {
                                tController.onPageChange(v.toInt());
                              }),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: tController.ttsController.ttsState ==
                                        TtsState.playing
                                    ? null
                                    : () {
                                        if (tController.currentPageIndex > 0) {
                                          tController.currentPageIndex--;

                                          tController.onPageChange(
                                              tController.currentPageIndex);
                                        } else {
                                          return;
                                        }
                                      },
                                child: const Text(
                                  '<',
                                  style: TextStyle(
                                    color: AppColors.whiteGrey,
                                  ),
                                )),
                            _buildButtonColumn(
                              !tController.isAutoPlay
                                  ? Colors.green
                                  : Colors.red,
                              !tController.isAutoPlay
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              !tController.isAutoPlay
                                  ? Icons.play_arrow
                                  : Icons.stop,
                              !tController.isAutoPlay ? '듣기' : '정지',
                              !tController.isAutoPlay
                                  ? () {
                                      if (tController.newWord != null) {
                                        tController.ttsController.japaneseSpeak(
                                            tController.newWord!);
                                      }
                                    }
                                  : () {
                                      tController.stop();
                                    },
                            ),
                            TextButton(
                              onPressed: tController.ttsController.ttsState ==
                                      TtsState.playing
                                  ? null
                                  : () {
                                      if (tController.currentPageIndex <
                                          wordListenController.words.length -
                                              1) {
                                        tController.currentPageIndex++;

                                        tController.onPageChange(
                                            tController.currentPageIndex);
                                      } else {
                                        return;
                                      }
                                    },
                              child: const Text(
                                '>',
                                style: TextStyle(
                                  color: AppColors.whiteGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<UserController>(builder: (userController) {
                        return SoundOptionColumn(
                            userController: userController);
                      }),

                      const Spacer(),
                    ],
                  );
          }),
        ),
        bottomNavigationBar: const GlobalBannerAdmob(),
      ),
    );
  }

  Widget _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
            ),
          )
        ]);
  }

  Widget _getMaxSpeechInputLengthSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text('Get max speech input length'),
          onPressed: () async {
            wordListenController.ttsController.inputLength =
                await wordListenController
                    .ttsController.flutterTts.getMaxSpeechInputLength;
            // setState(() {});
          },
        ),
        Text("$wordListenController.ttsController.inputLength characters"),
      ],
    );
  }
}

class SoundOptionColumn extends StatelessWidget {
  const SoundOptionColumn({
    super.key,
    required this.userController,
  });

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SoundSettingSlider(
          activeColor: Colors.redAccent,
          option: '음량',
          value: userController.volumn,
          label: '음량: ${userController.volumn}',
          onChangeEnd: (value) {
            userController.updateSoundValues(SOUND_OPTIONS.VOLUMN, value);
          },
          onChanged: (value) {
            userController.onChangedSoundValues(SOUND_OPTIONS.VOLUMN, value);
          },
        ),
        SoundSettingSlider(
          activeColor: Colors.blueAccent,
          option: '음조',
          value: userController.pitch,
          label: '음조: ${userController.pitch}',
          onChangeEnd: (value) {
            userController.updateSoundValues(SOUND_OPTIONS.PITCH, value);
          },
          onChanged: (value) {
            userController.onChangedSoundValues(SOUND_OPTIONS.PITCH, value);
          },
        ),
        SoundSettingSlider(
          activeColor: Colors.deepPurpleAccent,
          option: '속도',
          value: userController.rate,
          label: '속도: ${userController.rate}',
          onChangeEnd: (value) {
            userController.updateSoundValues(SOUND_OPTIONS.RATE, value);
          },
          onChanged: (value) {
            userController.onChangedSoundValues(SOUND_OPTIONS.RATE, value);
          },
        ),
      ],
    );
  }
}
