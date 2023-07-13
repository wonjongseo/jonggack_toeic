import 'package:flutter/material.dart';

class TutorialText extends StatelessWidget {
  const TutorialText({super.key, required this.title, this.subTitles});
  final String title;
  final List<String>? subTitles;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          //"JLPT 레벨 선택",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
        ),
        if (subTitles != null)
          ...List.generate(
            subTitles!.length,
            (index) {
              return Text(
                subTitles![index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: subTitles![index].length > 20 ? 14 : 16.0,
                ),
              );
            },
          )
      ],
    );
  }
}
