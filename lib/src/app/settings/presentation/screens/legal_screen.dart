import 'package:draw_and_guess/src/app/settings/data/repository/settings_repository.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/widgets/default_app_bar.dart';
import 'package:draw_and_guess/src/core/widgets/error_widget.dart';
import 'package:draw_and_guess/src/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LegalScreen extends ConsumerStatefulWidget {
  const LegalScreen({required this.name, super.key});

  final String name;

  @override
  ConsumerState<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends ConsumerState<LegalScreen> {
  final getLegal = FutureProvider.family<String, LegalType>(
    (ref, type) async {
      return ref.read(settingsProvider.notifier).getLegalDoc(type);
    },
  );

  @override
  Widget build(BuildContext context) {
    final legalRef = ref.watch(getLegal(LegalType.values.byName(widget.name)));
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text(
          widget.name.capitalize,
          style: context.textTheme.bodyLarge,
        ),
      ),
      body: legalRef.when(
        skipLoadingOnRefresh: false,
        data: (data) {
          return SingleChildScrollView(
            padding: Config.all(15),
            child: Text(data),
          );
        },
        error: (error, __) {
          return Padding(
            padding: Config.all(15),
            child: ErrorWidget(
              retry: () => ref.refresh(
                getLegal.call(LegalType.values.byName(widget.name)),
              ),
            ),
          );
        },
        loading: () {
          return ListView.separated(
            itemCount: 15,
            padding: Config.all(15),
            separatorBuilder: (_, __) => Config.vBox12,
            itemBuilder: (context, index) {
              return ShimmerWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: Config.width * 0.3,
                      color: context.colorScheme.surface,
                    ),
                    Config.vBox4,
                    Container(
                      height: 14,
                      width: double.infinity,
                      color: context.colorScheme.surface,
                    ),
                    Config.vBox4,
                    Container(
                      height: 14,
                      width: Config.width * 0.6,
                      color: context.colorScheme.surface,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
