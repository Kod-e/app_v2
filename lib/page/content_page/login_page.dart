import 'package:flutter/material.dart';
import 'package:app_v2/service/user.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool register = false;
  String name = "";
  String password = "";
  
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
  void DoNext() async {
    if(register){
      try{
        await UserService.register(name, generateMd5(password));
        Navigator.of(context).popUntil((route) => route.isFirst);
      }catch (e){
        //弹出一个窗口
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('错误'),
              content: Text(e.toString()),
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
    }else{
      try{
        await UserService.login(name, generateMd5(password));
        Navigator.of(context).popUntil((route) => route.isFirst);
      }catch(e){
        //弹出一个窗口
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('错误'),
              content: Text(e.toString()),
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
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant,
      appBar: AppBar(
        automaticallyImplyLeading: false, // 这行代码会移除返回按钮
        title: Text(register? '登陆' : '注册'),
        iconTheme: IconThemeData(color: colorScheme.secondary),
        foregroundColor: colorScheme.secondary,
        //字体颜色为secondary，返回按钮颜色为secondary      
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(register ? "注册一个新账号":"请登陆您的账号", style: theme.textTheme.headlineLarge!.copyWith(color: colorScheme.secondary)),
              SizedBox(height: 50,),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '用户名',
                      labelStyle: TextStyle(color: colorScheme.secondary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: colorScheme.secondary),
                      ),
                    ),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '密码',
                      labelStyle: TextStyle(color: colorScheme.secondary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: colorScheme.secondary),
                      ),
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Card(
                child: ListTile(
                  title: Center(
                    child: Text(register ? '注册' :'登陆' ,style: TextStyle(color: colorScheme.onSurfaceVariant)),
                  ), // 使用Center小部件将文字居中
                  onTap: () {
                    DoNext();
                  },
                ),
              ),
              SizedBox(height: 10,),
              Card(
                child: ListTile(
                  title: Center(
                    child: Text(register ? '登陆我的账号':'注册一个新账号' ,style: TextStyle(color: colorScheme.onSurfaceVariant)),
                  ), // 使用Center小部件将文字居中
                  onTap: () {
                    setState(() {
                      register = !register;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}