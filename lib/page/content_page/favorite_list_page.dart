import 'package:app_v2/api/favorite.dart';
import 'package:app_v2/components/grid/v_grid_text.dart';
import 'package:app_v2/model/favoritelist.dart';
import 'package:flutter/material.dart';


class FavoriteListPage extends StatefulWidget {
  final FavoriteList favoriteList;
  const FavoriteListPage({Key? key, required this.favoriteList}) : super(key: key);

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant,
      appBar: AppBar(
        title: Text(this.widget.favoriteList.name!,style: theme.textTheme.titleMedium,),
        foregroundColor: colorScheme.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10,0),
        child: LayoutBuilder(builder: (context, constraints) {
            int axisCount = 1;
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
              slivers: <Widget>[
                //标题
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                VGridText(videos: widget.favoriteList.videos!, axisCount: axisCount),
              ],
            );
          }
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.delete), // 垃圾桶图标
      //   onPressed: () {
      //     // 在这里定义点击后的操作
      //     FavoriteAPI.deleteFavoriteList(widget.favoriteList.id);
      //     Navigator.of(context).pop();
      //   },
      // ),
    );
  }
}