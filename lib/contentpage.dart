import 'package:app_v2/page/root_page/favorite_page.dart';
import 'package:app_v2/page/root_page/search_page.dart';
import 'package:flutter/material.dart';
import 'page/root_page/profile.dart';
import 'page/root_page/test_page.dart';
import 'page/root_page/home_page.dart';
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    //页面列表
    Widget page;
    switch (selectedIndex) {
      case 0: //主页
        page = HomePage();
        break;
      case 1: //作者
        page = FavoritePage();
        break;
      case 2: //搜索
        page = SearchPage();
        break;
      case 3: //个人
        page = ProfilePage();
        break;
      case 4: //测试
        page = TestPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );
    //自适应Build，用于传递constraints来检测屏幕宽度
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 450) {
              return Column(
                children: [
                  Expanded(child: mainArea),
                  BottomNavigationBar(
                    selectedItemColor: colorScheme.secondary,
                    unselectedItemColor: colorScheme.secondary,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: 'Favorites',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                      // BottomNavigationBarItem(
                      //   icon: Icon(Icons.terminal),
                      //   label: 'Terminal',
                      // ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  )
                ],
              );
            } else {
              return Row(
                children: [
                  NavigationRail(
                    extended: constraints.maxWidth >= 750,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('主页'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('收藏夹'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.search),
                        label: Text('搜索'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person),
                        label: Text('设置'),
                      ),
                      // NavigationRailDestination(
                      //   icon: Icon(Icons.terminal),
                      //   label: Text('测试'),
                      // ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                  Expanded(child: mainArea),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
