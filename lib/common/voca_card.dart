import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic/common/example_mean_card.dart';
import 'package:jonggack_toeic/common/word_api_datasource.dart';
import 'package:jonggack_toeic/model/word.dart';
import 'package:jonggack_toeic/tts_controller.dart';

class ExapleWords extends StatefulWidget {
  const ExapleWords({super.key, required this.voca});

  final Word voca;
  @override
  State<ExapleWords> createState() => _ExapleWordsState();
}

class _ExapleWordsState extends State<ExapleWords> {
  late WordApiDatasource wordApiDatasource;

  @override
  void initState() {
    super.initState();
    wordApiDatasource = WordApiDatasource();
  }

  int getExampleIndex(List<String> exampleList, String word) {
    int exampleIndex = exampleList.indexOf(word);
    if (exampleIndex == -1) {
      exampleIndex = exampleList.indexOf('${word}s');
      if (exampleIndex == -1) {
        exampleIndex = exampleList.indexOf('${word}ed');
        if (exampleIndex == -1) {
          exampleIndex = exampleList.indexOf('${word}d');
        }
      }
    }
    return exampleIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: wordApiDatasource.getWordExample(widget.voca.word),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('데이터를 불러오고 있습니다.')
                ],
              ));
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<dynamic> examples = snapshot.data as List<dynamic>;

              return examples.isNotEmpty
                  ? Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        child:
                            GetBuilder<TtsController>(builder: (ttsController) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              if (ttsController.isPlaying)
                                const Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SpinKitWave(
                                      size: 30,
                                      color: Colors.black,
                                    ))
                              else
                                Container(
                                  height: 30,
                                ),
                              ...List.generate(
                                examples.length,
                                (index) {
                                  String example = examples[index];
                                  List<String> exampleList = example.split(' ');
                                  int exampleIndex = getExampleIndex(
                                      exampleList, widget.voca.word);

                                  return WordExampleMeanCard(
                                    example: example,
                                    exampleList: exampleList,
                                    exampleIndex: exampleIndex,
                                    index: index,
                                  );
                                },
                              )
                            ],
                          );
                        }),
                      ),
                    )
                  : const Text('준비된 예제가 없습니다.');
            }
          }),
    );
  }
}
