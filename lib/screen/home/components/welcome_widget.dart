import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/config/theme.dart';
import 'package:jonggack_toeic/screen/setting/setting_screen.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
    this.settingKey,
    required this.isUserPremieum,
    required this.scaffoldKey,
  });

  final GlobalKey? settingKey;
  final GlobalKey? scaffoldKey;
  final bool isUserPremieum;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimentions.height153,
      padding: EdgeInsets.only(
        top: Dimentions.height14,
        left: Dimentions.width22,
        right: Dimentions.width22,
      ),
      decoration: BoxDecoration(
          color: AppColors.whiteGrey,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimentions.height30),
            bottomRight: Radius.circular(Dimentions.height30),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning!',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.scaffoldBackground,
                      fontWeight: FontWeight.w800,
                      fontSize: isUserPremieum
                          ? Dimentions.width20
                          : Dimentions.width18,
                      fontFamily: AppFonts.japaneseFont,
                    ),
              ),
              SizedBox(height: Dimentions.height10),
              Row(
                children: [
                  Text(
                    'Welcome to ',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColors.scaffoldBackground,
                          fontWeight: FontWeight.w800,
                          fontSize: isUserPremieum
                              ? Dimentions.width20
                              : Dimentions.width18,
                          fontFamily: AppFonts.japaneseFont,
                        ),
                  ),
                  Text(
                    // key: welcomeKey,
                    isUserPremieum ? 'TOEIC 종각 Plus' : 'TOEIC 종각',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: isUserPremieum
                              ? Dimentions.width24
                              : Dimentions.width20,
                          fontFamily: AppFonts.nanumGothic,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                key: settingKey,
                onPressed: () {
                  Get.toNamed(SETTING_PATH);
                },
                icon: Icon(
                  Icons.settings,
                  size: Dimentions.width24,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
