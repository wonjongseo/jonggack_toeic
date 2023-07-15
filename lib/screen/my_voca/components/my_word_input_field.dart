import 'package:flutter/material.dart';
import 'package:jonggack_toeic/config/colors.dart';

class MyWordInputField extends StatelessWidget {
  const MyWordInputField({
    super.key,
    required this.wordFocusNode,
    required this.wordController,
    required this.meanFocusNode,
    required this.meanController,
    required this.saveWord,
  });

  final Function() saveWord;
  final FocusNode wordFocusNode;
  final TextEditingController wordController;
  final FocusNode meanFocusNode;
  final TextEditingController meanController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double responsiveSaveButtonHeight = size.width > 700 ? 50 : 40;
    double responsiveMargin = size.width > 700 ? 20 : 5;
    double responsiveTextFieldFontSize = size.width > 700 ? 16 : 13;

    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            style: const TextStyle(color: AppColors.scaffoldBackground),
            autofocus: true,
            focusNode: wordFocusNode,
            onFieldSubmitted: (value) => saveWord(),
            controller: wordController,
            decoration: InputDecoration(
              label: Text(
                '영어',
                style: TextStyle(
                  fontSize: responsiveTextFieldFontSize,
                  color: AppColors.scaffoldBackground,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: responsiveMargin),
          TextFormField(
            style: const TextStyle(color: AppColors.scaffoldBackground),
            focusNode: meanFocusNode,
            onFieldSubmitted: (value) => saveWord(),
            controller: meanController,
            decoration: InputDecoration(
              label: Text(
                '의미',
                style: TextStyle(
                  fontSize: responsiveTextFieldFontSize,
                  color: AppColors.scaffoldBackground,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: responsiveSaveButtonHeight,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: saveWord,
              child: const Text(
                '저장',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
