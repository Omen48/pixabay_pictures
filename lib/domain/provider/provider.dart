import 'package:flutter/material.dart';
import 'package:pixabay_pictures/UI/screens/main_widget/main_widget_model.dart';
import 'package:provider/provider.dart';

class MyAppProvider extends StatelessWidget {
  final Widget child;

  const MyAppProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainWidgetModel(),
        ),
      ],
      child: child,
    );
  }
}
