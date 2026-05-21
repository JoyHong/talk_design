import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talk_design/talk_design.dart';

class IconsPage extends StatelessWidget {
  const IconsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = context.talkIcons;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            title: 'Navigation — 导航',
            icons: [
              (icons.arrowUp, 'arrowUp'),
              (icons.arrowDown, 'arrowDown'),
              (icons.arrowLeft, 'arrowLeft'),
              (icons.arrowRight, 'arrowRight'),
              (icons.back, 'back'),
              (icons.top, 'top'),
            ],
          ),
          _Section(
            title: 'Tabs — 标签页',
            icons: [
              (icons.chat, 'chat'),
              (icons.call, 'call'),
              (icons.video, 'video'),
              (icons.friend, 'friend'),
              (icons.group, 'group'),
            ],
          ),
          _Section(
            title: 'Actions — 操作',
            icons: [
              (icons.add, 'add'),
              (icons.addFriends, 'addFriends'),
              (icons.addMembers, 'addMembers'),
              (icons.set, 'set'),
              (icons.more, 'more'),
              (icons.edit, 'edit'),
              (icons.delete, 'delete'),
              (icons.share, 'share'),
              (icons.download, 'download'),
              (icons.qrcode, 'qrcode'),
              (icons.date, 'date'),
            ],
          ),
          _Section(
            title: 'Password visibility — 可见性',
            icons: [
              (icons.passwordShow, 'passwordShow'),
              (icons.passwordHide, 'passwordHide'),
            ],
          ),
          _Section(
            title: 'Form — 表单',
            icons: [
              (icons.search, 'search'),
              (icons.clear, 'clear'),
              (icons.close, 'close'),
              (icons.check, 'check'),
            ],
          ),
          _Section(
            title: 'Status — 状态',
            icons: [
              (icons.circle, 'circle'),
              (icons.correctFillingSmall, 'correctFillingSmall'),
              (icons.correctFillingSmallDisable, 'correctFillingSmallDisable'),
              (icons.correctFillingBig, 'correctFillingBig'),
              (icons.correctWireframe, 'correctWireframe'),
              (icons.errorSmall, 'errorSmall'),
              (icons.errorBig, 'errorBig'),
            ],
          ),
          _Section(
            title: 'User Roles — 用户角色',
            icons: [
              (icons.kid, 'kid'),
              (icons.parent, 'parent'),
            ],
          ),
          _Section(
            title: 'Premium — 会员图标 (40×40)',
            iconSize: 40,
            icons: [
              (icons.talkPremiumBig, 'talkPremiumBig'),
              (icons.talkPremiumSmall, 'talkPremiumSmall'),
              (icons.familyPremiumBig, 'familyPremiumBig'),
              (icons.familyPremiumSmall, 'familyPremiumSmall'),
              (icons.platinumPremiumBig, 'platinumPremiumBig'),
              (icons.platinumPremiumSmall, 'platinumPremiumSmall'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.icons,
    this.iconSize = 20,
  });

  final String title;
  final List<(String, String)> icons;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final (path, name) in icons)
              _IconTile(path: path, name: name, iconSize: iconSize),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(height: 1),
        ),
      ],
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({
    required this.path,
    required this.name,
    required this.iconSize,
  });

  final String path;
  final String name;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            width: iconSize + 16,
            height: iconSize + 16,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              path,
              width: iconSize,
              height: iconSize,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(fontSize: 10, color: Colors.black54),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
