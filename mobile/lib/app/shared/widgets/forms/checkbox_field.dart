import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';

class AppCheckBoxField extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String name;
  final String? title;
  final TextStyle? titleStyle;
  final bool initialValue;
  final bool disabled;
  final bool isRequired;
  final FocusNode? focusNode;
  final void Function(bool?)? onChanged;
  final Widget? secondary;
  final ListTileControlAffinity? controlAffinity;

  const AppCheckBoxField({
    required this.formKey,
    required this.name,
    super.key,
    this.title = '',
    this.initialValue = false,
    this.isRequired = false,
    this.disabled = false,
    this.focusNode,
    this.onChanged,
    this.secondary,
    this.controlAffinity,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name,
      initialValue: initialValue,
      enabled: !disabled,
      builder: (field) {
        return Container(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: field.value,
                  activeColor: disabled
                      ? $r.theme.grey2
                      : Theme.of(context).colorScheme.primary,
                  onChanged: (p0) => disabled ? null : field.didChange(p0),
                  focusNode: focusNode,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                ),
              ),
              const Gap(8),
              Row(
                children: [
                  GestureDetector(
                    onTap: disabled
                        ? null
                        : () {
                            field.didChange(!field.value!);
                            onChanged?.call(field.value);
                          },
                    child: Text(
                      title ?? '',
                      style: titleStyle ??
                          $r.styles.pSemiBold.copyWith(
                            fontSize: 12,
                            color: disabled
                                ? $r.theme.grey1
                                : Theme.of(gContext).colorScheme.primary,
                          ),
                    ),
                  ),
                  if (isRequired)
                    const Text(
                      ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
