import 'package:flutter/material.dart';

class HiraganaStudyScreen extends StatefulWidget {
  const HiraganaStudyScreen({super.key});

  @override
  State<HiraganaStudyScreen> createState() => _HiraganaStudyScreenState();
}

class _HiraganaStudyScreenState extends State<HiraganaStudyScreen> {
  @override
  Widget build(BuildContext context) {
    for (String b in a.keys) {
      print('b: ${b}');
    }
    print('a["あ"]: ${a["あ"]}');

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  a.length,
                  (index) => Container(
                    height: 100,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        onPressed: () {}, child: Text(a.keys.elementAt(index))),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Map<String, dynamic> a = {
  'あ': [
    'あ',
    'い',
    'う',
    'え',
    'お',
  ],
  'か': [
    'か',
    'き',
    'く',
    'け',
    'こ',
  ],
  'さ': [
    'さ',
    'し',
    'す',
    'せ',
    'そ',
  ],
  'た': [
    'た',
    'ち',
    'つ',
    'て',
    'と',
  ],
  'な': [
    'な',
    'に',
    'ぬ',
    'ね',
    'の',
  ],
  'は': [
    'は',
    'ひ',
    'ふ',
    'へ',
    'ほ',
  ],
  'ま': [
    'ま',
    'み',
    'む',
    'め',
    'も',
  ],
  'や': [
    'や',
    'ゆ',
    'よ',
  ],
  'ら': [
    'ら',
    'り',
    'る',
    'れ',
    'ろ',
  ],
  'わ': [
    'わ',
    'を',
  ],
  'ん': [
    'ん',
  ]
};
