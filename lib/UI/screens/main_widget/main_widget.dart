import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pixabay_pictures/UI/screens/main_widget/main_widget_model.dart';
import 'package:pixabay_pictures/UI/screens/picture_widget.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  _onSearchChanged() {
    final query = _searchController.text;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      Provider.of<MainWidgetModel>(context, listen: false)
          .searchPictures(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MainWidgetModel>(context, listen: false).initialLoad();
    });
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pixabay pictures'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Поиск',
                ),
              ),
            ),
            const Expanded(child: PicturesView()),
          ],
        ),
      ),
    );
  }
}

class PicturesView extends StatelessWidget {
  const PicturesView({super.key});

  int _calcColumns(double width) => (width / 200).floor().clamp(2, 6);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainWidgetModel>(
      builder: (context, model, child) {
        switch (model.state) {
          case ViewState.loading:
            return const Center(child: CircularProgressIndicator());
          case ViewState.noResults:
            return const Center(
                child: Text('По вашему запросу ничего не найдено :('));
          case ViewState.networkError:
            return Center(child: Text(model.errorMessage ?? 'Network error'));
          case ViewState.otherError:
            return Center(
                child:
                    Text(model.errorMessage ?? 'An unexpected error occurred'));
          case ViewState.loaded:
          case ViewState.idle:
            return LayoutBuilder(
              builder: (context, constraints) {
                int columns = _calcColumns(constraints.maxWidth);
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      model.loadMore();
                      return true;
                    }
                    return false;
                  },
                  child: GridView.builder(
                    itemCount: model.pictures.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (BuildContext context, index) => PictureWidget(
                      imageAsset: model.pictures[index].webformatURL,
                      views: model.pictures[index].views,
                      likes: model.pictures[index].likes,
                      largeImageAsset: model.pictures[index].largeImageURL,
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
