// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Picture _$PictureFromJson(Map<String, dynamic> json) => Picture(
      id: (json['id'] as num).toInt(),
      pageUrl: json['pageUrl'] as String?,
      typel: json['typel'] as String?,
      tags: (json['tags'] as String).split(',').map((e) => e.trim()).toList(),
      previewURL: json['previewURL'] as String,
      previewWidth: (json['previewWidth'] as num).toInt(),
      previewHeight: (json['previewHeight'] as num).toInt(),
      webformatURL: json['webformatURL'] as String,
      webformatWidth: (json['webformatWidth'] as num).toInt(),
      webformatHeight: (json['webformatHeight'] as num).toInt(),
      largeImageURL: json['largeImageURL'] as String,
      imageWidth: (json['imageWidth'] as num).toInt(),
      imageHeight: (json['imageHeight'] as num).toInt(),
      imageSize: json['imageSize'] as int,
      views: (json['views'] as num).toInt(),
      downloads: (json['downloads'] as num).toInt(),
      collections: (json['collections'] as num).toInt(),
      likes: (json['likes'] as num).toInt(),
      comments: (json['comments'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      user: json['user'] as String,
      userImageURL: json['userImageURL'] as String,
    );

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'id': instance.id,
      'pageUrl': instance.pageUrl,
      'tags': instance.tags?.join(', '),
      'tags': instance.tags,
      'previewURL': instance.previewURL,
      'previewWidth': instance.previewWidth,
      'previewHeight': instance.previewHeight,
      'webformatURL': instance.webformatURL,
      'webformatWidth': instance.webformatWidth,
      'webformatHeight': instance.webformatHeight,
      'largeImageURL': instance.largeImageURL,
      'imageWidth': instance.imageWidth,
      'imageHeight': instance.imageHeight,
      'imageSize': instance.imageSize,
      'views': instance.views,
      'downloads': instance.downloads,
      'collections': instance.collections,
      'likes': instance.likes,
      'comments': instance.comments,
      'user_id': instance.userId,
      'user': instance.user,
      'userImageURL': instance.userImageURL,
    };
