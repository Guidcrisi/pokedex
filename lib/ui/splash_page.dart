import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:pokedex/main.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/ui/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement didChangeBuildContext
    super.initState();
    _controller = VideoPlayerController.asset('img/splash_anim.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    Timer(Duration(milliseconds: 2000), () {
      _controller.dispose();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            child: Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )),
          ),
        ],
      ),
    );
  }
}
