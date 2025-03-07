import 'package:farano/core/widgets/rounded_avatar.dart';
import 'package:flutter/material.dart';

class TextInBox extends StatelessWidget {
  const TextInBox({
    super.key,
    required this.letter,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
  });

  final String letter;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return RoundedAvatar(
      width: 40,
      height: 40,
      color: backgroundColor,
      child: Center(
        child: Text(
          letter,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 36,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
