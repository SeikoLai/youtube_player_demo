import '../entities/youtube_videos_info.dart';

abstract class HomeRepository {
  Future<YoutubeVideosInfo> getYoutubeVideosInfo(String? nextPageToken);
}
