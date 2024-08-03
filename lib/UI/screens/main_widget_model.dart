import 'package:flutter/material.dart';
import 'package:pixabay_pictures/domain/api_client.dart';
import 'package:pixabay_pictures/domain/entity/picture.dart';
//
// class MainWidgetModel with ChangeNotifier {
//   final _apiClient = ApiClient();
//   List<Picture> _pictures = [];
//   bool _isLoading = false;
//   int _currentPage = 1;
//   int _totalPages = 1;
//
//   List<Picture> get pictures => _pictures;
//
//   bool get isLoading => _isLoading;
//
//   Future<void> loadPictures(String keyword) async {
//     if (_isLoading || _currentPage > _totalPages) return;
//
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final result = await _apiClient.get();
//       _pictures.addAll(result.hits);
//       _totalPages = (result.totalHits / 10).ceil();
//       _currentPage++;
//     } catch (e) {
//       // Handle error
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

class MainWidgetModel with ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  List<Picture> _pictures = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;

  List<Picture> get pictures => _pictures;
  bool get isLoading => _isLoading;

  Future<void> loadPictures(String keyword) async {
    if (_isLoading || _currentPage > _totalPages) return;

    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiClient.getPictures(keyword, _currentPage, 10);
      _pictures.addAll(result.hits);
      _totalPages = (result.totalHits / 10).ceil();
      _currentPage++;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
