import 'dart:convert';
import 'package:avatar_plus/src/avatar_plus_utils.dart';
import 'package:crypto/crypto.dart';

class AvatarPlusGen {
  // Private constructor with initialization logic
  AvatarPlusGen._internal();

  // Static instance variable, initially created
  static final AvatarPlusGen _instance = AvatarPlusGen._internal();

  // Static getter to return the singleton instance
  static AvatarPlusGen get instance => _instance;

  //  AvatarPlusUtils instance
  final AvatarPlusUtils avatarPlusUtils = AvatarPlusUtils.instance;

  /// required String string,  random string to use as a start of svg generation
  /// bool trBackground  = true; Set background color to transparent
  String generate(String string, {bool trBackground = false}) {
    string += '';

    String svgStart =
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 231 231">';
    String svgEnd = '</svg>';

    String hash = '';
    if (string.isEmpty) return hash;

    List<int> bytes1 = utf8.encode(string);
    Digest sha256Hash = sha256.convert(bytes1);
    String sha256Numbers =
        sha256Hash.toString().replaceAll(RegExp(r'[^0-9]'), '');

    hash = sha256Numbers.substring(0, 12);

    Map<dynamic, dynamic> p = {};

    p['env'] = hash[0] + '' + hash[1];
    p['env'] = ((47 / 100) * int.parse(p['env'])).round().toString() + '';

    p['clo'] = hash[2] + '' + hash[3];
    p['clo'] = ((47 / 100) * int.parse(p['clo'])).round().toString() + '';

    p['head'] = hash[4] + '' + hash[5];
    p['head'] = ((47 / 100) * int.parse(p['head'])).round().toString() + '';

    p['mouth'] = hash[6] + '' + hash[7];
    p['mouth'] = ((47 / 100) * int.parse(p['mouth'])).round().toString() + '';

    p['eyes'] = hash[8] + '' + hash[9];
    p['eyes'] = ((47 / 100) * int.parse(p['eyes'])).round().toString() + '';

    p['top'] = hash[10] + '' + hash[11];
    p['top'] = ((47 / 100) * int.parse(p['top'])).round().toString() + '';

    for (var part in p.keys) {
      var nr = p[part];

      if (int.parse(nr) > 31) {
        nr = (int.parse(nr) - 32).toString() + '';
        if (nr.length == 1) nr = '0' + nr;
        p[part] = nr + 'C';
      } else if (int.parse(nr) > 15) {
        nr = (int.parse(nr) - 16).toString() + '';
        if (nr.length == 1) nr = '0' + nr;
        p[part] = nr + 'B';
      } else {
        if ((nr + '').length == 1)
          p[part] = '0' + nr + 'A';
        else
          p[part] = nr + 'A';
      }
    }

    Map<dynamic, dynamic> _final = {};

    for (var part in p.keys) {
      var partV = p[part].substring(0, 2);
      var theme = p[part].substring(2, 3);

      _final[part] = avatarPlusUtils.getFinal(part, partV, theme);
    }

    if (trBackground) _final['env'] = '';

    return (svgStart +
        // Background
        _final['env'] +
        _final['head'] +
        _final['clo'] +
        _final['top'] +
        _final['eyes'] +
        _final['mouth'] +
        svgEnd);
  }
}
