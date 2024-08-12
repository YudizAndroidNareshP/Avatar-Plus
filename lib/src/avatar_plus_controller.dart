import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarPlusController {
  String svgString = "";

  Future<Uint8List> svgToPng(BuildContext context) async {
    final pictureInfo =
        await vg.loadPicture(SvgStringLoader(svgString), context);

    final image = await pictureInfo.picture.toImage(100, 100);
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Unable to convert SVG to PNG');
    }

    final pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }
}
