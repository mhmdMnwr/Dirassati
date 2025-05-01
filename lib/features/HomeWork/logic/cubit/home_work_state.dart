import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_work_state.freezed.dart';

@freezed
class HomeWorkState<T> with _$HomeWorkState<T> {
  const factory HomeWorkState.initial() = _Initial;
  const factory HomeWorkState.loading() = Loading;
  const factory HomeWorkState.loaded(T homeWorkResponse) = Loaded<T>;
  const factory HomeWorkState.error({required String error}) = Error;
}
