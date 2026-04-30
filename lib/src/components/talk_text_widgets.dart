import 'package:flutter/material.dart';
import '../tokens/talk_colors.dart';

abstract class _TalkText extends StatelessWidget {
  const _TalkText(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String data;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  double get _size;
  double get _lineHeight;
  FontWeight get _weight;

  @override
  Widget build(BuildContext context) => Text(
        data,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: _size,
          height: _lineHeight / _size,
          fontWeight: _weight,
          color: color ?? Theme.of(context).extension<TalkColors>()!.textMain,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );
}

// ── Display ──────────────────────────────────────────────────────────────────

class DisplayLarge extends _TalkText {
  const DisplayLarge(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 57;
  @override double get _lineHeight => 64;
  @override FontWeight get _weight => FontWeight.bold;
}

class DisplayMedium extends _TalkText {
  const DisplayMedium(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 45;
  @override double get _lineHeight => 52;
  @override FontWeight get _weight => FontWeight.bold;
}

class DisplaySmall extends _TalkText {
  const DisplaySmall(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 36;
  @override double get _lineHeight => 44;
  @override FontWeight get _weight => FontWeight.bold;
}

// ── Headline ─────────────────────────────────────────────────────────────────

class HeadlineLarge extends _TalkText {
  const HeadlineLarge(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 32;
  @override double get _lineHeight => 40;
  @override FontWeight get _weight => FontWeight.bold;
}

class HeadlineMedium extends _TalkText {
  const HeadlineMedium(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 28;
  @override double get _lineHeight => 36;
  @override FontWeight get _weight => FontWeight.bold;
}

class HeadlineMedium2 extends _TalkText {
  const HeadlineMedium2(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 26;
  @override double get _lineHeight => 34;
  @override FontWeight get _weight => FontWeight.bold;
}

class HeadlineSmall extends _TalkText {
  const HeadlineSmall(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 24;
  @override double get _lineHeight => 32;
  @override FontWeight get _weight => FontWeight.bold;
}

class HeadlineSmall2 extends _TalkText {
  const HeadlineSmall2(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 20;
  @override double get _lineHeight => 28;
  @override FontWeight get _weight => FontWeight.bold;
}

class HeadlineSmall3 extends _TalkText {
  const HeadlineSmall3(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 18;
  @override double get _lineHeight => 26;
  @override FontWeight get _weight => FontWeight.bold;
}

// ── Title ─────────────────────────────────────────────────────────────────────

class TitleLarge extends _TalkText {
  const TitleLarge(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 22;
  @override double get _lineHeight => 28;
  @override FontWeight get _weight => FontWeight.bold;
}

class TitleMedium extends _TalkText {
  const TitleMedium(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 16;
  @override double get _lineHeight => 24;
  @override FontWeight get _weight => FontWeight.bold;
}

class TitleSmall extends _TalkText {
  const TitleSmall(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 14;
  @override double get _lineHeight => 20;
  @override FontWeight get _weight => FontWeight.bold;
}

// ── Label ─────────────────────────────────────────────────────────────────────

class LabelLarge extends _TalkText {
  const LabelLarge(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 14;
  @override double get _lineHeight => 20;
  @override FontWeight get _weight => FontWeight.bold;
}

class LabelMedium extends _TalkText {
  const LabelMedium(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 12;
  @override double get _lineHeight => 16;
  @override FontWeight get _weight => FontWeight.bold;
}

class LabelSmall extends _TalkText {
  const LabelSmall(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 11;
  @override double get _lineHeight => 16;
  @override FontWeight get _weight => FontWeight.bold;
}

// ── Body ──────────────────────────────────────────────────────────────────────

class BodyLarge2 extends _TalkText {
  const BodyLarge2(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 18;
  @override double get _lineHeight => 26;
  @override FontWeight get _weight => FontWeight.w500;
}

class BodyLarge extends _TalkText {
  const BodyLarge(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 16;
  @override double get _lineHeight => 24;
  @override FontWeight get _weight => FontWeight.w500;
}

class BodyMedium extends _TalkText {
  const BodyMedium(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 14;
  @override double get _lineHeight => 20;
  @override FontWeight get _weight => FontWeight.w500;
}

class BodySmall extends _TalkText {
  const BodySmall(super.data, {super.key, super.color, super.textAlign, super.maxLines, super.overflow});
  @override double get _size => 12;
  @override double get _lineHeight => 16;
  @override FontWeight get _weight => FontWeight.w500;
}
