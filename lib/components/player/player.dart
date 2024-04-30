import 'package:flutter/material.dart';
import 'package:app_v2/model/play.dart';
import 'package:app_v2/api/video.dart';
import 'package:app_v2/main.dart';
import 'package:app_v2/page/content_page/login_page.dart';
import 'package:app_v2/page/content_page/upgrade_page.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class StreamPlayer extends StatefulWidget {
  // 需要传递id，int，现在是可选的
  final int? id;
  const StreamPlayer({Key? key, this.id}) : super(key: key);
  
  @override
  State<StreamPlayer> createState() => _StreamPlayerState();
}

class _StreamPlayerState extends State<StreamPlayer> with WidgetsBindingObserver {
  Play play = Play();
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool isLoading = true;
  //构造函数
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // 添加这行代码
    if (widget.id != null) {
      getPlay(widget.id!);
    }
  }

  //更新widget
  @override
  void didUpdateWidget(covariant StreamPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    //如果id不同，就重新获取play
    if (oldWidget.id != widget.id && widget.id != null) {
      getPlay(widget.id!);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 添加这行代码
    if( _videoPlayerController != null){
      _videoPlayerController!.dispose();
    }
    if(_chewieController != null){
      _chewieController!.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("changed , pause video player");
    if (state == AppLifecycleState.paused) {
      // 如果播放器正在播放，那么暂停播放器
      if (_videoPlayerController != null && _videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
      }
    }
  }

  //获取play函数
  void getPlay(int id) async {
    try {
      isLoading = true; // 在获取新的 URL 之前设置 isLoading 为 true
      //获取play
      play = await VideoAPI.getVideoPlay(id);
      String url;
      //匹配最合适的playurl
      if (play.dash_hevc != null || play.hevc != null) {
        url = play.hevc ?? play.dash_hevc!;
      } else if (play.dash_h264 != null || play.h264 != null) {
        url = play.h264 ?? play.dash_h264!;
      } else {
        url = '';
      }
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
      _videoPlayerController!.addListener(() {
        if (_videoPlayerController!.value.isPlaying) {
          setState(() {
            isLoading = false;
          });
        }
      });
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: true,
      );
      } catch (error) {
      //如果是401
      if (error == 401) {
        //跳转到登陆页面
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        //如果是403
      } else if (error == 403) {
        //跳转到UpgradePage
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UpgradePage()));
        //弹窗，显示您需要订阅
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('错误'),
              content: Text('您需要订阅才能观看'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('确定'),
                ),
              ],
            );
          },
        );
      } else {
        //把错误转换为String，弹窗
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('错误'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('确定'),
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.black,
            child: isLoading
                ? Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Chewie(
                    controller: _chewieController!,
                  ),
          ),
        );
      },
    );
  }
}
