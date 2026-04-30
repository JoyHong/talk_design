import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

import 'colors_page.dart';
import 'buttons_page.dart';
import 'inputs_page.dart';
import 'tokens_page.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('talk_design'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '颜色'),
              Tab(text: '按钮'),
              Tab(text: '输入框'),
              Tab(text: 'Token'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ColorsPage(),
            ButtonsPage(),
            InputsPage(),
            TokensPage(),
          ],
        ),
      ),
    );
  }
}
