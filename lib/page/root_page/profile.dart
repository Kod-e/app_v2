import 'package:app_v2/page/content_page/color_select_page.dart';
import 'package:app_v2/page/content_page/user_page.dart';
import 'package:app_v2/page/content_page/upgrade_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void JumpToSupport(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('点击确定跳转到客服'),
          content: Text("如果没有自动跳转到客服的URL，请使用telegram添加@aaron13362"),
          actions: <Widget>[
            TextButton(
              child: Text('确定'),
              onPressed: () async {
                try{
                    await launchUrl(Uri.parse("https://t.me/aaron13362"));
                }catch (e){}
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('个人信息'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));  
              },
            ),
          ),
          //充值
          Card(
            child: ListTile(
              leading: Icon(Icons.money),
              title: Text('充值'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpgradePage()));  
              },
            ),
          ),
          //主题设置
          Card(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('主题设置'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ColorSelectPage()));  
              },
            ),
          ),
          //联系客服
          Card(
            child: ListTile(
              leading: Icon(Icons.contact_support),
              title: Text('联系客服'),
              onTap: () {
                JumpToSupport(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}