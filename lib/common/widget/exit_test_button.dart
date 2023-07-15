import 'package:flutter/material.dart';

import '../common.dart';
import 'dimentions.dart';

class ExitTestButton extends StatelessWidget {
  const ExitTestButton({
    super.key,
    required this.isMyTest,
  });

  final bool isMyTest;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimentions.width90,
      height: Dimentions.height60,
      child: ElevatedButton(
        child: Text(
          '나가기',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimentions.width16,
          ),
        ),
        onPressed: () {
          if (isMyTest) {
            return getBacks(2);
          }
          return getBacks(3);
        },
      ),
    );
  }
}
