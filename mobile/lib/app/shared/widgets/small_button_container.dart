import 'package:flutter/material.dart';

import 'package:angelhack_hcm/app/shared/utils/ui_utils.dart';

class SmallButtonContainer extends StatelessWidget {
  final double? radius;
  final double? marginLeft;
  final double? marginRight;
  final String? text;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final bool? status;
  final bool? isTextBold;
  final bool? showLoading;
  final double? cusHeight;
  final double? cusWidth;

  const SmallButtonContainer({
    super.key,
    this.text,
    this.onTap,
    this.color,
    this.marginLeft,
    this.marginRight,
    this.borderColor,
    this.textColor,
    this.radius,
    this.showLoading = true,
    this.status = false,
    this.isTextBold = false,
    this.cusHeight,
    this.cusWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: marginLeft ?? 15,
        right: marginRight ?? 15,
        bottom: 15,
      ),
      height: cusHeight ?? height / 22,
      width: cusWidth ?? width / 3.6,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(textColor!.withOpacity(0.10)),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? Colors.grey.shade400
                : color!,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(
                color: status == true ? Colors.grey.shade400 : borderColor!,
              ),
            ),
          ),
        ),
        onPressed: status == true ? null : onTap,
        child: status == true && showLoading == true
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : Text(
                text!,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: isTextBold! ? FontWeight.bold : FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
