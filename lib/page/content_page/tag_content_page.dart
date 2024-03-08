import 'package:app_v2/components/grid/t_grid_text.dart';
import 'package:app_v2/components/grid/v_grid_text.dart';
import 'package:app_v2/model/tag.dart';
import 'package:app_v2/model/video.dart';
import 'package:app_v2/service/tag_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TagContentPage extends StatefulWidget {
  final Tag tag;
  const TagContentPage({Key? key, required this.tag}) : super(key: key);

  @override
  State<TagContentPage> createState() => _TagContentPageState();
}

class _TagContentPageState extends State<TagContentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TagPageService tagPageService;
  //创建20个加载中的tag
  List<Tag> tagsContent = List.generate(20, (index) => Tag.loading());
  //创建20个加载中的video
  List<Video> videosContent = List.generate(20, (index) => Video.loading());
//创建Tag Service
  //初始化
  @override
  void initState() {
    tagPageService = TagPageService(this.widget.tag);
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getFirstPage();
  }

  //获取第一页
  void getFirstPage() async {
    //获取第一页
    await tagPageService.GetFirstPage();
    setState(() {
      tagsContent = tagPageService.tagNowPage;
      videosContent = tagPageService.videoNowPage;
      if (tagsContent.isEmpty) {
        _tabController.animateTo(1);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.tag.name!),
        backgroundColor: theme.colorScheme.surfaceVariant,
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            //标签的icon
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tab(icon: Icon(Icons.tag)),
                Text('Tags'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tab(icon: Icon(Icons.video_library)),
                Text('Videos'),
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TagsContent(tags: tagsContent,tagPageService: tagPageService,),
          VideosContent(videos: videosContent,tagPageService: tagPageService,),
        ],
      ),
    );
  }
}

//Tags页面
class TagsContent extends StatelessWidget {
  final List<Tag> tags;
  final TagPageService tagPageService;
  const TagsContent({Key? key, required this.tags,required this.tagPageService}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return Center(
        child: Text('这里是空的'),
      );
    }
    return LayoutBuilder(builder: (context, constraints) {
      int axisCount = 1;
      //通过不同的大小设定不同的行数
      if (constraints.maxWidth >= 1200) {
        axisCount = 5;
      } else if (constraints.maxWidth >= 550) {
        axisCount = 3;
      } else if (constraints.maxWidth >= 300) {
        axisCount = 2;
      }
      return CustomScrollView(
        slivers: [
          TGridText(
            tags: tags,
            axisCount: axisCount,
          )
        ],
      );
    });
  }
}

//Videos页面
class VideosContent extends StatelessWidget {
  final List<Video> videos;
  final TagPageService tagPageService;
  const VideosContent({Key? key, required this.videos,required this.tagPageService}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return Center(
        child: Text('这里是空的'),
      );
    }
    return LayoutBuilder(builder: (context, constraints) {
      int axisCount = 1;
      //通过不同的大小设定不同的行数
      if (constraints.maxWidth >= 1200) {
        axisCount = 5;
      } else if (constraints.maxWidth >= 550) {
        axisCount = 3;
      } else if (constraints.maxWidth >= 300) {
        axisCount = 2;
      }
      return CustomScrollView(
        slivers: [
          VGridText(
            videos: videos,
            axisCount: axisCount,
          )
        ],
      );
    });
  }
}
