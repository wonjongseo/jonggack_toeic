import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/common.dart';
import 'package:jonggack_toeic/common/widget/tutorial_text.dart';
import 'package:jonggack_toeic/config/colors.dart';
import 'package:jonggack_toeic/model/example.dart';
import 'package:jonggack_toeic/model/grammar.dart';
import 'package:jonggack_toeic/screen/grammar/grammar_stury_screen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../common/widget/dimentions.dart';
import '../../../config/theme.dart';
import '../../user/controller/user_controller.dart';
import 'grammar_description_card.dart';

class GrammerTutorialScreen extends StatefulWidget {
  const GrammerTutorialScreen({super.key});

  @override
  State<GrammerTutorialScreen> createState() => _GrammerTutorialScreenState();
}

class _GrammerTutorialScreenState extends State<GrammerTutorialScreen> {
  List<TargetFocus> targets = [];

  GlobalKey temp = GlobalKey();
  GlobalKey grammarKey = GlobalKey();
  GlobalKey exampleKey = GlobalKey();
  GlobalKey soundIconKey = GlobalKey();
  GlobalKey meanIconKey = GlobalKey();

  GlobalKey testKey = GlobalKey();

  bool isClick = false;
  bool isClickExample = false;
  bool isClickEye = true;
  void showTutorial() {
    TutorialCoachMark(
      alignSkip: Alignment.topLeft,
      textStyleSkip: const TextStyle(
          color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
      targets: targets,
      onClickTarget: (target) {
        if (target.identify == 'grammar') {
          isClick = true;
          setState(() {});
        }

        if (target.identify == 'exampleKey') {
          showExample();
        }

        if (target.identify == 'test') {
          Get.back();
        }
      },
      onSkip: () {
        Get.offAndToNamed(GRAMMER_STUDY_PATH);
      },
      onFinish: () {
        Get.offAndToNamed(GRAMMER_STUDY_PATH);
      },
    ).show(context: context);
  }

  List<Grammar> grammars = [];
  Grammar grammar = Grammar(
    id: 119,
    step: -1,
    level: "",
    grammar: "～てくる [出現]",
    connectionWays: "동사て형",
    means: "출현",
    examples: [
      Example(word: "太陽が地平線から昇ってきた.", mean: "태양이 지평선에서 떠올랐다.", answer: "昇ってきた"),
      Example(word: "歯が生えてきた.", mean: "이가 나기 시작했어.", answer: "生えてきた"),
      Example(
          word: "新年度になり新しい学生がやってきた.",
          mean: "새해가 되어 새로운 학생이 찾아왔다.",
          answer: "やってきた")
    ],
    description:
        "의지가 없는 동사에 접속해서 원래 존재하지 않았다거나 말하는 사람이 보이지 않았던 것이 보이게 되는 것을 나타낸다.\r\n[どんどん, だんだん] 부사어와 호응해서 사용되는 경우가 많다.",
  );

  @override
  void initState() {
    super.initState();

    grammars.addAll(
      [
        Grammar(
            id: 31,
            step: -1,
            level: "",
            grammar: "～たまま, ～ないまま",
            connectionWays: "동사 과거형",
            means: "",
            examples: [
              Example(
                  word: "本物と同じような見たままを描く絵なら, 写真でも良いでしょう.",
                  mean: "진짜와 같은 모습을 그리는 그림이라면 사진이라도 좋을 것입니다.",
                  answer: "まま"),
            ],
            description: "사물에 아무것도 손대지 않은 상태를 나타냄."),
        Grammar(
            id: 120,
            step: -1,
            level: "",
            grammar: "～てくる [こちらへの一方的な動作]",
            connectionWays: "동사て형",
            means: "이쪽으로의 일방적인 동작",
            examples: [
              Example(
                  word: "知らない人が話しかけてきた.",
                  mean: "모르는 사람이 말을 걸었다.",
                  answer: "てきた"),
            ],
            description: "화자, 혹은 화자가 보고 있는 사람에 대해 일방적인 동작이 이루어지는 것을 나타냅니다."),
        Grammar(
            id: 64,
            step: -1,
            level: "",
            grammar: "にとって",
            connectionWays: "명사에 직접 접속",
            means: "~에게 (있어서)",
            examples: [
              Example(
                  word: "女の子一人という環境は私にとって不安で心配.",
                  mean: "여자 혼자라는 환경은 나에게 불안하고 걱정이다.",
                  answer: "にとって"),
            ],
            description:
                "사람, 조직, 단체 등 명사에 접속하여, 그것들의 위치에서 바라본 판단이나 감상, 평가 등을 표현하는 문법"),
        Grammar(
            id: 43,
            step: -1,
            level: "",
            grammar: "～ておく(とく)",
            connectionWays: "동사 て형",
            means: "~해두다",
            examples: [
              Example(
                  word: "お客さんが来る前に部屋を掃除しておきましょう.",
                  mean: "손님이 오기 전에 방을 청소해 둡시다.",
                  answer: "おきましょう"),
            ],
            description: "1. 어떤 목적 때문에 미리 준비해두다.2. 아무것도 하지 않고 방치해두다とく는 회화체"),
        Grammar(
            id: 65,
            step: -1,
            level: "",
            grammar: "には",
            connectionWays: "동사 사전형명사",
            means: "1. ~하려면, ~하기 위해서는2. ~하기에는",
            examples: [
              Example(
                  word: "新しい生活に慣れるには時間が必要.",
                  mean: "새로운 생활에 익숙해지려면 시간이 필요해.",
                  answer: "には"),
            ],
            description:
                "1. 동작의 목적앞 문장에는 목적을 뒷 문장에는 그 목적을 달생하기 위해서 필요한 조건을 서술함.2. 평가의 기준인명을 나타내는 명사에 대해서, 그 인물에게 어떤 상황에 대한 평가를 표현함.뒷 내용에는 주로 난이도에 관한 말이 온다."),
        Grammar(
            id: 106,
            step: -1,
            level: "",
            grammar: "続ける",
            connectionWays: "동사 ます형",
            means: "계속~하다",
            examples: [
              Example(
                  word: "以前もらったペンを今でも使い続けている.",
                  mean: "이전에 받은 펜을 지금도 계속 사용하고 있다.",
                  answer: "続けている"),
            ],
            description: "동작의 계속·지속을 나타냄."),
        Grammar(
            id: 84,
            step: -1,
            level: "",
            grammar: "～みたいだ／みたいに／みたいな",
            connectionWays: "동사 보통형＋みたいだい형용사 보통형＋みたいだな형용사 어간＋みたいだ명사＋みたいだ ",
            means: "~것 같다 / ~ 같이 / ~같은",
            examples: [
              Example(
                  word: "葬式みたいな話は聞きたくない.",
                  mean: "장례식 같은 얘기는 듣고 싶지 않아.",
                  answer: "みたいな"),
            ],
            description: "みないな ~것 같은 (ような의 회화체)みたいに ~것 같이, ~처럼  (ように의 회화체)"),
        Grammar(
            id: 66,
            step: -1,
            level: "",
            grammar: "～によって／によっては／により／による",
            connectionWays: "명사에 직접 접속",
            means: "~에 따른, ~에 의한",
            examples: [
              Example(
                  word: "テストの結果によって, 成績を決める.",
                  mean: "시험 결과에 따라 성적을 결정한다.",
                  answer: "によって"),
            ],
            description: "1. 수단, 방법을 나타냄2. 원인, 이유를 나타냄"),
      ],
    );

    initTutorial();
    showTutorial();
  }

  void initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "grammar",
          keyTarget: grammarKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      '문법 정보 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '문법',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 버튼을 눌러서 문법 정보를 확인 할 수 있습니다.'),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
        TargetFocus(
          identify: "exampleKey",
          keyTarget: exampleKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '문법 예시',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: AppColors.scaffoldBackground,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '예시',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: ' 버튼을 클릭하면 문법의 예시를 볼 수 있습니다. '),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "soundIcon",
          keyTarget: soundIconKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '예시 듣기',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                      children: [
                        TextSpan(
                            text: '아이콘',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: '을 클릭하여 '),
                        TextSpan(
                            text: '예시의 소리',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: '를 들을 수 있습니다.'),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "meanIcon",
          keyTarget: meanIconKey,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '예시 뜻 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '예시',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 를 클릭하여 예시의 뜻을 확인할 수 있습니다.'),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
        TargetFocus(
          identify: "test",
          keyTarget: testKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const TutorialText(
                title: '문법 테스트 하기',
                subTitles: [
                  '예시를 기반으로 문법 테스트를 진행할 수 있습니다.',
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('N3 문법-1'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  key: testKey,
                  '시험',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteGrey,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: AnimatedSize(
                  alignment: const Alignment(0, -1),
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.scaffoldBackground.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(1, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            isClick = !isClick;
                            setState(() {});
                          },
                          child: Text(
                            key: grammarKey,
                            grammar.grammar,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.scaffoldBackground,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isClick,
                          child: const Divider(height: 20),
                        ),
                        Visibility(
                          visible: isClick,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (grammar.connectionWays.isNotEmpty)
                                GrammarDescriptionCard(
                                    fontSize: size.width / 300 + 11,
                                    title: '접속 형태',
                                    content: grammar.connectionWays),
                              if (grammar.connectionWays.isNotEmpty)
                                const Divider(height: 20),
                              if (grammar.means.isNotEmpty)
                                GrammarDescriptionCard(
                                    fontSize: size.width / 300 + 12,
                                    title: '뜻',
                                    content: grammar.means),
                              if (grammar.means.isNotEmpty)
                                const Divider(height: 20),
                              if (grammar.description.isNotEmpty)
                                GrammarDescriptionCard(
                                    fontSize: size.width / 300 + 13,
                                    title: '설명',
                                    content: grammar.description),
                              const Divider(height: 20),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.scaffoldBackground
                                              .withOpacity(0.3),
                                          blurRadius: 1,
                                          offset: const Offset(1, 1),
                                        ),
                                        BoxShadow(
                                          color: AppColors.scaffoldBackground
                                              .withOpacity(0.3),
                                          blurRadius: 1,
                                          offset: const Offset(-1, -1),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(10)),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      key: exampleKey,
                                      '예제',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showExample();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ...List.generate(
                grammars.length,
                (index) => GrammarCard(
                  grammar: grammars[index],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showExample() {
    return Get.bottomSheet(
      backgroundColor: AppColors.scaffoldBackground,
      persistent: false,
      Padding(
        padding: const EdgeInsets.all(16.0).copyWith(right: 0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(grammar.examples.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () =>
                                  copyWord(grammar.examples[index].word),
                              child: Text(
                                key: index == 0 ? meanIconKey : null,
                                grammar.examples[index].word,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: AppFonts.japaneseFont,
                                ),
                              ),
                            )),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    isClickEye = true;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.music_note,
                                    key: index == 0 ? soundIconKey : null,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        if (index == 0 && isClickEye)
                          ZoomIn(
                            child: Text(
                              grammar.examples[index].mean,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Dimentions.height16),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GrammarCard extends StatefulWidget {
  GrammarCard({
    super.key,
    this.onPress,
    this.onPressLike,
    required this.grammar,
  });

  VoidCallback? onPress;
  final Grammar grammar;
  VoidCallbackIntent? onPressLike;

  @override
  State<GrammarCard> createState() => _GrammarCardState();
}

class _GrammarCardState extends State<GrammarCard> {
  UserController userController = Get.find<UserController>();

  bool isClick = false;
  bool isClickExample = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: AnimatedSize(
        alignment: const Alignment(0, -1),
        duration: const Duration(milliseconds: 500),
        child: InkWell(
          onTap: () {
            isClick = !isClick;
            isClickExample = false;
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.scaffoldBackground.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(1, 1),
                )
              ],
              borderRadius: BorderRadius.circular(Dimentions.height20),
            ),
            child: Column(
              children: [
                Text(
                  widget.grammar.grammar,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.scaffoldBackground,
                    fontFamily: AppFonts.japaneseFont,
                  ),
                ),
                Visibility(
                  visible: isClick,
                  child: Divider(height: Dimentions.height20),
                ),
                Visibility(
                  visible: isClick,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.grammar.connectionWays.isNotEmpty)
                        GrammarDescriptionCard(
                            fontSize: size.width / 300 + 11,
                            title: '접속 형태',
                            content: widget.grammar.connectionWays),
                      if (widget.grammar.connectionWays.isNotEmpty)
                        const Divider(height: 20),
                      if (widget.grammar.means.isNotEmpty)
                        GrammarDescriptionCard(
                            fontSize: size.width / 300 + 12,
                            title: '뜻',
                            content: widget.grammar.means),
                      if (widget.grammar.means.isNotEmpty)
                        const Divider(height: 20),
                      if (widget.grammar.description.isNotEmpty)
                        GrammarDescriptionCard(
                            fontSize: size.width / 300 + 13,
                            title: '설명',
                            content: widget.grammar.description),
                      Divider(height: Dimentions.height20),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.scaffoldBackground
                                      .withOpacity(0.3),
                                  blurRadius: 1,
                                  offset: const Offset(1, 1),
                                ),
                                BoxShadow(
                                  color: AppColors.scaffoldBackground
                                      .withOpacity(0.3),
                                  blurRadius: 1,
                                  offset: const Offset(-1, -1),
                                )
                              ],
                              borderRadius:
                                  BorderRadius.circular(Dimentions.height10)),
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(Dimentions.height30 / 2),
                            child: const Text(
                              '예제',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (await userController.useHeart()) {
                            await Get.bottomSheet(
                              backgroundColor: AppColors.scaffoldBackground,
                              Padding(
                                padding: EdgeInsets.all(Dimentions.height16)
                                    .copyWith(right: 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...List.generate(
                                            widget.grammar.examples.length,
                                            (index) {
                                          return GrammarExampleCard(
                                            example:
                                                widget.grammar.examples[index],
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {}
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GrammarExampleCard extends StatefulWidget {
  const GrammarExampleCard({super.key, required this.example});
  final Example example;
  @override
  State<GrammarExampleCard> createState() => _GrammarExampleCardState();
}

class _GrammarExampleCardState extends State<GrammarExampleCard> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    double fontSize = Dimentions.width17;

    return Padding(
      padding: EdgeInsets.only(bottom: Dimentions.height16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                    onTap: isClick != false
                        ? () {}
                        : () {
                            isClick = true;
                            setState(() {});
                          },
                    child: Text(
                      widget.example.word,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontFamily: AppFonts.japaneseFont,
                      ),
                    )),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
          if (isClick)
            ZoomIn(
              child: Text(
                widget.example.mean,
                style: TextStyle(
                    color: Colors.grey, fontSize: Dimentions.height16),
              ),
            ),
        ],
      ),
    );
  }
}
