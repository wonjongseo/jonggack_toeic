import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class UploadExcelInfomation extends StatelessWidget {
  const UploadExcelInfomation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          style: TextStyle(color: AppColors.scaffoldBackground),
          TextSpan(
            text: '1. ',
            children: [
              TextSpan(text: '확장자', style: TextStyle(color: Colors.red)),
              TextSpan(text: '를 '),
              TextSpan(text: '.xlsx', style: TextStyle(color: Colors.red)),
              TextSpan(text: '로 준비해주세요.'),
            ],
          ),
        ),
        ExcelInfoText(
          number: '2. ',
          text1: '첫번째 열',
          text2: '단어',
        ),
        ExcelInfoText(
          number: '3. ',
          text1: '두번째 열',
          text2: '의미',
        ),
        // ExcelInfoText(
        //   number: '4. ',
        //   text1: '세번째 열',
        //   text2: '뜻',
        // ),
        Text.rich(
          style: TextStyle(color: AppColors.scaffoldBackground),
          TextSpan(
            text: '4. ',
            children: [
              TextSpan(text: '빈 행', style: TextStyle(color: Colors.red)),
              TextSpan(text: '이 '),
              TextSpan(text: '없도록', style: TextStyle(color: Colors.red)),
              TextSpan(text: ' 입력 해 주세요.'),
            ],
          ),
        )
      ],
    );
  }
}

class ExcelInfoText extends StatelessWidget {
  const ExcelInfoText(
      {super.key,
      required this.text1,
      required this.text2,
      required this.number});

  final String number;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: number,
        style: const TextStyle(color: AppColors.scaffoldBackground),
        children: [
          TextSpan(text: text1, style: const TextStyle(color: Colors.red)),
          const TextSpan(text: '에 '),
          TextSpan(text: text2, style: const TextStyle(color: Colors.red)),
          const TextSpan(text: '를 입력 해 주세요.'),
        ],
      ),
    );
  }
}
