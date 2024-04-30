import 'package:flutter/material.dart';

class UpgradePage extends StatefulWidget {
  const UpgradePage({super.key});

  @override
  State<UpgradePage> createState() => _UpgradePageState();
}

class _UpgradePageState extends State<UpgradePage> {
  @override
  Widget build(BuildContext context) {
      var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant,
      appBar: AppBar(
        title: Text('我的信息'),
        iconTheme: IconThemeData(color: colorScheme.secondary),
        foregroundColor: colorScheme.secondary,
        //字体颜色为secondary，返回按钮颜色为secondary      
      ),
      body: Container(),
    );
  }
}