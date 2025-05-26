import 'package:freezed_annotation/freezed_annotation.dart';

part 'paiment_state.freezed.dart';

@freezed
class PaimentState<T> with _$PaimentState<T> {
  const factory PaimentState.initial() = _Initial;
  const factory PaimentState.loading() = Loading;
  const factory PaimentState.paimentLoaded(T paimentResponse) =
      PaimentLoaded<T>;
  const factory PaimentState.error({required String error}) = Error;
}
