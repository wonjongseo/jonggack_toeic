import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jonggack_toeic/config/colors.dart';

class GraphicImage extends StatelessWidget {
  const GraphicImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 10)),
              height: 500 / 1.5,
              width: 1024 / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '확실하게',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '토익 단어를 외우자!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'TOEIC 종각',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(flex: 1)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
