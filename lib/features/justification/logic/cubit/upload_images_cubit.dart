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
      emit(UploadImagesState.uploadError(
          error: error.apiErrorModel.message ?? ''));
    });
  }

  void fetchImageFile(List<String> imageName) async {
    emit(UploadImagesState.fetchLoading());

    final response = await _uploadRepo.fetchImageFile(imageName);
    response.when(success: (imagesUrlList) {
      emit(UploadImagesState.fetchSuccess(imagesUrlList));
    }, failure: (error) {
      emit(UploadImagesState.fetchError(
          error: error.apiErrorModel.message ?? ''));
    });
  }

  void emitUpdateState() {
    emit(const UploadImagesState.edit());
  }

  /// This method is used to emit the elimination state im using it to tell the upload
  /// images cubit to eliminate the current state therfor my page is not going to stuck in the justification page
  void eliminateState() {
    emit(const UploadImagesState.eliminate());
  }
}
