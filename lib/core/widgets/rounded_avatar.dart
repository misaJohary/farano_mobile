import 'package:flutter/cupertino.dart';

class RoundedAvatar extends StatelessWidget {
  const RoundedAvatar({super.key, this.color, this.height, this.width, required this.child});

  final Color? color;
  final double? height;
  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), //or 15.0
      child: Container(
        height: 70.0,
        width: 70.0,
        color: color,
        child: child,
      ),
    );
  }
}
