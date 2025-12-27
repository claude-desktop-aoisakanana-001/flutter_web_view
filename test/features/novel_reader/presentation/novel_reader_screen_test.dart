import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/novel_reader/presentation/novel_reader_screen.dart';

void main() {
  group('NovelReaderScreen Widget', () {
    testWidgets('画面タイトルが表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NovelReaderScreen(),
          ),
        ),
      );

      // タイトルが表示される
      expect(find.text('よみあげRun'), findsOneWidget);
    });

    testWidgets('URL入力欄が表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NovelReaderScreen(),
          ),
        ),
      );

      // URL入力欄が表示される
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('小説のURLを入力'), findsOneWidget);
    });

    testWidgets('読み込みボタンが表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NovelReaderScreen(),
          ),
        ),
      );

      // 読み込みボタンが表示される
      expect(find.text('読み込み'), findsOneWidget);
      expect(find.byIcon(Icons.download), findsOneWidget);
    });

    testWidgets('設定ボタンが表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NovelReaderScreen(),
          ),
        ),
      );

      // 設定ボタンが表示される
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('URLが空の状態で読み込みボタンをタップするとエラーメッセージが表示される',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NovelReaderScreen(),
          ),
        ),
      );

      // 読み込みボタンをタップ
      await tester.tap(find.text('読み込み'));
      await tester.pumpAndSettle();

      // エラーメッセージが表示される
      expect(find.text('URLを入力してください'), findsOneWidget);
    });

    testWidgets('TextField にテキストを入力できる', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NovelReaderScreen(),
          ),
        ),
      );

      // TextFieldにテキストを入力
      await tester.enterText(
        find.byType(TextField),
        'https://ncode.syosetu.com/n1234ab/1/',
      );
      await tester.pump();

      // 入力されたテキストが表示される
      expect(
        find.text('https://ncode.syosetu.com/n1234ab/1/'),
        findsOneWidget,
      );
    });
  });
}
