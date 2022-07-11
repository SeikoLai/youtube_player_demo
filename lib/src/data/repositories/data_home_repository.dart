import 'package:video_player_demo/src/data/api_manager.dart';
import 'package:video_player_demo/src/domain/repositories/home_repository.dart';

import '../../domain/entities/youtube_videos_info.dart';

import 'dart:convert';

class DataHomeRepository extends HomeRepository {
  // sigleton
  static final DataHomeRepository _instance = DataHomeRepository._internal();
  DataHomeRepository._internal();
  factory DataHomeRepository() => _instance;

  @override
  Future<YoutubeVideosInfo> getYoutubeVideosInfo(String? nextPageToken) async {
    try {
      final response =
          await APIManager().getYoutubeVideos(pageToken: nextPageToken);
      if (response?.body is String) {
        return YoutubeVideosInfo.fromJson(jsonDecode(response.body));
      }
      throw Exception('Failed to parse json from ${response?.body}.');
    } catch (e) {
      throw Exception('Failed to get youtube videos info beacuse: $e');
    }
  }
}
