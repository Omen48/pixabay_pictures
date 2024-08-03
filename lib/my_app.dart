import 'package:flutter/material.dart';
import 'package:pixabay_pictures/UI/screens/main_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainWidget(),
    );
  }
}

//   void getData(String keyWord) {
//     Uri url = Uri.parse("https://pixabay.com/api/?"
//         "key=16582589-68a2e0e5d7a78080a8fa51cbe"
//         "&q=${keyWord}"
//         "&page=${currentPage}"
//         "&per_page=${size}");
//     http.get(url).then((onResp) {
//       setState(() {
//         this.imagesDate = json.decode(onResp.body);
//         hits.addAll(imagesDate['hits']);
//         int totalHits = imagesDate['totalHits'] as int;
//         if (totalHits % size == 0) {
//           totelPages = totalHits ~/ size;
//         } else {
//           totelPages = 1 + (totalHits / size).floor();
//         }
//       });
//     }).catchError((onError) {});
//   }
// }
