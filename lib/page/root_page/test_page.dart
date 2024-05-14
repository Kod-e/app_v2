import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.terminal),
              title: Text('清除颜色设置'),
              onTap: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove('themeColor');
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}