import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/app_button.dart';
import 'package:skribla/src/core/widgets/input_field.dart';

class ReportReasonSheet extends StatefulWidget {
  const ReportReasonSheet({
    this.username = '',
    super.key,
  });

  final String username;

  @override
  State<ReportReasonSheet> createState() => _ReportReasonSheetState();
}

class _ReportReasonSheetState extends State<ReportReasonSheet> {
  final _msgCtrl = TextEditingController();

  void _continue() {
    context.pop(_msgCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.copyWith(
        top: Config.h(15),
        left: Config.w(15),
        right: Config.w(15),
        bottom: context.viewInsets.bottom + (kIsWeb ? 8 : 30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.loc.report(widget.username).trim(),
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Config.vBox12,
          InputField(
            controller: _msgCtrl,
            hint: context.loc.reasonForReporting,
            maxLines: null,
            textInputAction: TextInputAction.send,
            onFieldSubmitted: (_) => _continue(),
          ),
          Config.vBox24,
          ValueListenableBuilder(
            valueListenable: _msgCtrl,
            builder: (context, ctrl, child) {
              return AppButton(
                text: context.loc.continueBtnTxt,
                onPressed: ctrl.text.trim().isEmpty ? null : _continue,
              );
            },
          ),
        ],
      ),
    );
  }
}
