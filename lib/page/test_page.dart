import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_v2/components/grid/v_grid_text.dart';
import 'package:app_v2/components/grid/t_grid_text.dart';
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4,0,4,0),
      child: LayoutBuilder(builder: (context, constraints) {
        int axisCount = 1;
        //通过不同的大小设定不同的行数
        if (constraints.maxWidth >= 900) {
          axisCount = 5;
        } else if (constraints.maxWidth >= 550) {
          axisCount = 3;
        } else if (constraints.maxWidth >= 300) {
          axisCount = 2;
        }
        return CustomScrollView(
          slivers: <Widget>[
            TGridText(axisCount: axisCount),
            VGridText(axisCount: axisCount),
            VGridText(axisCount: axisCount),
            // 添加更多的VGridText组件
          ],
        );
      }),
    );
  }
}