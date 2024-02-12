
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class MyHttp {


  static Future<http.Response?> multipart({
    String multipartRequestType = 'POST', // POST or GET
    required String url,
    //Single Image Upload
    File? image,
    String? imageKey,
    Map<String, dynamic>? bodyParams,
    //Upload with Multiple key
    Map<String, File>? imageMap,
    //Upload with Single key
    List<File>? images,
  }) async {
    String? token = '';
    if (kDebugMode) print("bodyParams:: ${bodyParams ?? {}}");
    if (kDebugMode) print("URL:: $url");
    if (kDebugMode) print("TOKEN:: $token");
    try {
      http.Response res;
      var request =
      http.MultipartRequest(multipartRequestType, Uri.parse(url));
      request.headers.addAll({'Content-Type': 'multipart/form-data'});
      request.headers.addAll({'Accept': 'application/json'});
      request.headers['Authorization'] = token ?? '';
      if (kDebugMode) print("CALLING:: $url");
      //Single Image Upload
      if (image != null && imageKey != null) {
        if (kDebugMode) print("imageKey:: $imageKey   image::$image");
        request.files.add(getUserProfileImageFile(
            image: image, userProfileImageKey: imageKey));
      }
      //Upload with Multiple key
      if (imageMap != null) {
        if (kDebugMode) print("imageMap:: $imageMap");
        imageMap.forEach((key, value) {
          request.files.add(getUserProfileImageFile(
              image: value, userProfileImageKey: key));
        });
      }
      //Upload with Single key
      if (images != null && imageKey != null) {
        for (int i = 0; i < images.length; i++) {
          request.files.add(getUserProfileImageFile(
              image: images[i], userProfileImageKey: imageKey));
          /*var stream = http.ByteStream(images[i].openRead());
            var length = await images[i].length();
            var multipartFile = http.MultipartFile(imageKey, stream, length,
                filename: images[i].path);
            request.files.add(multipartFile);*/
        }
      }

      if (bodyParams != null) {
        if (kDebugMode) print("bodyParams:: $bodyParams");
        bodyParams.forEach((key, value) {
          request.fields[key] = value;
        });
      }
      var response = await request.send();
      res = await http.Response.fromStream(response);
      if (kDebugMode) print("CALLING:: ${res.body}");
      print("Responce:-"+res.body.toString());
      return res;
    } catch (e) {
      if (kDebugMode) print("EXCEPTION:: Server Down");
      return null;
    }
  }

  static http.MultipartFile getUserProfileImageFile(
      {File? image, required String userProfileImageKey}) {
    return http.MultipartFile.fromBytes(
      userProfileImageKey,
      image!.readAsBytesSync(),
      filename: image.uri.pathSegments.last,
    );
  }
}