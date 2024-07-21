import 'package:draw_and_guess/src/core/service/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _logger = Logger('Provider Watch');

class ProviderWatch extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    _logger.watch('$provider initialized');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    _logger.watch('$provider disposed');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    _logger.watch('$provider threw $error at $stackTrace');
  }
}
