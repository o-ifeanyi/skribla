import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T value) = _SuccessResult;
  const factory Result.error(CustomError error) = _ErrorResult;
}

class CustomError implements Exception {
  const CustomError({
    required this.message,
    this.error = '',
  });
  final String message;
  final String error;

  @override
  String toString() => 'Error: $error, Message: $message';
}
