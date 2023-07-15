import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jonggack_toeic/common/admob/ad_unit_id.dart';

class TestBannerAdController extends GetxController {
  @override
  void onClose() {
    if (testBanner != null) {
      testBanner!.dispose();
      testBanner = null;
    }
    super.onClose();
  }

  AdUnitId adUnitId = AdUnitId();

  BannerAd? testBanner;
  bool loadingTestBanner = false;

  Future<void> createTestBanner() async {
    testBanner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('onTestAdLoaded');
          loadingTestBanner = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('onTestAdFailedToLoad');
          ad.dispose();
        },
        onAdOpened: (ad) => log('onTestAdOpened'),
        onAdClosed: (ad) => log('onTestAdClosed'),
      ),
      // size: AdSize.banner,
      size: AdSize.fullBanner,
      adUnitId: adUnitId.banner[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
    )..load();
  }
}

class BannerContainer extends StatelessWidget {
  const BannerContainer({super.key, this.bannerAd});
  final BannerAd? bannerAd;
  @override
  Widget build(BuildContext context) {
    return bannerAd != null
        ? SizedBox(
            width: bannerAd!.size.width.toDouble(),
            height: bannerAd!.size.height.toDouble(),
            child: AdWidget(
              ad: bannerAd!,
            ),
          )
        : Container(height: 0);
  }
}
