import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:video_player_demo/src/domain/entities/youtube_videos_info.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_controller.dart';

class VideoPage extends View {
  VideoPage({
    Key? key,
    required this.video,
  }) : super(key: key);

  final YoutubeVideo video;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ViewState<VideoPage, VideoController> {
  _VideoPageState() : super(VideoController());

  @override
  Widget get view => ControlledWidgetBuilder<VideoController>(
        builder: ((context, controller) {
          return Scaffold(
              appBar: AppBar(title: Text(widget.video.videoOwnerChannelTitle!)),

              /// When retrieving invalid youtube video id,
              /// use the video player instead.
              body: widget.video.videoId != null
                  ? YoutubePlayerView(
                      videoId: widget.video.videoId!,
                    )
                  : const VideoPlayerView(
                      url:
                          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
        }),
      );
}

/// Youtube player
class YoutubePlayerView extends StatefulWidget {
  const YoutubePlayerView({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  final String videoId;

  @override
  State<YoutubePlayerView> createState() => _YoutubePlayerViewState();
}

class _YoutubePlayerViewState extends State<YoutubePlayerView> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        /// Auto play and mute video
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
        ),
        builder: (context, player) {
          return Column(
            children: [player],
          );
        });
  }
}

/// Video player
class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          /// Auto play and loop video
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }
}
