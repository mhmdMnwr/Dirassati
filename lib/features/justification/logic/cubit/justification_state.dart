import 'package:freezed_annotation/freezed_annotation.dart';
part 'justification_state.freezed.dart';

@freezed
class JustificationState<T> with _$JustificationState<T> {
  const factory JustificationState.initial() = _Initial;
  const factory JustificationState.loading() = Loading;
  const factory JustificationState.success(T standardResponse) = Success<T>;
  const factory JustificationState.error({required String error}) = Error;
}
