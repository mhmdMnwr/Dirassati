import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<List<File>> pickMultiImageFromGallery() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      return pickedFiles.map((picked) => File(picked.path)).toList();
    }
    return [];
  }

  static Future<File?> pickSingleImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<List<File>> showImageSourceActionSheet(BuildContext context,
      {required int currentCount, required int maxLimit}) async {
    final result = await showModalBottomSheet<List<File>>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery (Select Multiple)'),
                onTap: () async {
                  final files = await pickMultiImageFromGallery();
                  Navigator.of(context).pop(files); // Return files
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera (Select One)'),
                onTap: () async {
                  if (currentCount < maxLimit) {
                    final file = await pickSingleImageFromCamera();
                    if (file != null) {
                      Navigator.of(context).pop([file]); // Return as list
                    } else {
                      Navigator.of(context).pop([]); // No file picked
                    }
                  } else {
                    debugPrint(
                        "Max image limit reached, cannot add via camera.");
                    Navigator.of(context).pop([]);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
    return result ?? [];
  }
}
