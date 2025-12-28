import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yomiagerun_app/features/novel_reader/presentation/novel_reader_screen.dart';
import 'package:yomiagerun_app/features/tts/presentation/speed_settings.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller.dart';

void main() {
  // Issue #9: WebView requires platform implementation which is not available in test environment
  // These tests are skipped until we implement proper WebView mocking
  group('NovelReaderScreen Widget (Issue #9: WebView Browser)', () {
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
    }, skip: 'WebView platform implementation not available in test environment');

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
    }, skip: 'WebView platform implementation not available in test environment');

    testWidgets('WebViewWidget が表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NovelReaderScreen(),
          ),
        ),
      );

      // WebViewWidget が表示される
      expect(find.byType(WebViewWidget), findsOneWidget);
    }, skip: 'WebView platform implementation not available in test environment');

    testWidgets('TTSコントロール（SpeedSettings と PlaybackController）が表示される',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NovelReaderScreen(),
          ),
        ),
      );

      // SpeedSettings が表示される
      expect(find.byType(SpeedSettings), findsOneWidget);

      // PlaybackController が表示される
      expect(find.byType(PlaybackController), findsOneWidget);
    }, skip: 'WebView platform implementation not available in test environment');

    // Issue #9: URL入力UIは使用しないため、以下のテストはスキップ
    testWidgets('URL入力欄が表示されない（Issue #9でコメントアウト）',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NovelReaderScreen(),
          ),
        ),
      );

      // URL入力欄が表示されない
      expect(find.byType(TextField), findsNothing);
      expect(find.text('小説のURLを入力'), findsNothing);
    }, skip: 'WebView platform implementation not available in test environment');

    testWidgets('読み込みボタンが表示されない（Issue #9でコメントアウト）',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NovelReaderScreen(),
          ),
        ),
      );

      // 読み込みボタンが表示されない
      expect(find.text('読み込み'), findsNothing);
      expect(find.byIcon(Icons.download), findsNothing);
    }, skip: 'WebView platform implementation not available in test environment');

    // 以下のテストはスキップ（Issue #9でURL入力UIを削除したため）
    // testWidgets('URLが空の状態で読み込みボタンをタップするとエラーメッセージが表示される', (WidgetTester tester) async { ... }, skip: true);
    // testWidgets('TextField にテキストを入力できる', (WidgetTester tester) async { ... }, skip: true);
  });
}
