import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_parent_state.freezed.dart';

@freezed
class UpdateParentState<T> with _$UpdateParentState<T> {
  const factory UpdateParentState.initial() = _Initial;
  const factory UpdateParentState.loading() = Loading;
  const factory UpdateParentState.success(T getMeResponse) = Success<T>;
  const factory UpdateParentState.error({required String error}) = Error;
}
