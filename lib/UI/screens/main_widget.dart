import 'package:flutter/material.dart';

class PictureData {
  final String imageAsset;

  PictureData({required this.imageAsset});
}

class MainWidget extends StatelessWidget {
  MainWidget({super.key});

  final List<PictureData> pictures = [
    PictureData(imageAsset: 'assets/images/painter_willage.png'),
    PictureData(imageAsset: 'assets/images/painter_willage.png'),
    PictureData(imageAsset: 'assets/images/painter_willage.png'),
    PictureData(imageAsset: 'assets/images/painter_willage.png'),
    PictureData(imageAsset: 'assets/images/painter_willage.png'),
  ];

  int _calcColumns(double width) {
    if (width < 600) {
      return 2;
    } else if (width < 700) {
      return 3;
    } else if (width <800){
      return 4;
    }else return 5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('testTask'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            int columns = _calcColumns(constraints.maxWidth);
            return GridView.builder(
              itemCount: pictures.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns),
              itemBuilder: (BuildContext context, index) => PictureWidget(
                imageAsset: pictures[index].imageAsset,
              ),
            );
          },
        ),
      ),
    );
  }
}

class PictureWidget extends StatelessWidget {
  String imageAsset;

  PictureWidget({required this.imageAsset, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('$imageAsset'),
    );
  }
}
