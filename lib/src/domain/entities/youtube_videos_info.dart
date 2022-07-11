import 'package:json_annotation/json_annotation.dart';

part 'youtube_videos_info.g.dart';

@JsonSerializable()
class YoutubeVideosInfo {
  YoutubeVideosInfo(
    this.kind,
    this.etag,
    this.nextPageToken,
    this.items,
    this.pageInfo,
  );

  String? kind;
  String? etag;
  String? nextPageToken;

  List<YoutubeVideo>? items;

  PageInfo pageInfo;

  factory YoutubeVideosInfo.fromJson(Map<String, dynamic> json) =>
      _$YoutubeVideosInfoFromJson(json);
  Map<String, dynamic> toJson() => _$YoutubeVideosInfoToJson(this);
}

@JsonSerializable()
class YoutubeVideo {
  YoutubeVideo(
    this.kind,
    this.etag,
    this.id,
    this.snippet,
    this.contentDetails,
    this.status,
  );

  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;
  ContentDetails? contentDetails;
  Status? status;
  String? get title => snippet?.title;
  String? get url => contentDetails?.videoId == null
      ? null
      : 'https://www.youtube.com/watch?v=${contentDetails!.videoId}';
  String? get videoId =>
      contentDetails?.videoId == null ? null : contentDetails!.videoId;
  String? get videoOwnerChannelTitle => snippet?.videoOwnerChannelTitle;
  
  factory YoutubeVideo.fromJson(Map<String, dynamic> json) =>
      _$YoutubeVideoFromJson(json);
  Map<String, dynamic> toJson() => _$YoutubeVideoToJson(this);
}

@JsonSerializable()
class Snippet {
  Snippet(
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.playlistId,
    this.position,
    this.resourceId,
    this.videoOwnerChannelTitle,
    this.videoOwnerChannelId,
  );

  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails thumbnails;
  String? channelTitle;
  String? playlistId;
  int? position;
  ResourceId? resourceId;
  String? videoOwnerChannelTitle;
  String? videoOwnerChannelId;

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);
  Map<String, dynamic> toJson() => _$SnippetToJson(this);
}

@JsonSerializable()
class Thumbnails {
  Thumbnails(
    this.defaultInfo,
    this.medium,
  );

  @JsonKey(name: 'default')
  Thumbnail? defaultInfo;

  Thumbnail? medium;

  Thumbnail? high;

  Thumbnail? standard;

  Thumbnail? maxres;

  factory Thumbnails.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailsFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailsToJson(this);
}

@JsonSerializable()
class Thumbnail {
  Thumbnail(
    this.url,
    this.width,
    this.height,
  );

  String? url;
  int? width;
  int? height;

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}

@JsonSerializable()
class ResourceId {
  ResourceId(
    this.kind,
    this.videoId,
  );

  String? kind;
  String? videoId;

  factory ResourceId.fromJson(Map<String, dynamic> json) =>
      _$ResourceIdFromJson(json);
  Map<String, dynamic> toJson() => _$ResourceIdToJson(this);
}

@JsonSerializable()
class ContentDetails {
  ContentDetails(
    this.videoId,
    this.videoPublishedAt,
  );

  String? videoId;
  String? videoPublishedAt;

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ContentDetailsToJson(this);
}

@JsonSerializable()
class Status {
  Status(this.privacyStatus);

  String? privacyStatus;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

@JsonSerializable()
class PageInfo {
  PageInfo();
  int? totalResults;
  int? resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PageInfoToJson(this);
}
