import 'package:hive/hive.dart';
import 'package:jonggack_toeic/model/hive_type.dart';
import 'package:jonggack_toeic/model/word.dart';

import 'Question.dart';

part 'jlpt_step.g.dart';

@HiveType(typeId: JlptStepTypeId)
class JlptStep extends HiveObject {
  static String boxKey = 'jlpt_step_key';
  @HiveField(0)
  final String headTitle;
  @HiveField(1)
  final int step;
  @HiveField(2)
  final List<Word> words;
  @HiveField(3)
  List<Word> unKnownWord = [];
  @HiveField(4)
  int scores;

  @HiveField(5)
  bool? isFinished = false;

  @HiveField(6)
  List<Question>? wrongQestion = [];

  JlptStep(
      {required this.headTitle,
      required this.step,
      required this.words,
      required this.scores});

  @override
  String toString() {
    return 'JlptStep(headTitle: $headTitle, step: $step, words: $words , unKnownWord: $unKnownWord, scores: $scores, wrongQestion: ${wrongQestion?.length})';
  }
}
