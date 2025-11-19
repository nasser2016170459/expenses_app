import 'dart:ui';

extension ToColorFilter on Color? {
  ColorFilter? toColorFilter({BlendMode blendMode = BlendMode.srcIn}) {
    if (this == null) return null;
    return ColorFilter.mode(this!, blendMode);
  }
}
