import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_v2/main.dart';
class ColorSelectPage extends StatefulWidget {
  const ColorSelectPage({super.key});

  @override
  State<ColorSelectPage> createState() => _ColorSelectPageState();
}

class _ColorSelectPageState extends State<ColorSelectPage> {
  // 创建一个颜色列表
  final Map<String, MaterialColor> colors = {
    'Pink': Colors.pink,
    'Cyan': Colors.cyan,
    'Indigo': Colors.indigo,
    'Teal': Colors.teal,
    'Red': Colors.red,
    'Green': Colors.green,
    'Yellow': Colors.yellow,
    'Orange': Colors.orange,
  };

  // 创建一个函数来保存颜色到SharedPreferences
  Future<void> saveColorToPrefs(String color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeColor', color);
    // 路由到MyApp实现重新加载，并且放弃之前的所有路由
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => MyApp()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var theme = Theme.of(context);
    var titleStyle = theme.textTheme.titleLarge!.copyWith(color: colorScheme.primary , fontWeight: FontWeight.bold);
    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8,0,8,0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('选择你喜欢的颜色',style: titleStyle),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: colors.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 设置每行显示3个Card
                    childAspectRatio: 1.3, // 设置每个Card为正方形
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    String colorName = colors.keys.elementAt(index);
                    MaterialColor color = colors[colorName]!;
                    ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: color);
                    var cardTextStyle = theme.textTheme.titleMedium!.copyWith(color: colorScheme.primary , fontWeight: FontWeight.bold);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => saveColorToPrefs(colorName), // 点击Card时保存颜色到SharedPreferences
                        child: Card(
                          color: colorScheme.surfaceVariant, // 使用surfaceVariant的模拟颜色作为Card的颜色
                          child: Center(child: Text(colorName,style: cardTextStyle,)), // 在Card中显示颜色的名称
                        ),
                      )
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}