import 'package:app_v2/components/card/f_card_text.dart';
import 'package:app_v2/model/favoritelist.dart';
import 'package:flutter/material.dart';

class FGridText extends StatefulWidget {
    final int axisCount;
    final List<FavoriteList> favoriteLists;
    const FGridText({Key? key, this.axisCount = 2,required this.favoriteLists }) : super(key: key);

  @override
  State<FGridText> createState() => _FGridTextState();
}

class _FGridTextState extends State<FGridText> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.axisCount, // 使用新的参数
        childAspectRatio: 16 / 9, // 设置子项的宽高比为16:9
      ),
      delegate: SliverChildListDelegate(
        widget.favoriteLists.map((favoriteList) => FCardText(favoriteList: favoriteList)).toList(),
      ),
    );
  }
}