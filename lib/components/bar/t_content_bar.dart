import 'package:flutter/material.dart';



class TContentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TContentAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      // 在这里定义你的 AppBar
      title: Text('Tag Content'),
      backgroundColor: theme.colorScheme.surfaceVariant,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // 在这里设置你的 AppBar 高度
}