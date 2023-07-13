import 'dart:math';

import 'package:hive/hive.dart';
import 'package:jonggack_toeic/model/hive_type.dart';
import 'package:jonggack_toeic/model/word.dart';

part 'Question.g.dart';

@HiveType(typeId: QuestionTypeId)
class Question {
  static String boxKey = 'question_key';
  @HiveField(0)
  int answer;
  @HiveField(1)
  final Word question;
  @HiveField(2)
  final List<Word> options;

  Question({
    required this.question,
    required this.answer,
    required this.options,
  });

  @override
  String toString() {
    return 'Question{answer: $answer,question: $question, options: $options}';
  }

  static Map<int, List<Word>> generateAnswer(
      List<Word> vocas, int currentIndex, bool isManual) {
    Random random = Random();

    List<int> answerIndex = List.empty(growable: true);

    for (int i = 0; i < 4; i++) {
      int randomNumber = random.nextInt(vocas.length);
      while (answerIndex.contains(randomNumber)) {
        randomNumber = random.nextInt(vocas.length);
      }
      answerIndex.add(randomNumber);
    }

    int correctIndex = answerIndex.indexOf(currentIndex);
    if (correctIndex == -1) {
      int randomNumber = random.nextInt(4);
      answerIndex[randomNumber] = currentIndex;
      correctIndex = randomNumber;
    }

    List<Word> answerVoca = List.empty(growable: true);

    for (int j = 0; j < answerIndex.length; j++) {
      String tempMean = vocas[answerIndex[j]].mean;
      bool isMeanOverThree = tempMean.contains('\n3. ');
      bool isMeanOverTwo = tempMean.contains('\n2. ');

      if (isMeanOverThree) {
        tempMean = tempMean.replaceAll('3. ', '');
        tempMean = tempMean.replaceAll('2. ', '');
        tempMean = tempMean.replaceAll('1. ', '');
        List<String> speartea = tempMean.split('\n');
        int randomIndex = random.nextInt(speartea.length);

        tempMean = speartea[randomIndex];
      }
      if (isMeanOverTwo) {
        tempMean = tempMean.replaceAll('2. ', '');
        tempMean = tempMean.replaceAll('1. ', '');
        List<String> speartea = tempMean.split('\n');
        int randomIndex = random.nextInt(speartea.length);

        tempMean = speartea[randomIndex];
      }

      Word newWord;
      if (isManual) {
        newWord = Word(
          word: tempMean,
          mean: vocas[answerIndex[j]].word,
          // mean: vocas[answerIndex[j]].mean,
        );
      } else {
        newWord = Word(
          word: vocas[answerIndex[j]].word,
          mean: tempMean,
          // mean: vocas[answerIndex[j]].mean,
        );
      }

      answerVoca.add(newWord);
    }

    return {correctIndex: answerVoca};
  }

  static List<Map<int, List<Word>>> generateQustion(
      List<Word> vocas, bool isManual) {
    List<Map<int, List<Word>>> map = List.empty(growable: true);
    for (int correntIndex = 0; correntIndex < vocas.length; correntIndex++) {
      Map<int, List<Word>> voca = generateAnswer(vocas, correntIndex, isManual);
      map.add(voca);
    }
    map.shuffle();

    return map;
  }
}
