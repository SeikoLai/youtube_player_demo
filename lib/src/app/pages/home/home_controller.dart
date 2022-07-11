import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:video_player_demo/src/app/pages/home/home_presenter.dart';
import 'package:video_player_demo/src/domain/entities/youtube_videos_info.dart';

class HomeController extends Controller {
  final HomePresenter presenter;

  YoutubeVideosInfo? _info;
  YoutubeVideosInfo? get info => _info;

  String? _nextPageToken;
  String? get nextPageToken => _nextPageToken;


  HomeController(repository)
      : presenter = HomePresenter(repository),
        super();

  @override
  void onInitState() {

    getYoutubeVideosInfo(_nextPageToken);
  }

  @override
  void initListeners() {
    presenter.getYoutubeVideosInfoOnNext = (YoutubeVideosInfo info) {
      debugPrint(info.toString());

      _info = info;
      _nextPageToken = info.nextPageToken;
      refreshUI();
    };

    presenter.getYoutubeVideosInfoOnComplete = () {
      debugPrint('Youtube videos info retrieved');
    };

    presenter.getYoutubeVideosInfoOnError = (e) {
      debugPrint('Could not retrieve youtube videos info.');
    };
  }

  void getYoutubeVideosInfo(String? nextPageToken) =>
      presenter.getYoutubeVideosInfo(nextPageToken);
}
