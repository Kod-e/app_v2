import 'package:flutter/material.dart';
import 'package:app_v2/components/bar/t_content_bar.dart';
class TagContentPage extends StatefulWidget {
  const TagContentPage({super.key});

  @override
  State<TagContentPage> createState() => _TagContentPageState();
}

class _TagContentPageState extends State<TagContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TContentAppBar(),
      body: Container()
    );
  }
}