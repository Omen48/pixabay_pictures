import 'package:flutter/material.dart';
import 'package:pixabay_pictures/UI/screens/main_widget/main_widget.dart';
import 'package:pixabay_pictures/domain/provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAppProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainWidget(),
      ),
    );
  }
}
