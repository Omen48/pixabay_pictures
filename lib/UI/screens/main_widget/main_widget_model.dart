import 'package:flutter/material.dart';
import 'package:pixabay_pictures/domain/api_client.dart';
import 'package:pixabay_pictures/domain/entity/picture.dart';

enum ViewState { loading, loaded, noResults, networkError, otherError }

class MainWidgetModel with ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  List<Picture> _pictures = [];
  ViewState _state = ViewState.loaded;
  int _currentPage = 1;
  int _totalPages = 1;
  String _currentKeyword = '';
  String? _errorMessage;

  ViewState get state => _state;
  List<Picture> get pictures => _pictures;
  String? get errorMessage => _errorMessage;

  Future<void> initialLoad() async {
    await _loadPictures('');
  }

  Future<void> searchPictures(String keyword) async {
    if (keyword != _currentKeyword) {
      _currentKeyword = keyword;
      _pictures = [];
      _currentPage = 1;
      _totalPages = 1;
    }
    await _loadPictures(keyword);
  }

  Future<void> _loadPictures(String keyword) async {
    if (_state == ViewState.loading || _currentPage > _totalPages) return;
    _state = ViewState.loading;
    notifyListeners();

    try {
      final result =
          await _apiClient.getPictures(_currentKeyword, _currentPage, 20);
      if (result.hits.isEmpty && _pictures.isEmpty) {
        _state = ViewState.noResults;
      } else {
        _pictures.addAll(result.hits);
        _currentPage++;
        _totalPages = (result.totalHits / 20).ceil();
        _state = ViewState.loaded;
      }
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionTypes.network:
          _state = ViewState.networkError;
          _errorMessage = "Ошибка сети";
          break;
        case ApiClientExceptionTypes.other:
          _state = ViewState.otherError;
          _errorMessage = "Что-то пошло не так, попробуйте позже";
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  void loadMore() async {
    await _loadPictures(_currentKeyword);
  }
}
