import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String iconName;
  final double? size;

  const CustomIcon(
    this.iconName, {
    final Key? key,
    this.size,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => SizedBox(
        height: size ?? 24,
        width: size ?? 24,
        child: Image.asset(
          'lib/assets/icons/$iconName.png',
          fit: BoxFit.contain,
          height: size ?? 24,
          width: size ?? 24,
        ),
      );
}
