import 'package:app_v2/components/card/vt_card_text.dart';
import 'package:app_v2/model/tag.dart';
import 'package:app_v2/model/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VTGridText extends StatefulWidget {
  final int axisCount;
  final List<Video> videos;
  final Tag tag;
  const VTGridText({Key? key, this.axisCount = 2,required this.videos,required this.tag}) : super(key: key);
  @override
  State<VTGridText> createState() => _VTGridTextState();
}

class _VTGridTextState extends State<VTGridText> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.axisCount, // 使用新的参数
      ),
      delegate: SliverChildListDelegate(
        widget.videos.map((video) => VTCardText(video: video,tag: widget.tag,)).toList(),
      ),
    );
  }
}