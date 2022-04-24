import 'package:flutter/material.dart';
import 'package:test1/constants.dart';
import 'package:test1/screens/recipe/components/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  VideoPlayerWidget({required this.controller});

  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? Container(
            alignment: Alignment.topCenter,
            child: buildVideo(),
          )
      : Container(
        child: const CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      );

  Widget buildVideo() => Stack(
      children: [
        buildVideoPlayer(),
        Positioned.fill(child: BasicOverlayWidget(controller: controller)),
      ],
  );

  Widget buildVideoPlayer() => AspectRatio(
    aspectRatio: controller.value.aspectRatio,
    child: VideoPlayer(controller),
  );
      

}