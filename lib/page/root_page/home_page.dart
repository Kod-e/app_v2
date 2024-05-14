import 'package:flutter/material.dart';
import 'package:app_v2/api/page.dart';
import 'package:app_v2/components/viewlist/viewlist_controller.dart';
import 'package:app_v2/model/viewlist.dart';
import 'package:app_v2/model/page.dart' as model;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = true;
  late model.Page pageData; // 使用model.Page解决重名问题
  List<ViewList> viewlists = [];
  //init函数
  @override
  void initState() {
    super.initState();
    //获取首页数据
    getPage();
  }
  void getPage() async {
    pageData = await PageAPI.getPageByName("home");
    print(pageData.viewlists);

    //把viewlist添加到viewlists中
    for(var vl in pageData.viewlists!){
      if(mounted){
        setState(() {
          viewlists.add(vl);
        });
      }
    }
    //设置加载状态
    if(mounted){
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
      return SingleChildScrollView(
        child: Column(
          children: viewlists.map((viewlist) => ViewListController(viewList: viewlist)).toList(),
        ),
      );
    }
  }
}