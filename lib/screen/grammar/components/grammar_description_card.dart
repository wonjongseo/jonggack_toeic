import 'package:flutter/cupertino.dart';
import 'package:jonggack_toeic/config/colors.dart';

class GrammarDescriptionCard extends StatelessWidget {
  const GrammarDescriptionCard({
    Key? key,
    required this.title,
    required this.content,
    required this.fontSize,
  }) : super(key: key);

  final String title;
  final String content;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                  color: AppColors.scaffoldBackground,
                  fontWeight: FontWeight.w600)),
          const TextSpan(text: ' :\n'),
          TextSpan(
            text: content,
            style: TextStyle(
              color: AppColors.scaffoldBackground,
              fontSize: fontSize,
            ),
          )
        ],
      ),
    );
  }
}
