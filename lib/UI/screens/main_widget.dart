// import 'package:flutter/material.dart';
// import 'package:pixabay_pictures/domain/api_client.dart';
//
// class PictureData {
//   final String imageAsset;
//
//   PictureData({required this.imageAsset});
// }
//
// class MainWidget extends StatelessWidget {
//   MainWidget({super.key});
//
//   final List<PictureData> pictures = [
//     PictureData(imageAsset: 'assets/images/painter_willage.png'),
//     PictureData(imageAsset: 'assets/images/painter_willage.png'),
//     PictureData(imageAsset: 'assets/images/painter_willage.png'),
//     PictureData(imageAsset: 'assets/images/painter_willage.png'),
//     PictureData(imageAsset: 'assets/images/painter_willage.png'),
//   ];
//
//   int _calcColumns(double width) {
//     if (width < 600) {
//       return 2;
//     } else if (width < 700) {
//       return 3;
//     } else if (width < 800) {
//       return 4;
//     } else
//       return 5;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('testTask'),
//       ),
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             int columns = _calcColumns(constraints.maxWidth);
//             return GridView.builder(
//               itemCount: pictures.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: columns),
//               itemBuilder: (BuildContext context, index) => PictureWidget(
//                 imageAsset: pictures[index].imageAsset,
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: IconButton(
//         icon: Icon(Icons.download),
//         onPressed: () => ApiClient().get(),
//       ),
//     );
//   }
// }
//
// class PictureWidget extends StatefulWidget {
//   final String imageAsset;
//
//   const PictureWidget({required this.imageAsset, super.key});
//
//   @override
//   State<PictureWidget> createState() => _PictureWidgetState();
// }
//
// class _PictureWidgetState extends State<PictureWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Image.asset(widget.imageAsset),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pixabay_pictures/UI/screens/main_widget_model.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainWidgetModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('testTask'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search images, vectors',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        final keyword = _searchController.text;
                        if (keyword.isNotEmpty) {
                          Provider.of<MainWidgetModel>(context, listen: false)
                              .loadPictures(keyword);
                        }
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<MainWidgetModel>(
                  builder: (context, model, child) {
                    if (model.isLoading && model.pictures.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        int columns = _calcColumns(constraints.maxWidth);
                        return NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (!model.isLoading &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              model.loadPictures(_searchController.text);
                              return true;
                            }
                            return false;
                          },
                          child: GridView.builder(
                            itemCount: model.pictures.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                            ),
                            itemBuilder: (BuildContext context, index) {
                              return PictureWidget(
                                imageAsset: model.pictures[index].webformatURL,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calcColumns(double width) {
    if (width < 600) {
      return 2;
    } else if (width < 700) {
      return 3;
    } else if (width < 800) {
      return 4;
    } else {
      return 5;
    }
  }
}

class PictureWidget extends StatelessWidget {
  final String imageAsset;

  const PictureWidget({required this.imageAsset, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(imageAsset),
    );
  }
}
