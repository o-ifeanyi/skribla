import 'dart:io';

import 'package:draw_and_guess/src/app/auth/data/repository/auth_repository.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/resource/app_icons.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/widgets/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsAuth extends ConsumerWidget {
  const SettingsAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null || user.isAnonymous) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sign in to save progress',
                textAlign: TextAlign.center,
              ),
              Config.vBox12,
              if (!kIsWeb && Platform.isIOS) ...[
                AppButton(
                  icon: Icon(AppIcons.appleLogo),
                  text: 'Continue with Apple',
                  onPressed: () =>
                      ref.read(authProvider.notifier).signInWithProvider(AuthOptions.apple),
                ),
              ] else ...[
                AppButton(
                  icon: Icon(AppIcons.googleLogo),
                  text: 'Continue with Google',
                  onPressed: () =>
                      ref.read(authProvider.notifier).signInWithProvider(AuthOptions.google),
                ),
              ],
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                icon: Icon(AppIcons.trashSimple),
                text: 'Delete account',
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: Config.radius8,
                  ),
                ),
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: const Text(
                          'Are you sure?',
                          textAlign: TextAlign.center,
                        ),
                        content: const Text(
                          'Deleting your account cannot be reversed.',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          AppButton(
                            type: ButtonType.text,
                            text: 'Cancel',
                            onPressed: () => context.pop(false),
                          ),
                          AppButton(
                            type: ButtonType.text,
                            text: 'Delete',
                            onPressed: () => context.pop(true),
                          ),
                        ],
                      );
                    },
                  ).then((proceed) {
                    if (proceed != true) return;
                    ref.read(authProvider.notifier).deleteAccount().then((success) {
                      if (success) context.pop();
                    });
                  });
                },
              ),
            ],
          );
        }
      },
    );
  }
}
