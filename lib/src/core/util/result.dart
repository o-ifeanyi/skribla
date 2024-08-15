import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T value) = _SuccessResult;
  const factory Result.error(CustomError error) = _ErrorResult;
}

enum ErrorReason {
  unknown('unknown'),
  noPoints('No points on the board');

  const ErrorReason(this.value);
  final String value;
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
