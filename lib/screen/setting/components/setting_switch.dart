import 'package:flutter/material.dart';

class SettingSwitch extends StatelessWidget {
  const SettingSwitch(
      {super.key,
      required this.text,
      required this.isOn,
      required this.onChanged});

  final String text;
  final bool isOn;
  final Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(8.0),
      width: size.width * 0.9,
      height: size.height * 0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          Switch(value: isOn, onChanged: onChanged),
        ],
      ),
    );
  }
}
