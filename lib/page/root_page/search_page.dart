import 'package:app_v2/api/search.dart';
import 'package:app_v2/components/grid/t_grid_text.dart';
import 'package:app_v2/components/grid/v_grid_text.dart';
import 'package:app_v2/model/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String search_keyword = "";
  bool isSearched = false;
  Search search_data = Search();
  final TextEditingController _controller = TextEditingController();

  Future<void> search() async {
    Search result = await SearchAPI.search(search_keyword);
    setState(() {
      search_data = result;
      isSearched = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      search_keyword = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleColor = theme.colorScheme.secondary.withOpacity(0.9);
    var titleStyle = theme.textTheme.titleMedium!.copyWith(color: titleColor,fontWeight: FontWeight.w700);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: LayoutBuilder(builder: (context, constraints) {
          int axisCount = 1;
          if (constraints.maxWidth > 900) {
            axisCount = 5;
          } else if (constraints.maxWidth > 600) {
            axisCount = 3;
          } else if (constraints.maxWidth > 400) {
            axisCount = 2;
          } else if (constraints.maxWidth > 250) {
            axisCount = 1;
          }
          return Column(
            children: [
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '搜索',
                    ),
                    onSubmitted: (String value) {
                      print('搜索');
                      search();
                    },
                  )
                ),
              ),
              if(!isSearched)(
                Expanded(
                  child: Center(
                    child: Text("请输入搜索关键字",style: titleStyle,),
                  ),
                )
              ),
              if(isSearched && search_data.subtitle == null && search_data.videos!.isEmpty && search_data.tags!.isEmpty)(
                Expanded(
                  child: Center(
                    child: Text("没有找到匹配的结果",style: titleStyle,),
                  ),
                )
              ),
              if(isSearched)(
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      if(isSearched && search_data.subtitle != null)...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 10, 0, 10),
                            child: Text("编号匹配的视频",style: titleStyle,),
                          ),
                        ),
                        VGridText(videos: [search_data.subtitle!], axisCount: axisCount)
                      ],
                      if(isSearched && search_data.videos!.isNotEmpty)...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 10, 0, 10),
                            child: Text("名称匹配的视频",style: titleStyle,),
                          ),
                        ),
                        VGridText(videos: search_data.videos!,axisCount: axisCount,)
                      ],
                      if(isSearched && search_data.tags!.isNotEmpty)...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 10, 0, 10),
                            child: Text("名称匹配的标签",style: titleStyle,),
                          ),
                        ),
                        TGridText(tags: search_data.tags!,axisCount: axisCount,)
                      ]
                    ],
                  )
                )
              ),
            ],
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}