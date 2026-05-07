import 'package:flutter/material.dart';

abstract final class TalkShadows {
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> popup = [
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: 15,
      offset: Offset(0, 2),
      spreadRadius: 2,
    ),
  ];
}
