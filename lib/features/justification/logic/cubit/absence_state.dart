import 'package:freezed_annotation/freezed_annotation.dart';
part 'absence_state.freezed.dart';

@freezed
class AbsenceState<T> with _$AbsenceState<T> {
  const factory AbsenceState.initial() = _Initial;
  const factory AbsenceState.loading() = Loading;
  const factory AbsenceState.loaded(T absenceResponse) = Loaded<T>;
  const factory AbsenceState.error({required String error}) = Error;
  const factory AbsenceState.sending() = Sending;
  const factory AbsenceState.sendSuccess(T standarData) = SendSuccess<T>;
}
