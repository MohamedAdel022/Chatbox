import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that displays an SVG from assets with customization options.
class SvgPathWidget extends StatelessWidget {
  /// The asset path to the SVG file.
  final String assetPath;

  /// The color to apply to the SVG.
  final Color? color;

  /// The size of the widget.
  final double? width;
  final double? height;

  /// How to fit the SVG within the bounds.
  final BoxFit fit;

  /// Whether the SVG should be clipped.
  final bool clipBehavior;

  const SvgPathWidget({
    super.key,
    required this.assetPath,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.clipBehavior = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      clipBehavior: clipBehavior ? Clip.hardEdge : Clip.none,
    );
  }
}
