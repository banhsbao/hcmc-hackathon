import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:ndialog/ndialog.dart';

import 'package:angelhack_hcm/app/data/di.dart';
import 'package:angelhack_hcm/app/shared/styles/app_design.dart';
import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';
import 'package:angelhack_hcm/app/shared/widgets/small_button_container.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? buttonText;
  final Color? titleColor;
  final Color? titleIconColor;
  final Color? buttonColor;
  final void Function()? onTap;
  final bool? hasCancelButton;
  final bool? isLoading;
  final bool? isButtonBold;
  final bool? isDismissible;
  final Function? onDismiss;

  const CustomDialog({
    required this.title,
    required this.subtitle,
    super.key,
    this.buttonColor,
    this.buttonText,
    this.hasCancelButton = true,
    this.isButtonBold = false,
    this.isDismissible = true,
    this.isLoading = false,
    this.onDismiss,
    this.onTap,
    this.titleColor,
    this.titleIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return DialogBackground(
      dismissable: isDismissible,
      onDismiss: onDismiss,
      dialog: NDialog(
        dialogStyle: DialogStyle(
          titleDivider: true,
          shape: AppDesign.roundedBorder(16),
          titlePadding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (titleIconColor != null)
                Row(
                  children: [
                    Icon(
                      FluentIcons.info_20_regular,
                      color: titleIconColor ??
                          Theme.of(context).colorScheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleColor ?? Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        content: Padding(
          padding: EdgeInsetsDirectional.only(
            start: width / 40.0,
            top: height / 120.0,
            end: width / 40.0,
            bottom: height / 120.0,
          ),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: $r.styles.pRegular.copyWith(
              fontSize: 14,
            ),
          ),
        ),
        actions: [
          if (hasCancelButton != false)
            SmallButtonContainer(
              marginLeft: 20,
              marginRight: 10,
              color: $r.theme.transparent,
              text: localeLang.cancel,
              radius: 8,
              borderColor: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.primary,
              onTap: () => Navigator.of(context, rootNavigator: true).pop(true),
            ),
          SmallButtonContainer(
            marginRight: 20,
            marginLeft: hasCancelButton != true ? 20 : 10,
            color: buttonColor ?? Theme.of(context).colorScheme.primary,
            text: buttonText ?? localeLang.ok,
            radius: 8,
            status: isLoading,
            isTextBold: isButtonBold,
            borderColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            textColor: Theme.of(context).colorScheme.onPrimary,
            onTap: () {
              onTap?.call();
              Navigator.of(context, rootNavigator: true).pop(true);
            },
          ),
        ],
      ),
    );
  }
}
