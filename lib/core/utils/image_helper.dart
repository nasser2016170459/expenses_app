import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inovola/core/utils/color_helper.dart';

extension ImagePathExtension on String? {
  Widget toAssetImage({double? height, double? width, Color? color, required BoxFit fit}) {
    if (this == null) return const SizedBox();
    if (this!.toLowerCase().endsWith("svg")) {
      return SvgPicture.asset(this!, width: width, height: height, colorFilter: color.toColorFilter(), fit: fit);
    }
    if (this!.toLowerCase().endsWith("png") ||
        this!.toLowerCase().endsWith("jpg") ||
        this!.toLowerCase().endsWith("jpeg") ||
        this!.toLowerCase().endsWith("gif")) {
      return Image.asset(this!, height: height, width: width, color: color);
    }
    return const SizedBox();
  }
}

class ImageHelper {
  static Widget asset(String imagePath, {double? height, double? width, Color? color, BoxFit? fit}) {
    return imagePath.toAssetImage(height: height, width: width, color: color, fit: fit ?? BoxFit.contain);
  }
}
