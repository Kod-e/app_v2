import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contentpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MyNavigatorObserver _myNavigatorObserver = MyNavigatorObserver(
    onNavigation: (isNavigating) {
    },
  );
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        home: MyHomePage(),
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