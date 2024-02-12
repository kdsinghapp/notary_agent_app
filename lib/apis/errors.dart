import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class RequestTimeoutError implements Exception {}

class InvalidToken implements Exception {}

class UnknownError extends MyError {
  UnknownError() : super('Unknown Error occured.');
}

class MyError implements Exception {
  MyError(this.message);

  @override
  String toString() => 'Error: $message';

  final String message;
  factory MyError.fromError([dynamic error]) {
    if (error is MyError) {
      return error;
    }
    if (error is String) {
      return MyError(error);
    }
    if (error is DioError) {
      if (error.error is MyError) {
        return error.error as MyError;
      }
      if (error.message != null) return MyError(error.message!);
    }
    return UnknownError();
  }
}

MotionToast? showError(BuildContext context, Object e, {void Function()? onSubmit, String? title}) {
  if (e is DioError && e.type == DioErrorType.cancel) {
    return null;
  }

  return MotionToast.error(
    title: Text(title ?? 'Error'),
    description: Text(MyError.fromError(e).message),
    width: MediaQuery.of(context).size.width - 40,
    position: MotionToastPosition.top,
    animationType: AnimationType.fromLeft,
    animationDuration: const Duration(milliseconds: 500),
  )..show(context);

  // showDialog<void>(
  //   context: context,
  //   builder: (BuildContext context) => Dialog(
  //     backgroundColor: Colors.transparent,
  //     insetPadding: const EdgeInsets.symmetric(horizontal: 24),
  //     child: Container(
  //       decoration: const BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.all(Radius.circular(24)),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           const SizedBox(height: 8),
  //           FittedBox(
  //             child: Text(
  //               title ?? 'Alert',
  //               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           Flexible(
  //             child: Text(
  //               TRKError.fromError(e).message,
  //               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
  //             ),
  //           ),
  //           const SizedBox(height: 16),
  //           Container(height: 1, color: const Color(0x0DFFFFFF)),
  //           const SizedBox(height: 16),
  //           SizedBox(
  //             height: 40,
  //             child: Row(
  //               children: <Widget>[
  //                 Expanded(
  //                   child: Container(
  //                     decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(200)),
  //                     child: Material(
  //                       color: Colors.transparent,
  //                       child: InkWell(
  //                         splashColor: Colors.transparent,
  //                         onTap: () {
  //                           onSubmit?.call();
  //                           Navigator.of(context).pop();
  //                         },
  //                         borderRadius: BorderRadius.circular(100),
  //                         child: Container(
  //                           alignment: Alignment.center,
  //                           padding: const EdgeInsets.only(left: 4, right: 4),
  //                           child: const Text(
  //                             'OK',
  //                             style: TextStyle(color: Color(0xFF1B1C20), fontWeight: FontWeight.w600, fontSize: 14),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  // );
}
