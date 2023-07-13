import 'package:flutter/material.dart';
import 'package:jonggack_toeic/config/colors.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.level,
    required this.onTap,
  }) : super(key: key);

  final String level;
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
          icon: const Icon(
            Icons.book,
            color: Colors.white,
            size: 220,
          ),
        ),
        Text(
          level,
          style: const TextStyle(
            color: AppColors.whiteGrey,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
