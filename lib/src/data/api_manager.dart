import 'package:http/http.dart' as http;

import '../../other/keys.dart';

class APIManager {
  static final APIManager _manager = APIManager._internal();
  factory APIManager() => _manager;
  APIManager._internal();

  /// 取得Youtube 影片清單<br>
  /// - [youtubeAPIKey] API Key<br>
  /// - [playlistId] 清單ID<br>
  /// - [maxResults] 影片數量<br>
  /// - [pageToken] 下一頁影片 token
  dynamic getYoutubeVideos(
      {String youtubeAPIKey = APIKeys.youtubeAPIKey,
      String playlistId = 'UUMUnInmOkrWN4gof9KlhNmQ',
      String maxResults = '20',
      String? pageToken}) async {
    final String path =
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=$playlistId&key=$youtubeAPIKey&maxResults=$maxResults&nextPage=$pageToken';

    final response = await http.get(Uri.parse(path));
    try {
      if (response.statusCode == 200) {
        return response;
      }
      throw 'An unknow error occurred';
    } catch (e) {
      throw Exception('Failed to get youtube videos info beacuse: $e');
    }
  }
}
