import 'package:flutter/material.dart';



class TContentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TContentAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 在这里定义你的 AppBar
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // 在这里设置你的 AppBar 高度
}