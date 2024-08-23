import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skribla/src/core/service/haptics.dart';
import 'package:toastification/toastification.dart';

/// A singleton class for managing toast notifications.
///
/// This class is responsible for displaying toast notifications to the user. It provides a centralized way to show error and success messages with optional titles.
/// It also integrates with the Haptics class to generate haptic feedback when a toast is shown.
/// The class uses a StreamController to manage the stream of toast notifications, allowing for easy subscription and handling of toast events.
///
/// Key features:
/// - Provides a singleton instance for accessing toast notification functionality throughout the app.
/// - Offers methods for showing error and success toast notifications with optional titles.
/// - Generates haptic feedback when a toast is shown.
/// - Manages a stream of toast notifications for easy subscription and handling.
///
/// Usage:
/// This class is typically used to show toast notifications in response to user actions or system events.
/// For example, when a user submits a form successfully, the `showSuccess` method can be called to show a success toast.
/// Similarly, the `showError` method can be used to show an error toast in case of a failure.
/// The `stream` property can be subscribed to handle toast events, such as displaying the toast or logging the message.

class Toast {
  Toast._internal();
  static final _singleton = Toast._internal();
  static Toast get instance => _singleton;

  final StreamController<ToastModel> _controller = StreamController<ToastModel>();

  Stream<ToastModel> get stream => _controller.stream;
  bool get hasListener => _controller.hasListener;

  void showError(String message, {String? title}) {
    _controller.add(
      ToastModel(title: title, message: message, type: ToastificationType.error),
    );
    Haptics.instance.mediumImpact();
  }

  void showSucess(String message, {String? title}) {
    _controller.add(
      ToastModel(title: title, message: message, type: ToastificationType.success),
    );
    Haptics.instance.mediumImpact();
  }

  void dispose() => _controller.close();
}

class ToastModel {
  ToastModel({
    required this.title,
    required this.message,
    required this.type,
  });

  final String? title;
  final String message;
  final ToastificationType type;
}

class ToastProvider extends StatefulWidget {
  const ToastProvider({required this.child, super.key});

  final Widget child;

  @override
  State<ToastProvider> createState() => _ToastProviderState();
}

class _ToastProviderState extends State<ToastProvider> {
  void _showToast(ToastModel data) {
    toastification.show(
      context: context,
      type: data.type,
      style: ToastificationStyle.fillColored,
      title: data.title != null ? Text(data.title!) : null,
      description: Text(data.message),
      alignment: Alignment.topCenter,
      applyBlurEffect: true,
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Toast.instance.hasListener) return;
      Toast.instance.stream.listen(_showToast);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(child: widget.child);
  }
}
