import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_images_state.freezed.dart';

@freezed
class UploadImagesState<T> with _$UploadImagesState<T> {
  const factory UploadImagesState.initial() = _Initial;
  const factory UploadImagesState.uploadLoading() = UploadLoading;
  const factory UploadImagesState.uploadSuccess(T uploadResponse) =
      UploadSuccess<T>;
  const factory UploadImagesState.uploadError({required String error}) =
      UploadError;
}
