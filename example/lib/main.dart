import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

import 'avatar_page.dart';
import 'badge_page.dart';
import 'checkbox_page.dart';
import 'colors_page.dart';
import 'buttons_page.dart' show ButtonsPage, ButtonSpecPage;
import 'inputs_page.dart';
import 'loading_page.dart';
import 'dialog_page.dart';
import 'menu_page.dart';
import 'toast_page.dart';
import 'tokens_page.dart';
import 'list_page.dart';
import 'typography_page.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'talk_design Example',
      theme: TalkTheme.light(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _NavItem {
  final String title;
  final IconData icon;
  final Widget page;
  final List<Widget> Function(BuildContext)? actionsBuilder;
  const _NavItem(this.title, this.icon, this.page, {this.actionsBuilder});
}

final _navItems = <_NavItem>[
  _NavItem('头像', Icons.account_circle_outlined, const AvatarPage()),
  _NavItem('Badge', Icons.notifications_outlined, const BadgePage()),
  _NavItem('Checkbox', Icons.check_box_outlined, const CheckboxPage()),
  _NavItem('颜色', Icons.palette_outlined, const ColorsPage()),
  _NavItem(
    '按钮',
    Icons.smart_button_outlined,
    const ButtonsPage(),
    actionsBuilder: (ctx) => [
      IconButton(
        icon: const Icon(Icons.info_outline),
        tooltip: '按钮规范',
        onPressed: () => Navigator.push(
          ctx,
          MaterialPageRoute(builder: (_) => const ButtonSpecPage()),
        ),
      ),
    ],
  ),
  _NavItem('输入框', Icons.text_fields_outlined, const InputsPage()),
  _NavItem('Loading', Icons.hourglass_empty_outlined, const LoadingPage()),
  _NavItem('Toast', Icons.announcement_outlined, const ToastPage()),
  _NavItem('弹框', Icons.web_asset_outlined, const DialogPage()),
  _NavItem('菜单', Icons.menu_outlined, const MenuPage()),
  _NavItem('列表', Icons.list_outlined, const ListPage()),
  _NavItem('字体', Icons.font_download_outlined, const TypographyPage()),
  _NavItem('Token', Icons.token_outlined, const TokensPage()),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_navItems[_selectedIndex].title),
        actions: _navItems[_selectedIndex].actionsBuilder?.call(context),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: const Text(
                'talk_design',
                style: TextStyle(fontSize: 24),
              ),
            ),
            for (int i = 0; i < _navItems.length; i++)
              ListTile(
                leading: Icon(_navItems[i].icon),
                title: Text(_navItems[i].title),
                selected: i == _selectedIndex,
                onTap: () {
                  setState(() => _selectedIndex = i);
                  Navigator.pop(context); // close drawer
                },
              ),
          ],
        ),
      ),
      body: _navItems[_selectedIndex].page,
    );
  }
}
