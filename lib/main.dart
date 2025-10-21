import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/inbox_viewmodel.dart';
import 'views/inbox_list_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => InboxViewmodel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
        barBackgroundColor: CupertinoColors.systemGrey6,
        scaffoldBackgroundColor: CupertinoColors.systemBackground,
      ),
      home: const InboxListView(),
    );
  }
}
