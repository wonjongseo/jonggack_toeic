import 'dart:developer';

import 'package:flutter/foundation.dart';

class AdUnitId {
  Map<String, String> appOpen = {};
  Map<String, String> banner = {};
  Map<String, String> interstitial = {};
  Map<String, String> interstitialVideo = {};
  Map<String, String> rewarded = {};
  Map<String, String> rewardedInterstitial = {};
  Map<String, String> nativeAdvanced = {};
  Map<String, String> nativeAdvancedVideo = {};

  AdUnitId() {
    if (kReleaseMode) {
      log('kReleaseMode == true');
      appOpen = {
        'ios': 'ca-app-pub-9712392194582442/9190689539',
        'android': 'ca-app-pub-9712392194582442/3372538020'
      };

      banner = {
        'ios': 'ca-app-pub-9712392194582442~1255126638', // ok
        'android': 'ca-app-pub-9712392194582442/7058112149'
      };
      interstitial = {
        'ios': 'ca-app-pub-9712392194582442~1255126638', // ok
        'android': 'ca-app-pub-9712392194582442/1593160337'
      };
      interstitialVideo = {
        'ios': 'ca-app-pub-9712392194582442~1255126638', // ok
        'android': 'ca-app-pub-9712392194582442/1593160337'
      };
      rewarded = {
        'ios': 'ca-app-pub-9712392194582442~1255126638', // ok
        'android': 'ca-app-pub-9712392194582442/2875324550'
      };

      rewardedInterstitial = {
        'ios': 'ca-app-pub-9712392194582442~1255126638', // ok
        'android': 'ca-app-pub-9712392194582442/5374044122'
      };
      nativeAdvanced = {
        'ios': 'ca-app-pub-9712392194582442~1255126638', // ok
        'android': 'ca-app-pub-9712392194582442/8519082211'
      };
      nativeAdvancedVideo = {
        'ios': 'ca-app-pub-9712392194582442~1255126638', // ok
        'android': 'ca-app-pub-9712392194582442/8519082211'
      };
      // 전면
    } else {
      log('kReleaseMode == false');
      appOpen = {
        'ios': 'ca-app-pub-3940256099942544/5662855259',
        'android': 'ca-app-pub-3940256099942544/3419835294'
      };
      banner = {
        'ios': 'ca-app-pub-3940256099942544/2934735716',
        'android': 'ca-app-pub-3940256099942544/6300978111'
      };
      interstitial = {
        'ios': 'ca-app-pub-3940256099942544/4411468910',
        'android': 'ca-app-pub-3940256099942544/1033173712'
      };
      interstitialVideo = {
        'ios': 'ca-app-pub-3940256099942544/5135589807',
        'android': 'ca-app-pub-3940256099942544/8691691433'
      };
      rewarded = {
        'ios': 'ca-app-pub-3940256099942544/1712485313',
        'android': 'ca-app-pub-3940256099942544/5224354917'
      };

      rewardedInterstitial = {
        'ios': 'ca-app-pub-3940256099942544/6978759866',
        'android': 'ca-app-pub-3940256099942544/5354046379'
      };
      nativeAdvanced = {
        'ios': 'ca-app-pub-3940256099942544/3986624511',
        'android': 'ca-app-pub-3940256099942544/2247696110'
      };
      nativeAdvancedVideo = {
        'ios': 'ca-app-pub-3940256099942544/2521693316',
        'android': 'ca-app-pub-3940256099942544/1044960115'
      };
    }
  }
}
