import 'package:hive/hive.dart';
import 'package:jonggack_toeic/model/hive_type.dart';
part 'example.g.dart';

@HiveType(typeId: ExampleTypeId)
class Example {
  static String boxKey = 'example_key';
  @HiveField(0)
  late String word;
  @HiveField(1)
  late String mean;
  @HiveField(2)
  late String answer;

  Example({required this.word, required this.mean, required this.answer});

  Example.fromMap(Map<String, dynamic> map) {
    word = map['word'] ?? '';
    mean = map['mean'] ?? '';
    answer = map['answer'] ?? '';
  }

  @override
  String toString() {
    return 'Example(word: "$word", mean: "$mean", answer: "$answer")';
  }
}
