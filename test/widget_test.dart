import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixabay_pictures/UI/screens/full_screen_image.dart';
import 'package:pixabay_pictures/UI/screens/picture_widget.dart';
import 'package:pixabay_pictures/my_app.dart';
import 'package:pixabay_pictures/UI/screens/main_widget/main_widget_model.dart';
import 'package:provider/provider.dart';

void main() {
  Widget createTestableWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainWidgetModel>(
          create: (_) => MainWidgetModel(),
        ),
      ],
      child: const MyApp(),
    );
  }

  group('Приложение Pixabay Pictures', () {
    testWidgets('Начальная загрузка показывает заголовок приложения',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Pixabay pictures'), findsOneWidget);
    });

    testWidgets('Поле поиска присутствует, а GridView изначально отсутствует',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(GridView), findsNothing);
    });

    testWidgets('Выполнение поиска и отображение результатов',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());

      await tester.enterText(find.byType(TextField), 'nature');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('Загрузка дополнительных изображений при прокрутке',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());

      await tester.enterText(find.byType(TextField), 'nature');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(GridView), findsOneWidget);

      await tester.fling(find.byType(GridView), const Offset(0, -300), 1000);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('Открытие изображения на весь экран и его закрытие',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());

      await tester.enterText(find.byType(TextField), 'nature');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(GridView), findsOneWidget);

      await tester.tap(find.byType(PictureWidget).first);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(FullScreenImageOverlay), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(FullScreenImageOverlay), findsNothing);
    });
  });
}
