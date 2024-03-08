import 'package:flutter/material.dart';
import 'package:app_v2/components/card/v_card_text.dart';
import 'package:flutter/widgets.dart';

class VGridText extends StatefulWidget {
  final int axisCount;
  const VGridText({Key? key, this.axisCount = 2}) : super(key: key);
  @override
  State<VGridText> createState() => _VGridTextState();
}

class _VGridTextState extends State<VGridText> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.axisCount, // 使用新的参数
      ),
      delegate: SliverChildListDelegate(
        [
          VCardText(),
          VCardText(),

        ],
      ),
    );
  }
}