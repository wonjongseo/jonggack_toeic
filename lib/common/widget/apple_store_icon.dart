import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jonggack_toeic/config/colors.dart';

class AppleStoreIcon extends StatelessWidget {
  const AppleStoreIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.only(bottom: 10, top: 40, right: 30, left: 30),
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 350,
                    ),
                    // Plus(),
                    Positioned(
                      top: 125,
                      // bottom: 210,
                      child: Text(
                        'TOEIC 종각',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 35,
                        ),
                      ),
                    )
                    // Container(
                    //   margin: EdgeInsets.only(bottom: 60),
                    //   child: Text(
                    //     'JLPT 종각',
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.w700,
                    //       fontSize: 45,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Plus extends StatelessWidget {
  const Plus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 85,
      right: 70,
      child: const Icon(
        Icons.add,
        size: 35,
        color: Colors.redAccent,
        shadows: [
          Shadow(
            color: Colors.redAccent,
            offset: Offset(1, 1),
          ),
          Shadow(
            color: Colors.redAccent,
            offset: Offset(-1, -1),
          ),
          Shadow(
            color: Colors.redAccent,
            offset: Offset(-1, 1),
          ),
          Shadow(
            color: Colors.redAccent,
            offset: Offset(1.5, -1.5),
          ),
          Shadow(
            color: Colors.redAccent,
            offset: Offset(1.5, 1.5),
          ),
          Shadow(
            color: Colors.redAccent,
            offset: Offset(-1.5, -1.5),
          ),
          Shadow(
            color: Colors.redAccent,
            offset: Offset(-1.5, 1.5),
          ),
          Shadow(
            color: Colors.redAccent,
            offset: Offset(1.5, -1.5),
          ),
          // -
        ],
      ),
    );
  }
}
