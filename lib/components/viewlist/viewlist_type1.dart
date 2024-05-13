import 'package:flutter/material.dart';
import 'package:app_v2/model/viewlist.dart';
import 'package:app_v2/model/tag.dart';
import 'package:app_v2/model/video.dart';
import 'package:app_v2/api/tag.dart';
import 'package:app_v2/page/content_page/tag_content_page.dart';
import 'package:app_v2/components/card/vt_card_text.dart';

class ViewListType1 extends StatefulWidget {
  final ViewList viewList;
  ViewListType1({required this.viewList});

  @override
  State<ViewListType1> createState() => _ViewListType1State();
}

class _ViewListType1State extends State<ViewListType1> {
  late List<Video> videosContent;
  late Tag tagContent;
  //这个loading代表tagContent是否加载完毕
  bool isLoading = true;
  //如果用户在加载完成之前就通过上方的箭头进入了tag页面，那需要等待isLoading为false
  //并且设置showLoading为true，这会显示一个loading的widget
  bool showLoading = false;

  //这是GPT提供的思路，用于阻塞async线程来等到数据加载完毕
  Future<void>? getTagDataFuture;
  //init函数
  @override
  void initState() {
    super.initState();
    videosContent = (widget.viewList.data!['videos'] as List)
        .map((item) => Video.fromJson(item))
        .toList();
    tagContent = Tag.loading();
    tagContent.id = widget.viewList.tid!;
    getTagDataFuture = getTagData(); // 在 initState 中调用 getTagData
  }

  //获得tagData
  Future<void> getTagData() async {
    final tag = await TagAPI.getTagData(widget.viewList.tid!);
    if(mounted) {
      setState(() {
        tagContent = tag;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //获取主题
    final theme = Theme.of(context);
    //标题的color
    final titleColor = theme.colorScheme.secondary.withOpacity(0.9);
    //自适应大小
    var titleStyle = theme.textTheme.titleMedium!.copyWith(color: titleColor, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 让 Column 的子 widget 左对齐
        children: [
          Align(
            alignment: Alignment.centerLeft, // 让 Text 左对齐
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    showLoading = true;
                  });
                  await getTagDataFuture; // 在 onTap 中等待 getTagData 的完成
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return TagContentPage(tag: tagContent);
                    }),
                  );
                  setState(() {
                    showLoading = false;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      widget.viewList.name!,
                      style: titleStyle,
                    ),
                    // 使用 Expanded 小部件填充剩余空间
                    Expanded(
                      child: Container(),
                    ),
                    // 添加 "查看更多" 文本
                    Text(
                      '查看更多',
                      style: titleStyle,
                    ),
                    //右侧的箭头
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 1, 0, 0),
                      child: Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 15,
                        color: titleColor,
                      ),
                    ),
                    if (showLoading)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 1, 0, 0),
                        child: SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator()),
                      )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 200, // 设置你需要的高度
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: videosContent.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    if (index == 0)
                      SizedBox(width: 5), // 如果索引为0，那么就添加一个宽度为10的 SizedBox
                    Container(
                      width: 200, // 给 TCardText 设置一个固定的宽度
                      child: VTCardText(
                        video: videosContent[index],
                        tag: tagContent,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
