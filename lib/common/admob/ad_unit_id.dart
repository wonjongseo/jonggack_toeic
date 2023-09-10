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
        'ios': 'ca-app-pub-9712392194582442/7390162283', // ok
        'android': 'ca-app-pub-9712392194582442/6805129924' // ok
      };
      interstitial = {
        'ios': 'ca-app-pub-9712392194582442/4630199200', // ok
        'android': 'ca-app-pub-9712392194582442/4081342787' // ok
      };
      interstitialVideo = {
        'ios': 'ca-app-pub-9712392194582442/4630199200', // ok
        'android': 'ca-app-pub-9712392194582442/4081342787' // ok
      };
      rewarded = {
        'ios': 'ca-app-pub-9712392194582442/9334950720', // ok
        'android': 'ca-app-pub-9712392194582442/1744374930' // ok
      };

      rewardedInterstitial = {
        'ios': 'ca-app-pub-9712392194582442/8217310179', // ok
        'android': 'ca-app-pub-9712392194582442/3666409811' // ok
      };
      nativeAdvanced = {
        'ios': 'ca-app-pub-9712392194582442/1456460702', //ok
        'android': 'ca-app-pub-9712392194582442/4569531593' // ok
      };
      nativeAdvancedVideo = {
        'ios': 'ca-app-pub-9712392194582442/1456460702', //ok
        'android': 'ca-app-pub-9712392194582442/4569531593' // ok
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
