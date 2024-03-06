import 'package:flutter/material.dart';
import 'package:app_v2/components/card/t_card_text.dart';
import 'package:flutter/widgets.dart';

class TGridText extends StatefulWidget {
  final int axisCount;
  const TGridText({Key? key, this.axisCount = 2}) : super(key: key);
  @override
  State<TGridText> createState() => _TGridTextState();
}

class _TGridTextState extends State<TGridText> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.axisCount, // 使用新的参数
        childAspectRatio: 16 / 9, // 设置子项的宽高比为16:9
      ),
      delegate: SliverChildListDelegate(
        [TCardText(), TCardText(), TCardText(), TCardText(), TCardText()],
      ),
    );
  }
}
