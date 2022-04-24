import 'package:flutter/material.dart';
import 'package:test1/screens/recipe/components/player_widget.dart';
import 'package:video_player/video_player.dart';

class NetworkPlayerController extends StatefulWidget {
  final String url;
  NetworkPlayerController({required this.url}) ;

  @override
  State<StatefulWidget> createState() => _NetworkPlayerControllerState(url: url);
}

class _NetworkPlayerControllerState extends State<NetworkPlayerController> {
  String url;
  late VideoPlayerController controller;

  _NetworkPlayerControllerState({required this.url});
  
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(url)
    ..addListener(() => setState(() {}))
    ..setLooping(true)
    ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;
    return Column(
      children: [
        VideoPlayerWidget(controller: controller),
      ],
    );
  }
  
}