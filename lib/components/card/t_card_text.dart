import 'package:app_v2/page/content_page/tag_content_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TCardText extends StatefulWidget {
  const TCardText({super.key});

  @override
  State<TCardText> createState() => _TCardTextState();
}

class _TCardTextState extends State<TCardText> {
  @override
  Widget build(BuildContext context) {
    //获取主题
    //使用自适应布局工具
    return LayoutBuilder(builder: (context, constraints) {
      //针对最小版本的自适应
      final theme = Theme.of(context);
      //自适应大小
      var titleStyle =
          theme.textTheme.labelMedium!.copyWith(color: Colors.white);
      double leftP = 10;
      double bP = 5;
      if (constraints.maxWidth > 220) {
        titleStyle = theme.textTheme.titleLarge!.copyWith(color: Colors.white);
        leftP = 15;
        bP = 12;
      } else if (constraints.maxWidth > 200) {
        titleStyle = theme.textTheme.titleMedium!.copyWith(color: Colors.white);
      } else if (constraints.maxWidth > 180) {
        titleStyle = theme.textTheme.bodyLarge!.copyWith(color: Colors.white);
      }
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return TagContentPage();
            }),
          );
        },
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(children: [
                //图片
                Positioned.fill(
                  child: Image.asset(
                    'assets/img181.webp',
                    fit: BoxFit.cover,
                  ),
                ),
                //对比度渐变遮照
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.15),
                          Colors.black.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ),
                //左下角悬浮文字
                Positioned(
                  bottom: bP,
                  left: leftP,
                  child: Text('标签的标题', style: titleStyle),
                ),
              ]),
            ),
          ),
        ),
      );
    });
  }
}
