import 'package:freezed_annotation/freezed_annotation.dart';

part 'marks_state.freezed.dart';

@freezed
class MarksState<T> with _$MarksState<T> {
  const factory MarksState.initial() = _Initial;
  const factory MarksState.loading() = Loading;
  const factory MarksState.yearsloaded(T marksResponse) = YearsLoaded<T>;
  const factory MarksState.error({required String error}) = Error;
  const factory MarksState.marksLoading() = MarksLoading;
  const factory MarksState.marksLoaded(T marksResponse) = MarksLoaded<T>;
  const factory MarksState.marksError({required String error}) = MarksError;
}
