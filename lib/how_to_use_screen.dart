import 'package:flutter/material.dart';
import 'package:jonggack_toeic/common/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_toeic/common/widget/dimentions.dart';
import 'package:jonggack_toeic/config/colors.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({super.key});

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  late PageController pageController;
  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int newPageIndex) {
    currentPageIndex = newPageIndex;
    setState(() {});
  }

  List<Widget> pages = const [
    EngineerSaid(),
    AppPageImage(imageName: '학습페이지.png'),
    StudyPageDescription(),
    AppPageImage(imageName: '시험페이지.png'),
    TestPageDescription(),
    ScorePageDescription(),
    AppPageImage(imageName: '자주 틀리는 문제 페이지.png'),
    UsuallyWrongWordPageDescription(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const GlobalBannerAdmob(),
      appBar: AppBar(
        title: const Text('JLPT 종각 사용법'),
      ),
      body: Container(
        color: AppColors.whiteGrey,
        padding: EdgeInsets.symmetric(
          vertical: Dimentions.height10 / 1,
          horizontal: Dimentions.width10,
        ),
        margin: EdgeInsets.symmetric(
          vertical: Dimentions.height10,
          horizontal: Dimentions.width10,
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: pages.length,
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),
              SizedBox(height: Dimentions.height10),
              if (currentPageIndex == 0)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () {
                        currentPageIndex++;
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.black,
                      ),
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              Row(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentPageIndex != 0)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () {
                            currentPageIndex--;
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.black,
                          ),
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  if (currentPageIndex != 0 &&
                      currentPageIndex != pages.length - 1)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () {
                            currentPageIndex++;
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.black,
                          ),
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppPageImage extends StatelessWidget {
  const AppPageImage({super.key, required this.imageName});

  final String imageName;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          imageName.split('.png')[0],
          style: const TextStyle(
            color: AppColors.scaffoldBackground,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Dimentions.height40),
        Container(
          width: double.infinity / 1.5,
          height: 400,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/$imageName',
            ),
          )),
        ),
      ],
    );
  }
}

class EngineerSaid extends StatelessWidget {
  const EngineerSaid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimentions.height10),
          const Text(
            'JLPT 종각 앱 사용 방법에 앞서.',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.scaffoldBackground),
          ),
          SizedBox(height: Dimentions.height20),
          const Text.rich(
            TextSpan(
              style: TextStyle(
                  height: 1.6,
                  wordSpacing: 1.2,
                  color: AppColors.scaffoldBackground),
              children: [
                TextSpan(text: ' 개발자 본인은 일본어뿐만 아니라 모든 외국어의 학습에 가장 중요한 부분은 '),
                TextSpan(
                  text: '어휘력',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '이라고 생각합니다.\n\n'),
                TextSpan(text: ' 많은 블로그나 유튜브에서 외국어 공부법 혹은 외국어 단어 암기법이라고 검색하면 '),
                TextSpan(text: '어휘력이 중요하다고 강조하고 있고, 어휘력은 단순 암기이기 때문에 '),
                TextSpan(
                  text: '잊어 버리지 않도록 반복 학습',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '이 중요하다는 것도 강조하고 있는 것을 볼 수 있습니다.\n\n'),
                TextSpan(text: ' 그래서 '),
                TextSpan(
                  text: 'JLPT 종각',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '은 '),
                TextSpan(
                  text: '반복 학습',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '에 중점을 두었습니다.'),
                TextSpan(text: '\n\n\n'),
                TextSpan(text: '또한 일본어 학습에는 '),
                TextSpan(
                  text: '한자',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '도 중요합니다.\n\n'),
                TextSpan(text: ' 일본어를 그대로 학습하는 것보다도 '),
                TextSpan(
                  text: '훈독과 음독',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 을 먼저 암기하고 일본어를 학습하면  '),
                TextSpan(
                  text: '학습력이 2배 이상',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 증가한다고 생각합니다.\n\n'),
                TextSpan(
                    text:
                        ' 처음 보는 일본어라도 해당 일본어의 한자를 알고 있다면, 그 뜻을 추측할 수 있기 때문에 '),
                TextSpan(
                  text: '독해',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '에서도 '),
                TextSpan(
                  text: '큰 이점',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '이 될 것입니다.'),
                TextSpan(text: '\n\n'),
                TextSpan(
                    text:
                        ' 그래서 JLPT 종각은 일본어뿐만 아니라, N5급부터 N1급의 한자를 별도로 학습할 수 있고, JLPT N5급부터 N1급의 단어를 학습하면서도 '),
                TextSpan(
                  text: '한자를 클릭해서 바로바로',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 해당 한자의 의미와 훈독과 음독을 학습할 수 있게 제작하였습니다. '),
                TextSpan(
                  text: '(준비되어 있지 않는 한자도 존재함)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StudyPageDescription extends StatelessWidget {
  const StudyPageDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimentions.height10),
          const Text(
            '학습 페이지',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.scaffoldBackground),
          ),
          SizedBox(height: Dimentions.height20),
          const Text.rich(
            TextSpan(
              style: TextStyle(
                  height: 1.6,
                  wordSpacing: 1.2,
                  color: AppColors.scaffoldBackground),
              children: [
                TextSpan(text: ' 학습 페이지에서 먼저 자신이 '),
                TextSpan(
                  text: '알고 있는 단어',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '인지, '),
                TextSpan(
                  text: '모르는 단어',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '인지를 가볍게 확인합니다.\n\n'),
                TextSpan(
                  text: '그 후 모르는 단어를 다시 한번 더 확인합니다.\n\n',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 학습 중'),
                TextSpan(
                  text: ' 모르는 한자',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '가 있다면 한자도 함께 학습합니다.\n\n',
                ),
                TextSpan(
                  text: ' TOEIC 단어를 학습하면서 한자의 정보를 확인하면 하트가 필요합니다.',
                ),
                TextSpan(
                  text: '(하트는 시험에서 모든 단어를 맞추면 채워집니다)\n\n',
                ),
                TextSpan(text: ' 모르는 단어가 없을 때까지 해당 학습 페이지에서 학습 합니다.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TestPageDescription extends StatelessWidget {
  const TestPageDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimentions.height10),
          const Text(
            '시험 페이지',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.scaffoldBackground),
          ),
          SizedBox(height: Dimentions.height20),
          const Text.rich(
            TextSpan(
              style: TextStyle(
                  height: 1.6,
                  wordSpacing: 1.2,
                  color: AppColors.scaffoldBackground),
              children: [
                TextSpan(
                  text: ' 탁음, 촉음 등을 정확히 알고 있는지',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 확인하기 위해 '),
                TextSpan(
                  text: '일본어의 읽는 법',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '은 학습자가 '),
                TextSpan(
                  text: '직접 입력',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '하고 '),
                TextSpan(
                  text: '일본어의 의미',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '를 '),
                TextSpan(
                  text: '선택',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '합니다.\n\n '),

                // ---

                TextSpan(
                  text: '-주의-\n',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextSpan(text: ' 읽는 법은 학습 페이지에서 학습한 읽는 법과 '),
                TextSpan(
                  text: '동일하게',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 작성해야 합니다.\n'),
                TextSpan(
                  text: '(단 장음(-,ー)은 입력하지 않아도 됩니다)\n\n',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                TextSpan(text: '읽는 법을 입력하고 키보드의 '),
                TextSpan(
                  text: '확인 버튼을 누르면 사지선다 문제가 표시',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '됩니다.\n\n'),
                // TextSpan(
                //   text: '선택',
                //   style: TextStyle(
                //     color: Colors.red,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                TextSpan(
                  text: '(읽는 법 주관식 기능은 설정에서 ON/OFF 할 수 있습니다)\n\n',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScorePageDescription extends StatelessWidget {
  const ScorePageDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimentions.height10),
          const Text(
            '점수 페이지',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.scaffoldBackground),
          ),
          SizedBox(height: Dimentions.height20),
          const Text.rich(
            TextSpan(
              style: TextStyle(
                  height: 1.6,
                  wordSpacing: 1.2,
                  color: AppColors.scaffoldBackground),
              children: [
                TextSpan(text: '시험이 끝나면 점수 페이지에서 '),
                TextSpan(
                  text: '틀린 문제',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '를 또 한 번 확인하여 '),
                TextSpan(
                  text: '다시 한번 복습',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '합니다.\n\n'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UsuallyWrongWordPageDescription extends StatelessWidget {
  const UsuallyWrongWordPageDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimentions.height10),
          const Text(
            '자주 틀리는 문제 페이지',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.scaffoldBackground),
          ),
          SizedBox(height: Dimentions.height20),
          const Text.rich(
            TextSpan(
              style: TextStyle(
                  height: 1.6,
                  wordSpacing: 1.2,
                  color: AppColors.scaffoldBackground),
              children: [
                TextSpan(text: '학습 페이지에서 '),
                TextSpan(
                  text: ' 파일 모양의 아이콘',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '을 클릭하면 자주 틀리는 문제 페이지에 '),
                TextSpan(
                  text: '저장',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '됩니다.\n\n'),
                TextSpan(text: ' 전날이나 이번주의 모르는 단어들을 '),
                TextSpan(
                  text: '한 번 더 [시험]',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '을 통해 '),
                TextSpan(text: '학습합니다.\n\n'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WantToSayLastSomeThing extends StatelessWidget {
  const WantToSayLastSomeThing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimentions.height10),
          const Text(
            '마지막으로.',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.scaffoldBackground),
          ),
          SizedBox(height: Dimentions.height20),
          const Text.rich(
            TextSpan(
              style: TextStyle(
                  height: 1.6,
                  wordSpacing: 1.2,
                  color: AppColors.scaffoldBackground),
              children: [
                TextSpan(text: '학습 페이지에서 '),
                TextSpan(
                  text: ' 파일 모양의 아이콘',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '을 클릭하면 자주 틀리는 문제 페이지에 '),
                TextSpan(
                  text: '저장',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '됩니다.\n\n'),
                TextSpan(text: ' 전날이나 이번주의 모르는 단어들을 '),
                TextSpan(
                  text: '한 번 더 [시험]',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '을 통해 '),
                TextSpan(text: '학습합니다.\n\n'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
