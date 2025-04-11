import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_my_students_state.freezed.dart';

@freezed
class GetMyStudentsState<T> with _$GetMyStudentsState<T> {
  const factory GetMyStudentsState.initial() = _Initial;
  const factory GetMyStudentsState.loading() = Loading;
  const factory GetMyStudentsState.success(T studentsData) = Success<T>;
  const factory GetMyStudentsState.error({required String error}) = Error;
}
