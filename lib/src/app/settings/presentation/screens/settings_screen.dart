import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/settings/presentation/widgets/custom_list_tile.dart';
import 'package:skribla/src/app/settings/presentation/widgets/settings_auth.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/service/support.dart';
import 'package:skribla/src/core/theme/app_theme.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/default_app_bar.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hapticsOn = ref.watch(settingsProvider.select((it) => it.hapticsOn));

    return Scaffold(
      appBar: DefaultAppBar(
        title: Text(
          'Settings',
          style: context.textTheme.bodyLarge,
        ),
      ),
      body: ListView(
        padding: Config.all(15),
        children: [
          Text(
            'General',
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          Config.vBox12,
          CustomListTile(
            icon: AppIcons.vibrate,
            title: 'Haptics',
            trailing: Switch.adaptive(
              value: hapticsOn,
              onChanged: ref.read(settingsProvider.notifier).toggleHaptics,
            ),
          ),
          Config.vBox12,
          Text(
            'Theme',
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          Config.vBox12,
          CupertinoSlidingSegmentedControl<ThemeOptions>(
            groupValue: ref.watch(themeProvider),
            padding: Config.symmetric(h: 8, v: 12),
            backgroundColor: context.theme.inputDecorationTheme.fillColor!,
            thumbColor: context.colorScheme.surface,
            children: const {
              ThemeOptions.light: Text('Light'),
              ThemeOptions.dark: Text('Dark'),
              ThemeOptions.system: Text('System'),
            },
            onValueChanged: (option) {
              if (option != null) {
                ref.read(themeProvider.notifier).setTheme(option);
              }
            },
          ),
          Config.vBox12,
          Text(
            'Support',
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (!kIsWeb) ...[
            Config.vBox12,
            CustomListTile(
              icon: AppIcons.star,
              title: 'Leave a review',
              onTap: Support.instance.openStoreListing,
            ),
          ],
          Config.vBox12,
          CustomListTile(
            icon: AppIcons.envelopeSimple,
            title: 'Contact support',
            onTap: Support.instance.contactSupport,
          ),
          Config.vBox12,
          Text(
            'About',
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          Config.vBox12,
          CustomListTile(
            icon: AppIcons.shield,
            title: 'Privacy policy',
            onTap: Support.instance.openPrivacy,
          ),
          Config.vBox12,
          CustomListTile(
            icon: AppIcons.listChecks,
            title: 'Terms of service',
            onTap: Support.instance.openTerms,
          ),
          SizedBox(height: Config.height * 0.3),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: Config.all(15),
            child: const SettingsAuth(),
          ),
          Config.vBox16,
        ],
      ),
    ).watchBuild('SettingsScreen');
  }
}
