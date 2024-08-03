import 'package:json_annotation/json_annotation.dart';
import 'package:pixabay_pictures/domain/entity/picture.dart';

part 'picture_result.g.dart';

@JsonSerializable(explicitToJson: true)
class PictureResult {
  final int total;
  final int totalHits;
  final List<Picture> hits;

  PictureResult({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  factory PictureResult.fromJson(Map<String, dynamic> json) =>
      _$PictureResultFromJson(json);
  Map<String, dynamic> toJson() => _$PictureResultToJson(this);
}
