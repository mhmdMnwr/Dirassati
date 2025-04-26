import 'dart:io';

import 'package:dirasati/features/justification/data/repo/upload_images.dart';
import 'package:dirasati/features/justification/logic/cubit/upload_images_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadImagesCubit extends Cubit<UploadImagesState> {
  final ImageUploadRepository _uploadRepo;
  UploadImagesCubit(this._uploadRepo) : super(UploadImagesState.initial());

  void uploadImages(List<File> imagePaths) async {
    emit(UploadImagesState.uploadLoading());

    final response = await _uploadRepo.uploadImages(imagePaths);
    response.when(success: (imagesUrlList) {
      emit(UploadImagesState.uploadSuccess(imagesUrlList));
    }, failure: (error) {
      emit(UploadImagesState.uploadError(error: error.toString()));
    });
  }
}
