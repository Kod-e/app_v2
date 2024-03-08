import 'package:flutter/material.dart';
import 'package:app_v2/api/config.dart';
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
                print('个人信息');
              },
            ),
          ),
          //充值
          Card(
            child: ListTile(
              leading: Icon(Icons.money),
              title: Text('充值'),
              onTap: () {
                print('充值');
              },
            ),
          ),
          //主题设置
          Card(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('主题设置'),
              onTap: () {
                print('主题设置');
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
          //测试api
          Card(
            child: ListTile(
              leading: Icon(Icons.contact_support),
              title: Text('测试API'),
              onTap: () async {
                // var respones =await dio.get("tag/get/data?id=31");
                // print(respones);
                var tag = await TagAPI().getTagData(31);
                print("name: ${tag.name}");
                var videos = await TagAPI().getTagVideos(31);
                for (var video in videos) {
                  print("video: ${video.name}");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}