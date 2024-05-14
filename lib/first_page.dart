import 'package:app_v2/api/version.dart';
import 'package:app_v2/contentpage.dart';
import 'package:app_v2/page/content_page/color_select_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


  //是否加载完成变量
  bool isLoaded = false;

  //构造函数
  @override
  void initState() {
    super.initState();
    load();
  }
  //加载器
  Future<void> load() async {
    //从shared_preferences获取themeColor
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getString('themeColor');
    if (colorValue == null) {
      //如果没有颜色就前往选择颜色页面
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ColorSelectPage()),
        (route) => false,
      );
    }
    //等待2秒
    String now_version = "1.0.0";
    Map<String,String> version_data = await VersionAPI.getVersionAndroid();
    await Future.delayed(Duration(seconds: 1));
    //加载完成
    setState(() {
      isLoaded = true;
    });
    //判断版本是否一致
    if (version_data["version"] != now_version) {
      //如果不一致就弹窗提示更新
      showUpdateDialog(context, version_data["url"]!);
    }
  }

  Future<void> showUpdateDialog(BuildContext context, String url) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('发现新版本'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('点击确定到浏览器下载新版本'),
                  Text('如果没有打开浏览器，请尝试手动到浏览器输入URL，已复制到剪贴板，URL为: $url'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('确定'),
                onPressed: () async {
                  try{
                     await launchUrl(Uri.parse(url));
                  }catch (e){}
                  // 使用clipboard复制URL到剪贴板
                  Clipboard.setData(ClipboardData(text: url));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    if (!isLoaded) {
      return Scaffold(
        backgroundColor: colorScheme.surfaceVariant,
        body: Center(
          child: Image.asset('assets/logo.webp'),
        ),
      );
    }else{
      return MyHomePage();
    }
  }
}