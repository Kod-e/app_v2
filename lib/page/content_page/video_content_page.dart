import 'package:app_v2/model/tag.dart';
import 'package:app_v2/model/video.dart';
import 'package:app_v2/components/grid/vt_grid_text.dart';
import 'package:app_v2/service/tag_page.dart';
import 'package:app_v2/components/player/player.dart';
import 'package:app_v2/api/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoContentPage extends StatefulWidget {
  final Video video;
  final Tag tag;
  const VideoContentPage({Key? key, required this.video, required this.tag})
      : super(key: key);

  @override
  State<VideoContentPage> createState() => _VideoContentPageState();
}

class _VideoContentPageState extends State<VideoContentPage> {
  late TagPageService tagPageService;
  //创建20个加载中的video
  List<Video> videosContent = List.generate(20, (index) => Video.loading());

  //初始化函数
  void initState() {
    super.initState();
    tagPageService = TagPageService(widget.tag);
    getFirstPage();
  }

  //获取第一页
  void getFirstPage() async {
    //获取第一页
    await tagPageService.GetFirstPage();
    setState(() {
      videosContent = tagPageService.videoNowPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    return Scaffold(
        backgroundColor: colorScheme.surfaceVariant,
        appBar: AppBar(
          title: Text(
            this.widget.video.name!,
            style: theme.textTheme.titleMedium,
          ),
          foregroundColor: colorScheme.secondary,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth >= 500) {
            //标题的color
            final titleColor = theme.colorScheme.secondary;
            final descriptionColor =
                theme.colorScheme.secondary.withOpacity(0.7);
            //标题的style
            var titleStyle = theme.textTheme.titleLarge!
                .copyWith(color: titleColor, fontWeight: FontWeight.bold);
            var descriptionStyle =
                theme.textTheme.titleMedium!.copyWith(color: descriptionColor);
            return Row(
              children: [
                //视频播放器
                SizedBox(
                  width: constraints.maxWidth * 2 / 3, // 设置为父小部件宽度的2/3
                  child: Container(
                    color: colorScheme.onSecondary,
                    child: Column(
                      children: [
                        SafeArea(child: StreamPlayer(id: widget.video.id)),
                        //标题和描述，只在title/description不为空时显示
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8,0,8,0),
                            child: CustomScrollView(
                              slivers: [
                                if (widget.video.name != null)
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.video.name!,
                                        style: titleStyle,
                                      ),
                                    ),
                                  ),
                                if (widget.video.description != null)
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                      child: Text(
                                        "简介: " + widget.video.description!,
                                        style: descriptionStyle,
                                      ),
                                    ),
                                  ),
                                //略缩图
                                SliverToBoxAdapter(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    //左对其
                                    children: [
                                      Image.network(
                                        widget.video.picture!.jpg!,
                                        fit: BoxFit.cover,
                                      )
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: VideosContent(
                          videos: videosContent,
                          tagPageService: tagPageService,
                          tag: widget.tag,
                ))
              ],
            );
          } else {
            return Column(
              children: [
                //视频播放器
                StreamPlayer(id: widget.video.id),
                Expanded(
                    child: VideosContent(
                  videos: videosContent,
                  tagPageService: tagPageService,
                  tag: widget.tag,
                  title: widget.video.name,
                  description: widget.video.description,
                ))
              ],
            );
          }
        }));
  }

  //如果description满足一定条件就直接不可见
  Widget _buildDescriptionCard() {
    if (this.widget.video.description != null &&
        this.widget.video.description != this.widget.video.name) {
      return Card(
        child: ListTile(
          subtitle: Text(this.widget.video.description!),
        ),
      );
    } else {
      return SizedBox.shrink(); // 返回一个不可见的widget
    }
  }
}

//Videos页面
class VideosContent extends StatefulWidget {
  List<Video> videos;
  final TagPageService tagPageService;
  final Tag tag;
  final String? title;
  final String? description;
  VideosContent(
      {Key? key,
      required this.videos,
      required this.tagPageService,
      required this.tag,
      this.title,
      this.description})
      : super(key: key);

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
    //获取主题
    final theme = Theme.of(context);
    //标题的color
    final titleColor = theme.colorScheme.onSurfaceVariant;
    final descriptionColor = theme.colorScheme.onSurfaceVariant.withOpacity(0.7);
    //标题的style
    var titleStyle = theme.textTheme.titleMedium!.copyWith(color: titleColor);
    var descriptionStyle = theme.textTheme.titleSmall!.copyWith(color: descriptionColor);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8,0,8,0),
      child: LayoutBuilder(builder: (context, constraints) {

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
            SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
            //标题和描述，只在title/description不为空时显示
            if (widget.title != null)
              (SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title!,
                    style: titleStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              )),
            if (widget.description != null)
              (SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Text(
                    "简介: " + widget.description!,
                    style: descriptionStyle,
                  ),
                ),
              )),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '同系列的视频',
                style: titleStyle.copyWith(fontWeight: FontWeight.w700),
              ),
            )),
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
