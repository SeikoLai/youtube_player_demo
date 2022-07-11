import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:video_player_demo/src/domain/entities/youtube_videos_info.dart';
import 'package:video_player_demo/src/domain/repositories/home_repository.dart';

class GetYoutubeVideosInfoUseCase extends UseCase<
    GetYoutubeVideosInfoUseCaseResponse, GetYoutubeVideosInfoUseCaseParams> {
  final HomeRepository repository;
  GetYoutubeVideosInfoUseCase(this.repository);

  @override
  Future<Stream<GetYoutubeVideosInfoUseCaseResponse?>> buildUseCaseStream(
      GetYoutubeVideosInfoUseCaseParams? params) async {
    final controller = StreamController<GetYoutubeVideosInfoUseCaseResponse>();
    try {
      // get youtube videos info
      final youtubeVideosInfo =
          await repository.getYoutubeVideosInfo(params?.nextPageToken);
      // Adding it triggers the .onNext() in the 'Observer'
      // It is usually better to wrap the response inside a response object.
      controller.add(GetYoutubeVideosInfoUseCaseResponse(youtubeVideosInfo));
      logger.finest('GetMemberCenterUseCase successful.');
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetYoutubeVideosInfoUseCaseResponse {
  final YoutubeVideosInfo youtubeVideosInfo;
  GetYoutubeVideosInfoUseCaseResponse(this.youtubeVideosInfo);
}

class GetYoutubeVideosInfoUseCaseParams {
  String? nextPageToken;
  GetYoutubeVideosInfoUseCaseParams(this.nextPageToken);
}
