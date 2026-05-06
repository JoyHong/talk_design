import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    final items = [
      ('theme', colors.theme),
      ('textPrimary', colors.textPrimary),
      ('textSecondary', colors.textSecondary),
      ('backgroundPrimary', colors.backgroundPrimary),
      ('backgroundSecondary', colors.backgroundSecondary),
      ('cardPrimary', colors.cardPrimary),
      ('cardSecondary', colors.cardSecondary),
      ('inputBoxPrimary', colors.inputBoxPrimary),
      ('inputBoxSecondary', colors.inputBoxSecondary),
      ('messageBubble', colors.messageBubble),
      ('listDialogBox', colors.listDialogBox),
      ('sidePopUp', colors.sidePopUp),
      ('buttonBlock', colors.buttonBlock),
      ('listCardMenuFloating', colors.listCardMenuFloating),
      ('listCardMenuPressed', colors.listCardMenuPressed),
      ('success', colors.success),
      ('redDotError', colors.redDotError),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final (name, color) = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(TalkSpacing.radiusM),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '#${color.toARGB32().toRadixString(16).toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
