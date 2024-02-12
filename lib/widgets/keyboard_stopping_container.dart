import 'package:flutter/material.dart';

class KeyboardStoppingContainer extends StatelessWidget {
  final Widget? child;
  // ignore: unnecessary_final
  const KeyboardStoppingContainer({final Key? key, final this.child}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: IntrinsicHeight(child: child),
      ),
    );
  }
}
