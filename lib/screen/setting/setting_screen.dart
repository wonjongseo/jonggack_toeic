import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/common.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';
import '../../common/admob/banner_ad/global_banner_admob.dart';
import 'services/setting_controller.dart';
import 'components/setting_button.dart';
import 'components/setting_switch.dart';

const SETTING_PATH = '/setting';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.find<SettingController>();
    return WillPopScope(
      child: Scaffold(
        appBar: _appBar(settingController),
        body: _body(settingController.userController),
        bottomNavigationBar: const GlobalBannerAdmob(),
      ),
      onWillPop: () async {
        if (settingController.isInitial) {
          Get.dialog(const AlertDialog(
            content: Text(
              '앱을 종료 후 다시 켜주세요.',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ));
        }
        return true;
      },
    );
  }

  SingleChildScrollView _body(UserController userController) {
    return SingleChildScrollView(
      child: Center(
        child: GetBuilder<SettingController>(
          builder: (settingController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...[
                  SettingSwitch(
                    isOn: settingController.isAutoSave,
                    onChanged: (value) => settingController.flipAutoSave(),
                    text: '모름 / 틀림 단어 자동 저장',
                  ),
                  SettingSwitch(
                    isOn: settingController.isEnabledEnglishSound,
                    onChanged: (value) =>
                        settingController.flipEnabledJapaneseSound(),
                    text: '자동으로 발음 (영어) 음성 듣기',
                  ),
                  const Divider(height: 30),
                  GetBuilder<UserController>(builder: (controller) {
                    return Column(
                      children: [
                        SoundSettingSlider(
                          activeColor: Colors.redAccent,
                          option: '음량',
                          value: userController.volumn,
                          label: '음량: ${userController.volumn}',
                          onChangeEnd: (value) {
                            userController.updateSoundValues(
                                SOUND_OPTIONS.VOLUMN, value);
                          },
                          onChanged: (value) {
                            userController.onChangedSoundValues(
                                SOUND_OPTIONS.VOLUMN, value);
                          },
                        ),
                        SoundSettingSlider(
                          activeColor: Colors.blueAccent,
                          option: '음조',
                          value: userController.pitch,
                          label: '음조: ${userController.pitch}',
                          onChangeEnd: (value) {
                            userController.updateSoundValues(
                                SOUND_OPTIONS.PITCH, value);
                          },
                          onChanged: (value) {
                            userController.onChangedSoundValues(
                                SOUND_OPTIONS.PITCH, value);
                          },
                        ),
                        SoundSettingSlider(
                          activeColor: Colors.deepPurpleAccent,
                          option: '속도',
                          value: userController.rate,
                          label: '속도: ${userController.rate}',
                          onChangeEnd: (value) {
                            userController.updateSoundValues(
                                SOUND_OPTIONS.RATE, value);
                          },
                          onChanged: (value) {
                            userController.onChangedSoundValues(
                                SOUND_OPTIONS.RATE, value);
                          },
                        ),
                      ],
                    );
                  }),
                ],
                ...[
                  const SizedBox(height: 10),
                  SettingButton(
                    onPressed: () => settingController.initJlptWord(),
                    text: '단어 초기화 (단어 섞기)',
                  ),
                  SettingButton(
                    text: '나만의 단어 초기화',
                    onPressed: () => settingController.initMyWords(),
                  ),
                  SettingButton(
                    text: '앱 설명 보기',
                    onPressed: () => settingController.initAppDescription(),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar _appBar(SettingController settingController) {
    return AppBar(
      title: const Text('설정'),
    );
  }
}

class SoundSettingSlider extends StatelessWidget {
  const SoundSettingSlider({
    super.key,
    required this.value,
    required this.option,
    required this.label,
    required this.activeColor,
    required this.onChangeEnd,
    required this.onChanged,
  });

  final double value;
  final String option;
  final String label;
  final Color activeColor;
  final Function(double) onChangeEnd;
  final Function(double) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(option),
          Expanded(
            child: Slider(
              value: value,
              onChangeEnd: (v) {
                onChangeEnd(v);
              },
              onChanged: onChanged,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              activeColor: activeColor,
              label: label,
            ),
          )
        ],
      ),
    );
  }
}
