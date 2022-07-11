import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/usecases/get_youtube_videos_info_usecase.dart';

class HomePresenter extends Presenter {
  final GetYoutubeVideosInfoUseCase getYoutubeVideosInfoUseCase;
  HomePresenter(repository)
      : getYoutubeVideosInfoUseCase = GetYoutubeVideosInfoUseCase(repository);

  late Function getYoutubeVideosInfoOnNext;
  late Function getYoutubeVideosInfoOnComplete;
  late Function getYoutubeVideosInfoOnError;

  @override
  void dispose() {
    getYoutubeVideosInfoUseCase.dispose();
  }

  void getYoutubeVideosInfo(String? nextPageToken) {
    getYoutubeVideosInfoUseCase.execute(
      _GetYoutubeVideosInfoUseCaseObserver(this),
      GetYoutubeVideosInfoUseCaseParams(nextPageToken),
    );
  }
}

class _GetYoutubeVideosInfoUseCaseObserver
    extends Observer<GetYoutubeVideosInfoUseCaseResponse> {
  final HomePresenter presenter;

  _GetYoutubeVideosInfoUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getYoutubeVideosInfoOnComplete();
  }

  @override
  void onError(e) {
    presenter.getYoutubeVideosInfoOnError(e);
  }

  @override
  void onNext(GetYoutubeVideosInfoUseCaseResponse? response) {
    presenter.getYoutubeVideosInfoOnNext(response?.youtubeVideosInfo);
  }
}
