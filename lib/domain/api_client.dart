import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_pictures/domain/entity/picture_result.dart';

// class ApiClient {
//   final _dio = Dio();
//
//   Future<PictureResult> get() async {
//     final response = await _dio.get(
//         'https://pixabay.com/api/?key=45211561-3663b1247d2d2f6f14a46e7f7&image_type=photo');
//     debugPrint(response.toString());
//
//     final data = response.data as Map<String, dynamic>;
//     return PictureResult.fromJson(data);
//   }
// }

class ApiClient {
  final _dio = Dio();

  Future<PictureResult> getPictures(String keyword, int page, int size) async {
    final response = await _dio.get(
      'https://pixabay.com/api/',
      queryParameters: {
        'key': '45211561-3663b1247d2d2f6f14a46e7f7',
        'q': keyword,
        'image_type': 'photo',
        'page': page,
        'per_page': size,
      },
    );
    final data = response.data as Map<String, dynamic>;
    return PictureResult.fromJson(data);
  }
}
