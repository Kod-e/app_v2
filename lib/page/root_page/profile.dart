import 'package:app_v2/page/content_page/color_select_page.dart';
import 'package:app_v2/page/content_page/user_page.dart';
import 'package:app_v2/page/content_page/upgrade_page.dart';
import 'package:flutter/material.dart';
import 'package:app_v2/api/tag.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                print('联系客服');
              },
            ),
          ),
        ],
      ),
    );
  }
}