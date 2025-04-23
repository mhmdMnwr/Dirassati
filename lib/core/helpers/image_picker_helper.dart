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
    List<File> selectedFiles = [];
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery (Select Multiple)'),
                onTap: () async {
                  Navigator.of(context).pop(); // Close the sheet first
                  final files = await pickMultiImageFromGallery();
                  selectedFiles.addAll(files);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera (Select One)'),
                onTap: () async {
                  Navigator.of(context).pop(); // Close the sheet first
                  if (currentCount < maxLimit) {
                    // Check limit before picking
                    final file = await pickSingleImageFromCamera();
                    if (file != null) {
                      selectedFiles.add(file);
                    }
                  } else {
                    // Optional: Show a message if needed, but handled in calling page
                    debugPrint(
                        "Max image limit reached, cannot add via camera.");
                  }
                },
              ),
            ],
          ),
        );
      },
    );

    await Future.delayed(Duration.zero);
    return selectedFiles;
  }
}
