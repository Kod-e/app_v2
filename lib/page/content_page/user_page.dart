import 'package:app_v2/model/user.dart';
import 'package:app_v2/page/content_page/login_page.dart';
import 'package:app_v2/page/content_page/upgrade_page.dart';
import 'package:app_v2/service/user.dart';
import 'package:flutter/material.dart';


class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User user = User.loading();
  
  //在进入时看看是否有保存用户信息
  @override
  void initState(){
    super.initState();
    getUserInfo();
  }
  void getUserInfo() async {
    //尝试直接获得user
    User? self_user = await UserService.tryGetUser();
    //如果没有user，就路由到登录页面
    if(self_user == null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }else{
      setState(() {
        user = self_user;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant,
      appBar: AppBar(
        title: Text('我的信息'),
        iconTheme: IconThemeData(color: colorScheme.secondary),
        foregroundColor: colorScheme.secondary,
        //字体颜色为secondary，返回按钮颜色为secondary      
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('账号: ${user.name}'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.workspace_premium),
                title: Text('会员到期时间: ${user.premissionEndTime}'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpgradePage()));  
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.create),
                title: Text('创建时间: ${user.createTime}'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.contact_support),
                title: Text('联系客服'),
                onTap: () {
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('退出登陆'),
                onTap: () async {
                  await UserService.logout();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}