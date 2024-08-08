import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pixabay_pictures/main.dart' as app;
import 'package:pixabay_pictures/UI/screens/full_screen_image.dart';
import 'package:pixabay_pictures/UI/screens/picture_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Приложение Pixabay Pictures', () {
    testWidgets('Начальная загрузка показывает заголовок приложения',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Pixabay pictures'), findsOneWidget);
    });

    testWidgets('Поле поиска и GridView присутствуют ',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      // await tester.pump(const Duration(seconds: 2));
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('Выполнение поиска и отображение результатов',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'nature');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));


      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('Загрузка дополнительных изображений при прокрутке',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'nature');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));


      expect(find.byType(GridView), findsOneWidget);

      await tester.fling(find.byType(GridView), const Offset(0, -300), 1000);

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('Открытие изображения на весь экран и его закрытие',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'nature');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.pumpAndSettle(const  Duration(milliseconds: 500));

      expect(find.byType(GridView), findsOneWidget);

      await tester.tap(find.byType(PictureWidget).first);
      await tester.pumpAndSettle(const  Duration(milliseconds: 500));

      expect(find.byType(FullScreenImageOverlay), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle(const  Duration(milliseconds: 500));

      expect(find.byType(FullScreenImageOverlay), findsNothing);
    });
    testWidgets('Отображение сообщения "ничего не найдено"', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'nonexistentquery');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('По вашему запросу ничего не найдено :('), findsOneWidget);
    });
  });
}
