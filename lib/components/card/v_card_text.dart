import 'package:app_v2/api/video.dart';
import 'package:app_v2/model/video.dart';
import 'package:app_v2/page/content_page/video_content_page.dart';
import 'package:flutter/material.dart';

class VCardText extends StatefulWidget {
  final Video video;
  const VCardText({Key? key, required this.video}) : super(key: key);

  @override
  State<VCardText> createState() => _VCardTextState();
}

class _VCardTextState extends State<VCardText> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      //获取主题
      final theme = Theme.of(context);
      //标题的color
      final titleColor = theme.colorScheme.onSecondaryContainer.withOpacity(0.9);
      final descriptionColor = theme.colorScheme.onSecondaryContainer.withOpacity(0.7);
      //自适应大小
      var titleStyle = theme.textTheme.bodySmall!.copyWith(color: titleColor);
      var descriptionStyle = theme.textTheme.labelSmall!.copyWith(color: descriptionColor);
      double paddingHeight = 5;
      double sizeboxHeight = 1;
      int descriptionLine = 2;
      if (constraints.maxWidth > 350) {
        titleStyle = theme.textTheme.titleMedium!.copyWith(color: titleColor, fontWeight: FontWeight.w800);
        descriptionStyle = theme.textTheme.bodyLarge!.copyWith(color: descriptionColor);
        paddingHeight = 8;
        sizeboxHeight = 3;
        descriptionLine = 4;
      } else if (constraints.maxWidth > 300) {
        titleStyle = theme.textTheme.titleMedium!.copyWith(color: titleColor, fontWeight: FontWeight.w800);
        descriptionStyle = theme.textTheme.bodyLarge!.copyWith(color: descriptionColor);
        paddingHeight = 8;
        sizeboxHeight = 3;
        descriptionLine = 3;
      } else if (constraints.maxWidth > 250) {
        titleStyle = theme.textTheme.titleMedium!.copyWith(color: titleColor, fontWeight: FontWeight.w800);
        descriptionStyle = theme.textTheme.bodyMedium!.copyWith(color: descriptionColor);
        paddingHeight = 8;
        sizeboxHeight = 3;
        descriptionLine = 3;
      } else if (constraints.maxWidth > 220) {
        titleStyle = theme.textTheme.titleMedium!.copyWith(color: titleColor, fontWeight: FontWeight.w700);
        descriptionStyle = theme.textTheme.bodyMedium!.copyWith(color: descriptionColor);
        paddingHeight = 8;
        sizeboxHeight = 3;
      } else if (constraints.maxWidth > 200) {
        titleStyle = theme.textTheme.bodyMedium!.copyWith(color: titleColor);
        descriptionStyle = theme.textTheme.labelMedium!.copyWith(color: descriptionColor);
        paddingHeight = 5;
        sizeboxHeight = 3;
      } else if (constraints.maxWidth > 180) {
        titleStyle = theme.textTheme.bodyMedium!.copyWith(color: titleColor);
        descriptionStyle = theme.textTheme.labelMedium!.copyWith(color: descriptionColor);
        paddingHeight = 5;
        sizeboxHeight = 3;
      }
      return InkWell(
        onTap: () async {
          isLoading = true;
          Video fullVideo = await VideoAPI.getVideoInfo(widget.video.id);
          // 在这里添加你的点击事件处理代码
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return VideoContentPage(video: widget.video,tag: fullVideo.tags![0],);
            }),
          );
          isLoading = false;
        },
        child: Card(
          color: theme.colorScheme.secondaryContainer,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    this.widget.video.picture!.jpg!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(paddingHeight+5,paddingHeight,paddingHeight+5,0),
                child: Column(
                  children: [
                    SizedBox(
                      height: sizeboxHeight,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: isLoading 
                      ? CircularProgressIndicator()
                      : Text(
                        this.widget.video.name!,
                        style: titleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: sizeboxHeight,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        this.widget.video.description!,
                        style: descriptionStyle,
                        maxLines: descriptionLine,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
