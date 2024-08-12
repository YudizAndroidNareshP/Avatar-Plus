import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'avatar_plus_controller.dart';
import 'avatar_plus_gen.dart';

import 'package:flutter/material.dart';

class AvatarPlus extends StatelessWidget {
  final String string;
  final bool trBackground;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final bool matchTextDirection;
  final bool allowDrawingOutsideViewBox;
  final WidgetBuilder? placeholderBuilder;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final ColorFilter? colorFilter;
  final SvgTheme theme;
  final AvatarPlusController? controller;

  AvatarPlus(this.string,
      {super.key,
      this.trBackground = false,
      this.width,
      this.height,
      this.fit = BoxFit.contain,
      this.alignment = Alignment.center,
      this.matchTextDirection = false,
      this.allowDrawingOutsideViewBox = false,
      this.placeholderBuilder,
      this.semanticsLabel,
      this.excludeFromSemantics = false,
      this.colorFilter,
      this.theme = const SvgTheme(),
      this.controller});

  @override
  Widget build(BuildContext context) {
    String svgString = generate();
    controller?.svgString = svgString;
    return SvgPicture.string(
      svgString,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      matchTextDirection: matchTextDirection,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter,
      theme: theme,
    );
  }

  String generate() {
    return AvatarPlusGen.instance.generate(string, trBackground: trBackground);
  }
}
