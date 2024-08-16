import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';

class InputField extends StatelessWidget {
  const InputField({
    this.onChanged,
    super.key,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.onTap,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforcement,
    this.header,
    this.hint,
    this.preficIcon,
    this.suffixIcon,
    this.fillColor,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.optional = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters = const [],
  });
  final void Function(String)? onChanged;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final String? header;
  final String? hint;
  final int? maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final Widget? preficIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final bool readOnly;
  final bool optional;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) ...[
          Text(header!),
          Config.vBox12,
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          initialValue: initialValue,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          maxLength: maxLength,
          textAlign: textAlign,
          maxLengthEnforcement: maxLengthEnforcement,
          style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            prefix: preficIcon,
            suffixIcon: suffixIcon,
            fillColor: fillColor,
            hintText: hint,
            hintStyle: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: Config.radius16,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.primary,
                width: 1.5,
              ),
              borderRadius: Config.radius16,
            ),
          ),
        ),
      ],
    );
  }
}
