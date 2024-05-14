import 'package:app_v2/first_page.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contentpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MyNavigatorObserver _myNavigatorObserver = MyNavigatorObserver(
    onNavigation: (isNavigating) {
    },
  );

  var themeColor = Colors.pink;
  final Map<String, MaterialColor> colors = {
    'Pink': Colors.pink,
    'Red': Colors.red,
    'Cyan': Colors.cyan,
    'Green': Colors.green,
    'Yellow': Colors.yellow,
    'Indigo': Colors.indigo,
    'Orange': Colors.orange,
    'Teal': Colors.teal,
  };
  //构造函数
  @override
  void initState() {
    //尝试从shared_preferences获取themeColor
    setColorFromPrefs();
  }

  Future<void> setColorFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getString('themeColor');
    if (colorValue != null) {
      setState(() {
        themeColor = colors[colorValue]!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'BDSMHUB',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: themeColor),
        ),
        // home: MyHomePage(),
        home: FirstPage(),
        navigatorObservers: [_myNavigatorObserver],
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];
  void toggleFavorite(WordPair pair) {
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }
}


class MyNavigatorObserver extends NavigatorObserver {
  final ValueChanged<bool> onNavigation;

  MyNavigatorObserver({required this.onNavigation});

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    onNavigation(true);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    onNavigation(false);
  }
}
class AppProvider extends InheritedWidget {
  final MyNavigatorObserver navigatorObserver;

  AppProvider({
    required Widget child,
    required this.navigatorObserver,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppProvider oldWidget) {
    return navigatorObserver != oldWidget.navigatorObserver;
  }

  static MyNavigatorObserver of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>()!.navigatorObserver;
  }
}