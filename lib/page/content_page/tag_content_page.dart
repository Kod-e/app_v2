import 'package:app_v2/components/grid/t_grid_text.dart';
import 'package:app_v2/components/grid/v_grid_text.dart';
import 'package:app_v2/components/grid/vt_grid_text.dart';
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
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant,
      appBar: AppBar(
        title: Text(this.widget.tag.name!,style: theme.textTheme.titleMedium,),
        foregroundColor: colorScheme.secondary,
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
          TagsContent(
            tags: tagsContent,
            tagPageService: tagPageService,
            tag: this.widget.tag,
          ),
          VideosContent(
            videos: videosContent,
            tagPageService: tagPageService,
            tag: this.widget.tag,
          ),
        ],
      ),
    );
  }
}

//Tags页面
class TagsContent extends StatefulWidget {
  List<Tag> tags;
  final TagPageService tagPageService;
  final Tag tag;
  TagsContent({Key? key, required this.tags, required this.tagPageService ,required this.tag})
      : super(key: key);

  @override
  State<TagsContent> createState() => _TagsContentState();
}

class _TagsContentState extends State<TagsContent> {
  @override
  Widget build(BuildContext context) {
      void ChangePage({bool next = true}) async {
          if (next) {
            //检测是否有下一页
            if (widget.tagPageService.tagPageOffset + 1 < widget.tagPageService.tagPageCount) {
              await widget.tagPageService.ToTagPage(widget.tagPageService.tagPageOffset + 1);
            }
          }else{
            //检测是否有上一页
            if (widget.tagPageService.tagPageOffset > 0) {
              await widget.tagPageService.ToTagPage(widget.tagPageService.tagPageOffset - 1);
            }
          }
          setState(() {
            widget.tags = widget.tagPageService.tagNowPage;
          });
      }
    if (widget.tags.isEmpty) {
      return Center(
        child: Text('这里什么都没有哦'),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,0,8,8),
      child: LayoutBuilder(builder: (context, constraints) {
        int axisCount = 1;
        //通过不同的大小设定不同的行数
        if (constraints.maxWidth > 900) {
          axisCount = 5;
        } else if (constraints.maxWidth > 600) {
          axisCount = 3;
        } else if (constraints.maxWidth > 350) {
          axisCount = 2;
        } else if (constraints.maxWidth > 250) {
          axisCount = 1;
        }
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 5,),),
            TGridText(
              tags: widget.tags,
              axisCount: axisCount,
            ),
            VBottomPageButton(
              callback: ChangePage,
            )
          ],
        );
      }),
    );
  }
}

//Videos页面
class VideosContent extends StatefulWidget {
  List<Video> videos;
  final TagPageService tagPageService;
  final Tag tag;
  VideosContent({Key? key, required this.videos, required this.tagPageService ,required this.tag}) : super(key: key);

  @override
  State<VideosContent> createState() => _VideosContentState();
}

class _VideosContentState extends State<VideosContent> {
  @override
  Widget build(BuildContext context) {
    void ChangePage({bool next = true}) async {
      if (next) {
        //检测是否有下一页
        if (widget.tagPageService.videoPageOffset + 1 <
            widget.tagPageService.videoPageCount) {
          await widget.tagPageService
              .ToVideoPage(widget.tagPageService.videoPageOffset + 1);
        }
      } else {
        //检测是否有上一页
        if (widget.tagPageService.videoPageOffset > 0) {
          await widget.tagPageService
              .ToVideoPage(widget.tagPageService.videoPageOffset - 1);
        }
      }
      setState(() {
        widget.videos = widget.tagPageService.videoNowPage;
      });
    }

    if (widget.videos.isEmpty) {
      return Center(
        child: Text('这里什么都没有哦'),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(builder: (context, constraints) {
        int axisCount = 1;
        //通过不同的大小设定不同的行数
        if (constraints.maxWidth > 900) {
          axisCount = 5;
        } else if (constraints.maxWidth > 600) {
          axisCount = 3;
        } else if (constraints.maxWidth > 350) {
          axisCount = 2;
        } else if (constraints.maxWidth > 250) {
          axisCount = 1;
        }
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 5,),),
            VTGridText(
              videos: widget.videos,
              axisCount: axisCount,
              tag: widget.tag,
            ),
            VBottomPageButton(
              callback: ChangePage,
            )
          ],
        );
      }),
    );
  }
}

typedef ChangePage = void Function({bool next});

class VBottomPageButton extends StatelessWidget {
  final ChangePage callback;

  const VBottomPageButton({Key? key, required this.callback}) : super(key: key);

  //创建一个函数，传递两个参数，next:bool,video:bool

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            child: Card(
                child: ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text(
                '上一页',
                textAlign: TextAlign.left,
              ),
              onTap: () {
                callback(next: false);
              },
            )),
          ),
          Expanded(
            child: Card(
                child: ListTile(
              trailing: Icon(Icons.arrow_forward),
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '下一页',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              onTap: () {
                callback(next: true);
              },
            )),
          )
        ],
      ),
    );
  }
}
