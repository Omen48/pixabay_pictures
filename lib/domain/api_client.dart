import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pixabay_pictures/domain/entity/picture_result.dart';

enum ApiClientExceptionTypes { network, other }

class ApiClientException implements Exception {
  final ApiClientExceptionTypes type;

  ApiClientException({required this.type});
}

class ApiClient {
  final _dio = Dio();
  Future<PictureResult> getPictures(String keyword, int page, int size) async {
    try {
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
    } on SocketException {
      throw ApiClientException(type: ApiClientExceptionTypes.network);
    } catch (_) {
      throw ApiClientException(type: ApiClientExceptionTypes.other);
    }
  }
}
