import 'package:app_v2/model/user.dart';
import 'package:app_v2/model/trade.dart';
import 'package:app_v2/page/content_page/login_page.dart';
import 'package:app_v2/service/user.dart';
import 'package:app_v2/api/trade.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';


enum Options { alipay, wxpay }

class UpgradePage extends StatefulWidget {
  const UpgradePage({super.key});

  @override
  State<UpgradePage> createState() => _UpgradePageState();
}

class _UpgradePageState extends State<UpgradePage> {
  User user = User.loading();
  Options _payOption = Options.alipay;
  //在进入时看看是否有保存用户信息
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    //尝试直接获得user
    User? self_user = await UserService.tryGetUser();
    //如果没有user，就路由到登录页面
    if (self_user == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      setState(() {
        user = self_user;
      });
    }
  }

  void jumpToPayURL(int day) async {
    Trade trade = await UserAPI.getPageByName(day, 'alipay');
    try {
      await launchUrl(Uri.parse(trade.url!));
    } catch (e) {
      Clipboard.setData(ClipboardData(text: trade.url!));
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提醒'),
          content: Text("如果没有自动打开支付页面，请到浏览器粘贴支付链接，链接已经自动复制到剪贴板了，直接粘贴即可，链接为：${trade.url}"),
          actions: <Widget>[
            TextButton(
              child: Text('确定'),
              onPressed: () {
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
    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant,
      appBar: AppBar(
        title: Text('充值'),
        iconTheme: IconThemeData(color: colorScheme.secondary),
        foregroundColor: colorScheme.secondary,
        //字体颜色为secondary，返回按钮颜色为secondary
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8,0,8,0),
        child: ListView(children: [
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
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SegmentedButton<Options>(
              segments: <ButtonSegment<Options>>[
                ButtonSegment<Options>(
                  value: Options.alipay,
                  label: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('支付宝'),
                  ),
                ),
                ButtonSegment<Options>(
                  value: Options.wxpay,
                  label: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('微信'),
                  ),
                ),
              ],
              selected: <Options>{_payOption},
              onSelectionChanged: (Set<Options> newSelection) {
                setState(() {
                  _payOption = newSelection.first;
                });
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.workspace_premium),
              title: Text('购买3年 Premium '),
              trailing: Icon(Icons.check),
              subtitle: Text('约 ¥5/月 ¥198'),
              onTap: () {
                jumpToPayURL(1095);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.workspace_premium),
              title: Text('购买2年 Premium '),
              trailing: Icon(Icons.check),
              subtitle: Text('约 ¥7/月 ¥168'),
              onTap: () {
                jumpToPayURL(730);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.workspace_premium),
              title: Text('购买1年 Premium '),
              subtitle: Text('约 ¥11/月 ¥128'),
              onTap: () {
                jumpToPayURL(365);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.workspace_premium),
              title: Text('购买3个月 Premium '),
              subtitle: Text('约 ¥23/月 ¥68'),
              onTap: () {
                jumpToPayURL(90);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
