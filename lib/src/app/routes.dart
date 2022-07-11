import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player_demo/src/app/pages/home/home_view.dart';
import 'package:video_player_demo/src/app/pages/video/video_view.dart';
import 'package:video_player_demo/src/domain/entities/youtube_videos_info.dart';

class AppRouter {
  late final router = GoRouter(
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      /// 根路徑
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => HomePage(),
      ),

      GoRoute(
        name: 'video-page',
        path: '/video',
        builder: (BuildContext context, GoRouterState state) =>
            VideoPage(video: state.extra as YoutubeVideo),
      ),
    ],
  );
}
