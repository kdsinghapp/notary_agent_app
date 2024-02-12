import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'errors.dart';

export 'dart:convert';
export 'dart:io';

export 'package:dio/dio.dart';

export 'errors.dart';

extension on Response {
  Response<T> copyWith<T>({
    T? data,
    Headers? headers,
    RequestOptions? requestOptions,
    bool? isRedirect,
    int? statusCode,
    String? statusMessage,
    List<RedirectRecord>? redirects,
    Map<String, dynamic>? extra,
  }) {
    return Response(
      data: data ?? this.data,
      headers: headers ?? this.headers,
      requestOptions: requestOptions ?? this.requestOptions,
      isRedirect: isRedirect ?? this.isRedirect,
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      redirects: redirects ?? this.redirects,
      extra: extra ?? this.extra,
    );
  }
}

Dio api() {
  final api = Dio(
    BaseOptions(
      baseUrl: 'https://dcmdmobilenotary.com/laravel/api/',
      connectTimeout: const Duration(milliseconds: 30000),
      contentType: 'application/json',
      responseType: ResponseType.plain,
    ),
  );
  api.interceptors.add(
    InterceptorsWrapper(
      onRequest: (reqOpt, interceptorHandler) async {
        // final data = reqOpt.data;
        if (kDebugMode) {
          log('${reqOpt.method} ${reqOpt.uri}\n Body: ${reqOpt.data}\n Query Parameters: ${reqOpt.queryParameters}\n Request Headers: ${reqOpt.headers}');
        }
        // if (data is Map) {
        //   final body = FormData.fromMap(data as Map<String, dynamic>);
        //   for (var i = 0; i < data.length; i++) {
        //     final key = data.keys.elementAt(i);
        //     final value = data.values.elementAt(i);
        //     if (value is File) {
        //       body.files.add(MapEntry(key, await MultipartFile.fromFile(value.path, filename: basename(value.path))));
        //     }
        //   }

        //   reqOpt.data = body;
        //   return interceptorHandler.next(reqOpt);
        // }
        return interceptorHandler.next(reqOpt);
      },
      onError: (error, interceptorHandler) {
        if (kDebugMode) log('ErrorType: ${error.type}\n ErrorMessage: ${error.message}');
        if (kDebugMode && error.response != null) {
          log('Response: ${error.response!.data}\nStatus: ${error.response!.statusCode}, ${error.response!.statusMessage}\n error.Responseresponse! Headers: ${error.response!.headers}');
        }
        if (error.type == DioErrorType.connectionTimeout) {
          return interceptorHandler.reject(
            DioError(
              requestOptions: error.requestOptions,
              response: error.response,
              error: MyError('Request Timeout, Please try again later.'),
            ),
          );
        } else if (error.type == DioErrorType.badResponse) {
          return interceptorHandler.reject(
            DioError(
              requestOptions: error.requestOptions,
              response: error.response,
              error: MyError(
                '${error.response?.statusMessage ?? "Internal Server Error"}\nError Code: ${error.response?.statusCode}',
              ),
            ),
          );
        } else if (error.type == DioErrorType.cancel) {
          return interceptorHandler.reject(
            DioError(
              requestOptions: error.requestOptions,
              response: error.response,
              type: DioErrorType.cancel,
            ),
          );
        }
        return interceptorHandler.reject(error);
      },
      onResponse: (res, interceptorHandler) {
        if (kDebugMode) log('Response: ${res.data}\nStatus: ${res.statusCode}, ${res.statusMessage}\n Response Headers: ${res.headers}');
        try {
          final resJson = json.decode(res.data);
          if (res.requestOptions.extra['checkStatus'] ?? true) {
            if (resJson is Map) {
              if (resJson['status'] != '1' && resJson['status'] != 1 && resJson['status'] != 'true' && resJson['result'] is! List) {
                if (resJson['result'] is String) {
                  return interceptorHandler.reject(
                    DioError(
                      requestOptions: res.requestOptions,
                      response: res,
                      error: MyError(resJson['result']),
                    ),
                  );
                } else if (resJson['message'] != 'unsuccessfull' && resJson['message'] is String) {
                  return interceptorHandler.reject(
                    DioError(
                      requestOptions: res.requestOptions,
                      response: res,
                      error: MyError(resJson['message']),
                    ),
                  );
                } else {
                  return interceptorHandler.reject(
                    DioError(
                      requestOptions: res.requestOptions,
                      response: res,
                      error: MyError(res.requestOptions.extra['defaultErrorMessage'] ?? 'Unknown Error Occured.'),
                    ),
                  );
                }
              }
            }
          }

          return interceptorHandler.next(res.copyWith(data: resJson));
        } catch (e) {
          interceptorHandler.resolve(res);
        }
      },
    ),
  );
  return api;
}
