import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jonggack_toeic/screen/user/controller/user_controller.dart';

import '../ad_unit_id.dart';

class GlobalBannerAdmob extends StatefulWidget {
  const GlobalBannerAdmob({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GlobalBannerAdmobState();
  }
}

class _GlobalBannerAdmobState extends State<GlobalBannerAdmob> {
  UserController userController = Get.find<UserController>();
  BannerAd? _bannerAd;
  AdUnitId adUnitId = AdUnitId();
  bool _bannerReady = false;

  @override
  void initState() {
    super.initState();
    if (userController.isUserPremieum()) {
      _bannerAd = null;
      return;
    }

    _bannerAd = BannerAd(
      adUnitId: adUnitId.banner[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
      // size: AdSize.banner,
      // size: AdSize.largeBanner,
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _bannerReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          setState(() {
            _bannerReady = false;
          });
          ad.dispose();
        },
      ),
    );
    _bannerAd!.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd == null) {
      return Container(height: 0);
    }

    return _bannerReady
        ? SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          )
        : Container(height: 0);
  }
}
