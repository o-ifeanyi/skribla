import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skribla/src/core/util/enums.dart';

part 'generated/result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T value) = _SuccessResult;
  const factory Result.error(CustomError error) = _ErrorResult;
}

class CustomError implements Exception {
  const CustomError({
    required this.message,
    this.reason = ErrorReason.unknown,
  });
  final String message;
  final ErrorReason reason;

  @override
  String toString() => 'Message: $message Reason: ${reason.value}';
}
