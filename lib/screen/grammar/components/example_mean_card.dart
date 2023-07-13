import 'package:flutter/material.dart';
import 'package:jonggack_toeic/model/example.dart';

class ExampleMeanCard extends StatefulWidget {
  const ExampleMeanCard({
    Key? key,
    required this.example,
  }) : super(key: key);

  final Example example;
  @override
  State<ExampleMeanCard> createState() => _ExampleMeanCardState();
}

class _ExampleMeanCardState extends State<ExampleMeanCard> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () async {
            setState(() {
              isClick = true;
            });
          },
          child: Text(
            widget.example.word,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: width > 500 ? 18 : 13,
            ),
          ),
        ),
        const SizedBox(height: 5),
        if (isClick)
          Text(
            widget.example.mean,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.grey),
          ),
        const SizedBox(height: 30),
      ],
    );
  }
}
