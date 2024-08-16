import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/settings/presentation/widgets/custom_list_tile.dart';
import 'package:skribla/src/app/settings/presentation/widgets/settings_auth.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/service/analytics.dart';
import 'package:skribla/src/core/service/support.dart';
import 'package:skribla/src/core/theme/app_theme.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/default_app_bar.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Analytics.instance.capture(Event.viewSettings);
  }

  @override
  Widget build(BuildContext context) {
    final hapticsOn = ref.watch(settingsProvider.select((it) => it.hapticsOn));

    return Scaffold(
      appBar: DefaultAppBar(
        title: Text(
          context.loc.settingsBtnTxt,
          style: context.textTheme.bodyLarge,
        ),
      ),
      body: ListView(
        padding: Config.all(15),
        children: [
          if (!kIsWeb) ...[
            Text(
              context.loc.general,
              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            Config.vBox12,
            CustomListTile(
              icon: AppIcons.vibrate,
              title: context.loc.haptics,
              trailing: Switch.adaptive(
                value: hapticsOn,
                onChanged: ref.read(settingsProvider.notifier).toggleHaptics,
              ),
            ),
            Config.vBox12,
          ],
          Text(
            context.loc.theme,
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          Config.vBox12,
          CupertinoSlidingSegmentedControl<ThemeOptions>(
            groupValue: ref.watch(themeProvider),
            padding: Config.symmetric(h: 8, v: 12),
            backgroundColor: context.theme.inputDecorationTheme.fillColor!,
            thumbColor: context.colorScheme.surface,
            children: {
              ThemeOptions.light: Text(context.loc.light),
              ThemeOptions.dark: Text(context.loc.dark),
              ThemeOptions.system: Text(context.loc.system),
            },
            onValueChanged: (option) {
              if (option != null) {
                ref.read(themeProvider.notifier).setTheme(option);
              }
            },
          ),
          Config.vBox12,
          Text(
            context.loc.support,
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (!kIsWeb) ...[
            Config.vBox12,
            CustomListTile(
              icon: AppIcons.star,
              title: context.loc.leaveReview,
              onTap: Support.instance.openStoreListing,
            ),
          ],
          Config.vBox12,
          CustomListTile(
            icon: AppIcons.envelopeSimple,
            title: context.loc.contactSupport,
            onTap: Support.instance.contactSupport,
          ),
          Config.vBox12,
          Text(
            context.loc.about,
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          Config.vBox12,
          CustomListTile(
            icon: AppIcons.shield,
            title: context.loc.privacyPolicy,
            onTap: Support.instance.openPrivacy,
          ),
          Config.vBox12,
          CustomListTile(
            icon: AppIcons.listChecks,
            title: context.loc.termsOfService,
            onTap: Support.instance.openTerms,
          ),
          SizedBox(height: Config.height * 0.3),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Config.vBox8,
          Padding(
            padding: Config.symmetric(h: 15),
            child: const SettingsAuth(),
          ),
          Config.vBox30,
        ],
      ),
    );
  }
}
