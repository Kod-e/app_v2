import 'package:flutter/material.dart';
import 'package:app_v2/model/viewlist.dart';
import 'package:app_v2/components/viewlist/viewlist_type1.dart';
import 'package:app_v2/components/viewlist/viewlist_type2.dart';
class ViewListController extends StatelessWidget {
  //需要传递一个viewlist
  final ViewList viewList;
  const ViewListController({Key? key, required this.viewList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(viewList.type == 1){
      return ViewListType1(viewList: viewList);
    }else if(viewList.type == 2){
      return ViewListType2(viewList: viewList);
    }
    return Container();
  }
}
