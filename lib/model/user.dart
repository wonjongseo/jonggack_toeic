import 'package:hive/hive.dart';
import 'package:jonggack_toeic/model/hive_type.dart';

part 'user.g.dart';

@HiveType(typeId: UserTypeId)
class User extends HiveObject {
  static String boxKey = 'user_key';
  bool isFake = false;

  @HiveField(0)
  int heartCount;
  @HiveField(1)
  List<int> jlptWordScroes = [];
  @HiveField(2)
  List<int> grammarScores = [];
  @HiveField(3)
  List<int> kangiScores = [];

  @HiveField(4)
  // N5 현재 진형량의 인덱스는 4
  List<int> currentJlptWordScroes = [];
  @HiveField(5)
  List<int> currentGrammarScores = [];
  @HiveField(6)
  List<int> currentKangiScores = [];

  bool isPremieum = true;
  // bool isPremieum = false;

  User({
    required this.heartCount,
    required this.jlptWordScroes,
    required this.grammarScores,
    required this.kangiScores,
    required this.currentJlptWordScroes,
    required this.currentGrammarScores,
    required this.currentKangiScores,
  });

  @override
  String toString() {
    return 'User( heartCount: $heartCount\njlptWordScroes: $jlptWordScroes, grammarScores: $grammarScores, kangiScores: $kangiScores\ncurrentJlptWordScroes: $currentJlptWordScroes, currentGrammarScores: $currentGrammarScores, currentKangiScores: $currentKangiScores)';
  }
}
