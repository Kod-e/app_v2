import 'package:app_v2/components/bar/v_content_bar.dart';
import 'package:flutter/material.dart';

class VideoContentPage extends StatefulWidget {
  const VideoContentPage({super.key});

  @override
  State<VideoContentPage> createState() => _VideoContentPageState();
}

class _VideoContentPageState extends State<VideoContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VContentAppBar(),
      body: Container()
    );
  }
}