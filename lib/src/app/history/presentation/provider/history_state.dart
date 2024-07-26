import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/history_state.freezed.dart';

enum HistoryStatus { idle, gettingHistory }

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default(HistoryStatus.idle) HistoryStatus status,
  }) = _HistoryState;
}
