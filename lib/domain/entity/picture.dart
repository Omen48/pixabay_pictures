import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'picture.g.dart';

@JsonSerializable()
class Picture {
  final int id;
  final String pageUrl;
  final String typel;
  final List<String> tags;
  final String previewURL;
  final int previewWidth;
  final int previewHeight;
  final String webformatURL;
  final int webformatWidth;
  final int webformatHeight;
  final String largeImageURL;
  final int imageWidth;
  final int imageHeight;
  final String imageSize;
  final int views;
  final int downloads;
  final int collections;
  final int likes;
  final int comments;
  @JsonKey(name: 'user_id')
  final int userId;
  final String user;
  final String userImageURL;

  Picture(
      {required this.id,
      required this.pageUrl,
      required this.typel,
      required this.tags,
      required this.previewURL,
      required this.previewWidth,
      required this.previewHeight,
      required this.webformatURL,
      required this.webformatWidth,
      required this.webformatHeight,
      required this.largeImageURL,
      required this.imageWidth,
      required this.imageHeight,
      required this.imageSize,
      required this.views,
      required this.downloads,
      required this.collections,
      required this.likes,
      required this.comments,
      required this.userId,
      required this.user,
      required this.userImageURL});

  factory Picture.fromJson(Map<String, dynamic> json) =>
      _$PictureFromJson(json);

  Map<String, dynamic> toJson() => _$PictureToJson(this);
}
