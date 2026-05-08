import 'package:flutter_svg/flutter_svg.dart';

abstract final class TalkAvatars {
  static const String _base = 'packages/talk_design/assets/avatars';
  static const double _defaultSize = 48;

  static const _paths = [
    '$_base/avatar_0.svg',
    '$_base/avatar_1.svg',
    '$_base/avatar_2.svg',
    '$_base/avatar_3.svg',
    '$_base/avatar_4.svg',
    '$_base/avatar_5.svg',
    '$_base/avatar_6.svg',
    '$_base/avatar_7.svg',
    '$_base/avatar_8.svg',
    '$_base/avatar_9.svg',
  ];

  /// Returns a default avatar widget selected by the last digit of [uid].
  /// Falls back to avatar 0 when [uid] is null, empty, or ends with a non-digit.
  static SvgPicture of(String? uid, {double size = _defaultSize}) {
    final index = _indexFor(uid);
    return SvgPicture.asset(_paths[index], width: size, height: size);
  }

  static int _indexFor(String? uid) {
    if (uid == null || uid.isEmpty) return 0;
    return int.tryParse(uid[uid.length - 1]) ?? 0;
  }
}
