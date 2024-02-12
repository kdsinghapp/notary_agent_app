import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:package_info_plus/package_info_plus.dart';

Widget sbh(double height) {
  return SizedBox(height: height);
}

Widget sbw(double width) {
  return SizedBox(width: width);
}

MotionToast showSuccessToast(BuildContext context, {String? title, required String message}) {
  return MotionToast.success(
    title: title == null ? null : Text(title),
    description: Text(message),
    width: MediaQuery.of(context).size.width - 40,
    height: 80,
    position: MotionToastPosition.top,
    animationType: AnimationType.fromLeft,
    animationDuration: const Duration(milliseconds: 500),
  )..show(context);
}

String version = 'loading';

void setVersion() async => version = (await PackageInfo.fromPlatform()).version;
