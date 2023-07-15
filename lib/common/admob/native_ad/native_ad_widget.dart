import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jonggack_toeic/common/widget/book_card.dart';

import '../../../config/colors.dart';
import '../../../screen/user/controller/user_controller.dart';
import '../ad_unit_id.dart';

class NativeAdWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NativeAdState();
}

class NativeAdState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  final Completer<NativeAd> nativeAdCompleter = Completer<NativeAd>();
  AdUnitId adUnitId = AdUnitId();

  UserController userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    if (userController.isUserPremieum()) {
      _nativeAd = null;
      return;
    }
    _nativeAd = NativeAd(
      adUnitId: adUnitId.nativeAdvanced[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(nonPersonalizedAds: true),
      customOptions: <String, Object>{},
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white12,
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: AppColors.scaffoldBackground,
          backgroundColor: Colors.white70,
        ),
      ),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          nativeAdCompleter.complete(ad as NativeAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError err) {
          ad.dispose();
          nativeAdCompleter.completeError('Err');
        },
        onAdOpened: (Ad ad) => log('$ad onAdOpened.'),
        onAdClosed: (Ad ad) => log('$ad onAdClosed.'),
      ),
    );

    _nativeAd?.load();
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd?.dispose();
    _nativeAd = null;
  }

  @override
  Widget build(BuildContext context) {
    if (_nativeAd == null) {
      return Container(height: 0);
    }
    return FutureBuilder<NativeAd>(
      future: nativeAdCompleter.future,
      builder: (BuildContext context, AsyncSnapshot<NativeAd> snapshot) {
        Widget child;

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            child = BookCard(level: 1, isAllFinished: false, onTap: () {});
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              child = AdWidget(ad: _nativeAd!);
            } else {
              child = const Text('Error loading ad');
            }
        }

        return Container(
          height: 330,
          child: child,
          color: const Color(0xFFFFFFFF),
        );
      },
    );
  }
}
