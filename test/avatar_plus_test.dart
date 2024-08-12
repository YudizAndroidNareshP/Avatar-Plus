import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:avatar_plus/avatar_plus.dart';

void main() {
  AvatarPlusGen avatarPlusGen = AvatarPlusGen.instance;
  group("Generate Avatar SVG", () {
    test('SVG String with background', () {
      String svgCode = avatarPlusGen.generate("jonny");
      //SVG String with background would be generated
      print(svgCode);
    });

    test('SVG String with a transparent background', () {
      String noBackgroundAvatar =
          avatarPlusGen.generate('Adam', trBackground: true);
      //SVG String with a transparent background would be generated
      print(noBackgroundAvatar);
    });

    test('SVG Widget', () {
      Widget avatarWidget = AvatarPlus('William', trBackground: true);
      //SVG Widget would be generated
      print(avatarWidget);
    });
  });
}
