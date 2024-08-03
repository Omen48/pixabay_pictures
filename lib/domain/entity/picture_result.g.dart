// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureResult _$PictureResultFromJson(Map<String, dynamic> json) =>
    PictureResult(
      total: (json['total'] as num).toInt(),
      totalHits: (json['totalHits'] as num).toInt(),
      hits: (json['hits'] as List<dynamic>)
          .map((e) => Picture.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PictureResultToJson(PictureResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'totalHits': instance.totalHits,
      'hits': instance.hits.map((e) => e.toJson()).toList(),
    };
