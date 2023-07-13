import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../screen/user/controller/user_controller.dart';

class HeartCount extends StatelessWidget {
  const HeartCount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Icon(
              Icons.favorite,
              color: userController.user.heartCount == 0
                  ? Colors.white.withOpacity(0.3)
                  : Colors.red,
              size: 45,
            ),
            Text(
              userController.user.isPremieum
                  ? ''
                  : userController.user.heartCount.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )
          ],
        ),
      );
    });
  }
}
