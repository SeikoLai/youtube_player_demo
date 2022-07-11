import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player_demo/src/app/widgets/home/video_thumbnail_view.dart';
import 'package:video_player_demo/src/data/repositories/data_home_repository.dart';
import 'package:video_player_demo/src/domain/entities/youtube_videos_info.dart';

import 'home_controller.dart';

class HomePage extends View {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(DataHomeRepository()));

  /// Configure app bar and tab indicators
  final _appBar = AppBar(
      title: const Text('Video Player', style: TextStyle(fontSize: 36.0)),
      bottom: const TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: EdgeInsets.symmetric(vertical: 10.0),
        tabs: [
          Text('SizedBox', style: TextStyle(fontSize: 24.0)),
          Text('ListTile', style: TextStyle(fontSize: 24.0)),
        ],
      ));

  HomeController? _controller;

  /// Retrieve next page videos
  void getNextPageVideos(String? nextPageToken) {
    _controller?.getYoutubeVideosInfo(_controller?.nextPageToken);
  }

  @override
  Widget get view {
    return ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
      /// Set home controller
      _controller = controller;

      /// Get useful data
      final YoutubeVideosInfo? videoInfo = controller.info;
      final List<Thumbnails?>? thumbnails =
          videoInfo?.items?.map((item) => item.snippet?.thumbnails).toList();
      final List<YoutubeVideo>? videos = videoInfo?.items;

      /// Layout tab bar style UI
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar,
          body: TabBarView(
            children: [
              /// Sizedbox widgets
              ListView.separated(
                itemCount: thumbnails?.length ?? 0,
                itemBuilder: (BuildContext context, int index) =>
                    _buildDetectorItem(thumbnails, index, context, videos),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 0.0),
              ),

              /// ListTile widgets
              ListView.separated(
                itemCount: thumbnails?.length ?? 0,
                itemBuilder: (BuildContext context, int index) =>
                    _buildListTile(context, videos, index, thumbnails),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 5.0),
              ),
            ],
          ),
        ),
      );
    });
  }

  ListTile _buildListTile(
    BuildContext context,
    List<YoutubeVideo>? videos,
    int index,
    List<Thumbnails?>? thumbnails,
  ) {
    return ListTile(
      onTap: () => context.pushNamed('video-page', extra: videos?[index]),
      title: thumbnails?[index]?.high?.url == null
          ? Text(index.toString())
          : VideoThumbnailView(
              url: thumbnails![index]!.high!.url!,
              title: videos![index].title!),
    );
  }

  SizedBox _buildDetectorItem(
    List<Thumbnails?>? thumbnails,
    int index,
    BuildContext context,
    List<YoutubeVideo>? videos,
  ) {
    return SizedBox(
      height: thumbnails?[index]?.high?.height?.toDouble(),
      child: GestureDetector(
        onTap: () => context.pushNamed('video-page', extra: videos?[index]),
        child: thumbnails?[index]?.high?.url == null
            ? Text(index.toString())
            : VideoThumbnailView(
                url: thumbnails![index]!.high!.url!,
                title: videos![index].title!),
      ),
    );
  }
}
