import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class SvgAsset extends StatelessWidget {
  final String? assetName;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  const SvgAsset(
    this.assetName, {
    super.key,
    this.height,
    this.width,
    this.fit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName!,
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            ),
    );
  }
}
