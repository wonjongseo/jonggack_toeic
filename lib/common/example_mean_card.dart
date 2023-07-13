import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:jonggack_toeic/common/word_api_datasource.dart';
import 'package:jonggack_toeic/tts_controller.dart';

class WordExampleMeanCard extends StatefulWidget {
  WordExampleMeanCard({
    Key? key,
    required this.example,
    required this.exampleList,
    required this.exampleIndex,
    required this.index,
  }) : super(key: key);

  final WordApiDatasource wordApiDatasource = WordApiDatasource();
  final String example;
  final List<String> exampleList;
  final int exampleIndex;
  final int index;

  @override
  State<WordExampleMeanCard> createState() => _WordExampleMeanCardState();
}

class _WordExampleMeanCardState extends State<WordExampleMeanCard> {
  TtsController ttsController = Get.find<TtsController>();
  bool isAA = false;
  late Widget meanText = const Text('');
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      children: List.generate(
                        widget.exampleList.length,
                        (index) => index == widget.exampleIndex
                            ? InkWell(
                                onTap: isAA
                                    ? null
                                    : () async {
                                        setState(() {
                                          isAA = true;
                                        });

                                        String papagoedDifinition = await widget
                                            .wordApiDatasource
                                            .getWordDefinition(
                                                widget.exampleList[index]);

                                        setState(() {
                                          isAA = false;
                                        });
                                        Get.dialog(AlertDialog(
                                          title: Text(
                                            widget.exampleList[index],
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          content: Text(
                                            papagoedDifinition,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ));
                                      },
                                child: Text(
                                  '${widget.exampleList[index]} ',
                                  style:
                                      const TextStyle(color: Colors.redAccent),
                                ),
                              )
                            : InkWell(
                                onTap: isAA
                                    ? null
                                    : () async {
                                        // String tmp =
                                        setState(() {
                                          isAA = true;
                                        });
                                        await Future.delayed(
                                            Duration(seconds: 70));
                                        String papagoedDifinition = await widget
                                            .wordApiDatasource
                                            .getWordDefinition(
                                                widget.exampleList[index]);

                                        setState(() {
                                          isAA = false;
                                        });

                                        Get.dialog(AlertDialog(
                                          title: Text(
                                            widget.exampleList[index],
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          content: Text(
                                            papagoedDifinition,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ));
                                      },
                                child: Text(
                                  '${widget.exampleList[index]} ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    style: IconButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () async {
                      setState(() {
                        meanText = SizedBox(
                          width: MediaQuery.of(context).size.width - 150,
                          child: const LinearProgressIndicator(),
                        );
                      });
                      String tmp = await widget.wordApiDatasource
                          .getWordMean(widget.example);
                      setState(() {
                        meanText = Text(tmp,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.black,
                                    ));
                      });
                    },
                    icon: const Icon(Icons.remove_red_eye)),
                IconButton(
                  style: IconButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    ttsController.speak(widget.example);
                  },
                  icon: const Icon(Icons.music_note),
                ),
              ],
            ),
            // TextButton(
            //   style: TextButton.styleFrom(padding: EdgeInsets.zero),
            //   onPressed: () async {
            //     setState(() {
            //       meanText = SizedBox(
            //         width: MediaQuery.of(context).size.width - 150,
            //         child: const LinearProgressIndicator(),
            //       );
            //     });
            //     String tmp =
            //         await widget.wordApiDatasource.getWordMean(widget.example);
            //     setState(() {
            //       meanText = Text(tmp,
            //           style: Theme.of(context).textTheme.bodySmall!.copyWith(
            //                 color: Colors.black,
            //               ));
            //     });
            //   },
            //   child: Column(
            //     children: [

            //     ],
            //   ),
            // ),
            const SizedBox(height: 5),
            meanText,
            const SizedBox(height: 15),
          ],
        ),
        if (isAA) Center(child: CircularProgressIndicator())
      ],
    );
  }
}
