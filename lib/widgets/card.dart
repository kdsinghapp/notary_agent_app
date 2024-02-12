import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Widget child;
  const AppCard({
    Key? key,
    this.padding = const EdgeInsets.all(15),
    this.margin = const EdgeInsets.symmetric(horizontal: 20),
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDEDEDE)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}
