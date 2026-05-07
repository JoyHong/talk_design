import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

import 'badge_page.dart';
import 'checkbox_page.dart';
import 'colors_page.dart';
import 'buttons_page.dart';
import 'inputs_page.dart';
import 'loading_page.dart';
import 'menu_page.dart';
import 'toast_page.dart';
import 'tokens_page.dart';
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
  const _NavItem(this.title, this.icon, this.page);
}

const _navItems = <_NavItem>[
  _NavItem('Badge', Icons.notifications_outlined, BadgePage()),
  _NavItem('Checkbox', Icons.check_box_outlined, CheckboxPage()),
  _NavItem('颜色', Icons.palette_outlined, ColorsPage()),
  _NavItem('按钮', Icons.smart_button_outlined, ButtonsPage()),
  _NavItem('输入框', Icons.text_fields_outlined, InputsPage()),
  _NavItem('Loading', Icons.hourglass_empty_outlined, LoadingPage()),
  _NavItem('Toast', Icons.announcement_outlined, ToastPage()),
  _NavItem('菜单', Icons.menu_outlined, MenuPage()),
  _NavItem('字体', Icons.font_download_outlined, TypographyPage()),
  _NavItem('Token', Icons.token_outlined, TokensPage()),
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
