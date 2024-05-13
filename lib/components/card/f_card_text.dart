import 'package:app_v2/model/favoritelist.dart';
import 'package:app_v2/page/content_page/favorite_list_page.dart';
import 'package:flutter/material.dart';


class FCardText extends StatefulWidget {
  final FavoriteList favoriteList;
  const FCardText({Key? key, required this.favoriteList}) : super(key: key);

  @override
  State<FCardText> createState() => _FCardTextState();
}

class _FCardTextState extends State<FCardText> {
  late String picture;
  //构造函数
  @override
  void initState() {
    super.initState();
    //如果FavoriteList里没有video，就使用默认图片
    if (this.widget.favoriteList.videos!.isEmpty) {
      picture = 'https://www.loliapi.com/acg/';
    } else {
      picture = this.widget.favoriteList.videos!.first.picture!.jpg!;
    }
  }
  @override
  Widget build(BuildContext context) {
    //获取主题
    //使用自适应布局工具
    return LayoutBuilder(builder: (context, constraints) {
      //针对最小版本的自适应
      final theme = Theme.of(context);
      //自适应大小
      var titleStyle =
          theme.textTheme.labelMedium!.copyWith(color: Colors.white , fontWeight: FontWeight.bold);
      double leftP = 10;
      double bP = 5;
      if (constraints.maxWidth > 220) {
        titleStyle = theme.textTheme.titleLarge!.copyWith(color: Colors.white,fontWeight: FontWeight.w800);
        leftP = 15;
        bP = 12;
      } else if (constraints.maxWidth > 200) {
        titleStyle = theme.textTheme.titleMedium!.copyWith(color: Colors.white,fontWeight: FontWeight.w700);
      } else if (constraints.maxWidth > 180) {
        titleStyle = theme.textTheme.bodyLarge!.copyWith(color: Colors.white,fontWeight: FontWeight.w600);
      }
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return FavoriteListPage(favoriteList: this.widget.favoriteList);
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
                  child: Image.network(
                    picture,
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
                  child: Text(this.widget.favoriteList.name ?? "未命名", style: titleStyle),
                ),
              ]),
            ),
          ),
        ),
      );
    });
  }
}