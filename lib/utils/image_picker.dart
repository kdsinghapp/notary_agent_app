import 'dart:async';
import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

export 'package:image_cropper/image_cropper.dart';
export 'package:image_picker/image_picker.dart';

class ImageCropPicker {
  final ImagePicker _picker = ImagePicker();
  Future<File?> pickImage(
    BuildContext context, {
    bool cropImage = true,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    CropAspectRatio? aspectRatio,
    ImageSource? source,
    List<CropAspectRatioPreset> aspectRatioPresets =
        const <CropAspectRatioPreset>[
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    CropStyle cropStyle = CropStyle.rectangle,
    ImageCompressFormat compressFormat = ImageCompressFormat.jpg,
    int compressQuality = 90,
    List<PlatformUiSettings>? uiSettings,
  }) async {
    final Completer<XFile?> completer = Completer<XFile?>();
    if (source != null) {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      completer.complete(pickedFile);
    } else {
      showAdaptiveActionSheet<File?>(
        context: context,
        title: const Text('Select Image from'),
        bottomSheetColor: Colors.white,
        actions: <BottomSheetAction>[
          BottomSheetAction(
            title: const Text('Gallery'),
            onPressed: (context) async {
              final XFile? pickedFile = await _picker.pickImage(
                source: ImageSource.gallery,
              );

              completer.complete(pickedFile);
            },
          ),
          BottomSheetAction(
            title: const Text('Camera'),
            onPressed: (context) async {
              final XFile? pickedFile = await _picker.pickImage(
                source: ImageSource.camera,
              );
              completer.complete(pickedFile);
            },
          ),
        ],
        cancelAction: CancelAction(
          title: const Text('Cancel'),
        ),
      );
    }
    final XFile? pickedFile = await completer.future;

    if (source == null) Get.back();
    if (pickedFile == null) {
      return null;
    }
    if (!cropImage) {
      return File(pickedFile.path);
    }
    // if (Platform.isAndroid) return File(pickedFile.path);
    return cropFile(
      sourcePath: pickedFile.path,
      maxWidth: maxWidth?.round(),
      maxHeight: maxHeight?.round(),
      aspectRatio: aspectRatio,
      aspectRatioPresets: aspectRatioPresets,
      cropStyle: cropStyle,
      compressFormat: compressFormat,
      compressQuality: compressQuality,
      uiSettings: uiSettings,
    );
  }

  Future<File?> cropFile({
    required String sourcePath,
    int? maxWidth,
    int? maxHeight,
    CropAspectRatio? aspectRatio,
    List<CropAspectRatioPreset> aspectRatioPresets =
        const <CropAspectRatioPreset>[
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    CropStyle cropStyle = CropStyle.rectangle,
    ImageCompressFormat compressFormat = ImageCompressFormat.jpg,
    int compressQuality = 90,
    List<PlatformUiSettings>? uiSettings,
  }) async {
    final ret = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      aspectRatio: aspectRatio,
      aspectRatioPresets: aspectRatioPresets,
      cropStyle: cropStyle,
      compressFormat: compressFormat,
      compressQuality: compressQuality,
      uiSettings: uiSettings,
    );
    if (ret == null) {
      return null;
    }
    return File(ret.path);
  }
}
