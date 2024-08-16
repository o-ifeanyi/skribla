import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/app/auth/data/repository/auth_repository.dart';
import 'package:skribla/src/app/auth/presentation/provider/auth_state.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/app_button.dart';

class SettingsAuth extends ConsumerWidget {
  const SettingsAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((it) => it.user));
    final status = ref.watch(authProvider.select((it) => it.status));

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data == null || user == null || user.status == UserStatus.anonymous) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.loc.signinToSaveProgress,
                textAlign: TextAlign.center,
              ),
              Config.vBox12,
              if (!kIsWeb && Platform.isIOS) ...[
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        icon: Icon(AppIcons.appleLogo),
                        text: context.loc.apple,
                        onPressed: status == AuthStatus.signingIn
                            ? null
                            : () => ref
                                .read(authProvider.notifier)
                                .signInWithProvider(AuthOptions.apple),
                      ),
                    ),
                    Config.hBox12,
                    Expanded(
                      child: AppButton(
                        icon: Icon(AppIcons.googleLogo),
                        text: context.loc.google,
                        onPressed: status == AuthStatus.signingIn
                            ? null
                            : () => ref
                                .read(authProvider.notifier)
                                .signInWithProvider(AuthOptions.google),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                AppButton(
                  icon: Icon(AppIcons.googleLogo),
                  text: context.loc.continueWithGoogle,
                  onPressed: status == AuthStatus.signingIn
                      ? null
                      : () =>
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
                text: context.loc.deleteAccount,
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: Config.radius8,
                  ),
                ),
                onPressed: status == AuthStatus.deletingAccount
                    ? null
                    : () {
                        showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog.adaptive(
                              title: Text(
                                context.loc.areYouSure,
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                context.loc.deleteAccountWarning,
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                AppButton(
                                  type: ButtonType.text,
                                  text: context.loc.cancel,
                                  onPressed: () => context.pop(false),
                                ),
                                AppButton(
                                  type: ButtonType.text,
                                  text: context.loc.delete,
                                  onPressed: () => context.pop(true),
                                ),
                              ],
                            );
                          },
                        ).then((proceed) {
                          if (proceed != true) return;
                          ref.read(authProvider.notifier).deleteAccount();
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
