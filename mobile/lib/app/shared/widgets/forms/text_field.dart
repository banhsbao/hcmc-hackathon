import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/styles/app_design.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';

import '../../utils/helpers/misc.dart';

class AppTextField extends StatefulWidget {
  final Color? borderColor;
  final Color? cursorColor;
  final Color? fillColor;
  final FocusNode? focusNode;
  final FormFieldValidator<String?>? validator;
  final GestureTapCallback? onPrefixIconTap;
  final GestureTapCallback? onSuffixIconTap;
  final GestureTapCallback? onTap;
  final GlobalKey<FormBuilderState> formKey;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final String name;
  final String? hintText;
  final String? initialValue;
  final String? labelText;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final String? suffixText;
  final String? title;
  final TextCapitalization textCapitalization;
  final TextInputAction? inputAction;
  final TextInputType keyBoardType;
  final TextStyle? textStyle;
  final bool? hasForgotPwd;
  final bool? isDouble;
  final bool? isNumberField;
  final bool? isPwd;
  final bool? isReadOnly;
  final bool? isRequired;
  final bool? isFocused;
  final bool? isScreenTitle;
  final double fieldHeight;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final void Function()? onEditingComplete;
  final void Function(String?)? onChanged;

  const AppTextField({
    required this.formKey,
    required this.name,
    super.key,
    this.borderColor,
    this.cursorColor,
    this.decoration,
    this.fieldHeight = 85,
    this.fillColor,
    this.focusNode,
    this.hasForgotPwd = false,
    this.labelText,
    this.hintText,
    this.suffixText = '',
    this.initialValue = '',
    this.inputAction = TextInputAction.next,
    this.inputFormatters,
    this.isPwd = false,
    this.isReadOnly = false,
    this.isRequired = false,
    this.isScreenTitle = false,
    this.isNumberField = false,
    this.isDouble = false,
    this.isFocused = false,
    this.keyBoardType = TextInputType.name,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onPrefixIconTap,
    this.onSuffixIconTap,
    this.onTap,
    this.prefixIcon,
    this.prefixIconPath,
    this.suffixIcon,
    this.suffixIconPath,
    this.textCapitalization = TextCapitalization.none,
    this.title,
    this.validator,
    this.textStyle,
    this.onEditingComplete,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isEditing = false;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    focusNode
      ..removeListener(_focusNodeListener)
      ..dispose();
    super.dispose();
  }

  void _focusNodeListener() {
    if (!focusNode.hasFocus) {
      setState(() => isEditing = false);
    } else {
      final formFieldValue =
          widget.formKey.currentState?.fields[widget.name]?.value;
      if (formFieldValue != null && formFieldValue.isNotEmpty) {
        setState(() => isEditing = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.isScreenTitle!)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Text(
                  widget.title ?? '',
                  style: $r.styles.pSemiBold.copyWith(
                    fontSize: 13,
                  ),
                ),
                if (widget.isRequired == true)
                  Text(
                    ' *',
                    style:
                        TextStyle(color: Theme.of(gContext).colorScheme.error),
                  ),
              ],
            ),
          ),
        SizedBox(
          height: widget.fieldHeight,
          child: FormBuilderTextField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorRadius: const Radius.circular(2),
            cursorColor: widget.cursorColor ??
                Theme.of(context).colorScheme.primary.withOpacity(0.8),
            enabled: !widget.isReadOnly!,
            focusNode: focusNode,
            autofocus: widget.isFocused!,
            initialValue: widget.initialValue?.trim(),
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.isNumberField!
                ? TextInputType.number
                : widget.keyBoardType,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            name: widget.name,
            obscureText: widget.isPwd!,
            onTap: widget.onTap,
            style: widget.textStyle ??
                $r.styles.pRegular.copyWith(
                  fontSize: 14,
                  decoration: TextDecoration.none,
                  decorationStyle: TextDecorationStyle.dotted,
                  decorationColor: Colors.white,
                ),
            onEditingComplete: widget.onEditingComplete,
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.inputAction,
            validator: widget.validator,
            valueTransformer: (value) => value?.trim(),
            onChanged: (value) {
              widget.formKey.currentState?.fields[widget.name]?.validate();
              widget.onChanged?.call(value);
              if (!widget.isReadOnly!) {
                setState(() => isEditing = true);
              }
            },
            decoration: widget.decoration ??
                AppDesign.inputDecorationTextField(
                  context,
                  borderColor:
                      widget.isReadOnly! ? $r.theme.grey3 : widget.borderColor,
                  fillColor:
                      widget.isReadOnly! ? $r.theme.grey3 : widget.fillColor,
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  suffixText: widget.suffixText,
                  prefixIcon: buildPrefixIcon(),
                  suffixIcon: buildSuffixIcon(
                    widget.name,
                    widget.formKey,
                  ),
                  isRequired: widget.isRequired,
                  isScreenTitle: widget.isScreenTitle,
                ),
          ),
        ),
      ],
    );
  }

  Widget? buildPrefixIcon() {
    Widget? icon;
    final primeColor = Theme.of(gContext).colorScheme.primary;

    if (widget.prefixIcon != null) {
      icon = Icon(
        widget.prefixIcon,
        size: 20,
        color: widget.isReadOnly! ? $r.theme.grey : primeColor,
      );
    } else if (widget.prefixIconPath != null) {
      icon = SvgPicture.asset(
        widget.prefixIconPath!,
        height: 22,
        width: 22,
        colorFilter: ColorFilter.mode(
          widget.isReadOnly! ? $r.theme.grey : primeColor,
          BlendMode.srcIn,
        ),
      );
    }

    return icon != null
        ? IconButton(
            onPressed: widget.onPrefixIconTap,
            padding: EdgeInsets.zero,
            icon: icon,
          )
        : widget.isNumberField!
            ? IconButton(
                onPressed: widget.isReadOnly!
                    ? null
                    : () {
                        final currentValue = widget
                            .formKey.currentState?.fields[widget.name]?.value
                            .toString();
                        final decreaseValue = widget.isDouble == true
                            ? handleChangeInputNumberDouble(
                                currentValue,
                                'DECREASE',
                              )
                            : handleChangeInputNumberInt(
                                currentValue,
                                'DECREASE',
                              );
                        final newValue = widget.isDouble == true
                            ? decreaseValue.toStringAsFixed(1)
                            : decreaseValue.round().toString();
                        widget.formKey.currentState?.fields[widget.name]
                            ?.didChange(newValue);
                      },
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: widget.isReadOnly!
                      ? $r.theme.grey
                      : Theme.of(gContext).colorScheme.error,
                  size: 20,
                ),
              )
            : null;
  }

  IntrinsicHeight buildSuffixIcon(
    String name,
    GlobalKey<FormBuilderState> formKey,
  ) {
    Widget? suffixIcon() {
      Widget? icon;
      final primeColor = $r.theme.grey;

      if (widget.suffixIcon != null) {
        icon = Icon(
          widget.suffixIcon,
          size: 20,
          color: widget.isReadOnly! ? $r.theme.grey : primeColor,
        );
      } else if (widget.suffixIconPath != null) {
        icon = SvgPicture.asset(
          widget.suffixIconPath!,
          height: 20,
          width: 20,
          colorFilter: ColorFilter.mode(
            widget.isReadOnly! ? $r.theme.grey : primeColor,
            BlendMode.srcIn,
          ),
        );
      }

      return icon;
    }

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //* Toggle clear form
          Visibility(
            visible: !widget.isNumberField! && isEditing,
            child: IconButton(
              iconSize: 20,
              alignment:
                  widget.suffixIcon != null || widget.suffixIconPath != null
                      ? Alignment.centerRight
                      : Alignment.center,
              padding: EdgeInsets.only(
                left: widget.hasForgotPwd! ? 12 : 0,
              ),
              onPressed: () {
                widget.formKey.currentState?.fields[widget.name]
                    ?.didChange(null);
              },
              tooltip: localeLang.clearForm,
              icon: const Icon(Icons.clear),
            ),
          ),

          //* Toggle suffix
          Visibility(
            visible: widget.suffixText?.isNotEmpty == true,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                widget.suffixText!,
                style: $r.styles.pRegular.copyWith(
                  fontSize: 12,
                  color: $r.theme.grey1,
                ),
              ),
            ),
          ),

          //* Toggle suffix icon
          Visibility(
            visible: widget.suffixIcon != null || widget.suffixIconPath != null,
            child: IconButton(
              iconSize: 20,
              padding: EdgeInsets.only(
                left: widget.hasForgotPwd! ? 12 : 0,
                right: widget.hasForgotPwd! ? 8 : 0,
              ),
              onPressed: widget.onSuffixIconTap,
              icon: suffixIcon() ?? const SizedBox.shrink(),
            ),
          ),

          //* Toggle forgot password
          Visibility(
            visible: widget.hasForgotPwd!,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: VerticalDivider(
                      color: $r.theme.grey,
                      thickness: 1,
                      width: 6,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      localeLang.forgotPassword,
                      style: $r.styles.pMedium.copyWith(
                        fontSize: 12,
                        color: Theme.of(gContext).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //* Toggle add button
          Visibility(
            visible: widget.isNumberField!,
            child: IconButton(
              onPressed: widget.isReadOnly!
                  ? null
                  : () {
                      final currentValue = widget
                          .formKey.currentState?.fields[widget.name]?.value
                          .toString();
                      final increaseValue = widget.isDouble == true
                          ? handleChangeInputNumberDouble(
                              currentValue,
                              'INCREASE',
                            )
                          : handleChangeInputNumberInt(
                              currentValue,
                              'INCREASE',
                            );
                      final newValue = widget.isDouble == true
                          ? increaseValue.toStringAsFixed(1)
                          : increaseValue.round().toString();
                      widget.formKey.currentState?.fields[widget.name]
                          ?.didChange(newValue);
                    },
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.add_circle_outline,
                color: widget.isReadOnly! ? $r.theme.grey : Colors.green,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
