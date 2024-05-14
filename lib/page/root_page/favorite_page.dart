import 'package:app_v2/api/favorite.dart';
import 'package:app_v2/components/grid/f_gird_text.dart';
import 'package:app_v2/model/favoritelist.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isLoading = true;
  List<FavoriteList> favoriteLists = List.generate(3, (index) => FavoriteList.loading());
  
  //构造函数
  @override
  void initState() {
    super.initState();
    getFavoriteLists();
  }
  //获取收藏夹
  void getFavoriteLists() async {
    final lists = await FavoriteAPI.getFavoriteLists();
    if(mounted){
      setState(() {
        favoriteLists = lists;
        isLoading = false;
      });
    }
  }
    
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleColor = theme.colorScheme.secondary.withOpacity(0.9);
    var titleStyle = theme.textTheme.titleLarge!.copyWith(color: titleColor,fontWeight: FontWeight.w700);
    //如果正在加载，显示一个圆形进度条
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return LayoutBuilder(builder: (context, constraints) {
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
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10,0),
          child: CustomScrollView(
            slivers: <Widget>[
              //标题
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 10, 0, 10),
                  child: Text('收藏夹', style: titleStyle),
                ),
              ),
              FGridText(favoriteLists: favoriteLists, axisCount: axisCount),
            ],
          ),
        );
      }
    );
  }
}