import 'package:flutter/material.dart';
import 'package:jonggack_toeic/config/colors.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.level,
    required this.onTap,
    required this.isAllFinished,
  }) : super(key: key);

  final bool isAllFinished;
  final int level;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onTap,
          padding: EdgeInsets.zero,
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          icon: Icon(
            Icons.book,
            color: isAllFinished ? AppColors.lightGreen : Colors.white,
            size: 220,
          ),
        ),
        Text(
          '챕터${level + 1}',
          style: TextStyle(
            color: isAllFinished ? AppColors.lightGreen : AppColors.whiteGrey,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
