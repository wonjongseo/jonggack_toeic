import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:jonggack_toeic/model/my_word.dart';

class MyWordRepository {
  Future<List<MyWord>> getAllMyWord(bool isManuelSave) async {
    final list = Hive.box<MyWord>(MyWord.boxKey);

    List<MyWord> words = List.generate(list.length, (index) {
      return list.getAt(index);
    }).whereType<MyWord>().where((element) {
      return element.isManuelSave == isManuelSave;
    }).toList();

    words.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

    return words;
  }

  static bool saveMyWord(MyWord word) {
    final list = Hive.box<MyWord>(MyWord.boxKey);
    if (list.containsKey(word.word)) {
      return false;
    }
    list.put(word.word, word);
    return true;
  }

  static void deleteAllMyWord() {
    final list = Hive.box<MyWord>(MyWord.boxKey);

    list.deleteFromDisk();
    log('deleteAllMyWord success');
  }

  void deleteMyWord(MyWord word) {
    final list = Hive.box<MyWord>(MyWord.boxKey);

    list.delete(word.word);
  }

  void updateKnownMyVoca(String word, bool isTrue) {
    print('word: ${word}');
    final list = Hive.box<MyWord>(MyWord.boxKey);
    MyWord myWord = list.get(word) as MyWord;
    print('myWord: ${myWord}');
    myWord.isKnown = isTrue;
    list.put(word, myWord);
  }
}
