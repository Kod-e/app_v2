import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_v2/components/grid/v_grid_text.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    // return CustomScrollView(
    //   slivers: <Widget>[
    //     SliverToBoxAdapter(child: VGridText()),
    //     SliverToBoxAdapter(child: VGridText()),
    //   ],
    // );
    return LayoutBuilder(builder: (context, constraints) {
      int asixCount = 1;
      //通过不同的大小设定不同的行数
      if (constraints.maxWidth >= 900) {
        asixCount = 5;
      } else if (constraints.maxWidth >= 550) {
        asixCount = 3;
      } else if (constraints.maxWidth >= 300) {
        asixCount = 2;
      }
      return CustomScrollView(
        slivers: <Widget>[
          VGridText(axisCount: asixCount),
          VGridText(axisCount: asixCount),
          // 添加更多的VGridText组件
        ],
      );
    });
  }
}