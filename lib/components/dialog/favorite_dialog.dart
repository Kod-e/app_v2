import 'package:app_v2/api/favorite.dart';
import 'package:flutter/material.dart';

void showFavoriteDialog(int vid, BuildContext context) async{
  //获取所有收藏夹
  List<Map<String,dynamic>> favoriteLists = await FavoriteAPI.getFavoriteListsName();
  //显示对话框
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('选择收藏夹'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: favoriteLists.length + 1, // 增加一个元素用于添加收藏夹
            itemBuilder: (BuildContext context, int index) {
              if (index == favoriteLists.length) {
                // 如果当前索引是列表的最后一个元素，返回一个新的Card
                return Card(
                  child: ListTile(
                    title: Text('添加收藏夹'),
                    onTap: () {
                      // 在这里处理添加收藏夹的逻辑
                      addFavoriteDialog(context);
                    },
                  ),
                );
              } else {
                // 否则返回原来的Card
                return Card(
                  child: ListTile(
                    title: Text(favoriteLists[index]['name']),
                    onTap: () {
                      // 在这里处理用户选择收藏夹的逻辑，例如添加视频到收藏夹
                      FavoriteAPI.addVideoToFavoriteList(favoriteLists[index]['id'], vid);
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
void addFavoriteDialog(BuildContext context) async {
  final TextEditingController controller = TextEditingController(); // 创建一个TextEditingController
  //显示对话框
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('新建收藏夹'),
        content: TextField(
          controller: controller, // 使用创建的TextEditingController
          decoration: InputDecoration(
            hintText: '请输入收藏夹名称',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('确定'),
            onPressed: () {
              // 使用TextEditingController的text属性获取用户输入的文本
              String name = controller.text;
              // 在这里处理用户输入的收藏夹名称，例如新建收藏夹
              FavoriteAPI.addFavoriteList(name);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}