import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller_notifier.dart';
import 'package:yomiagerun_app/features/tts/domain/models/playback_state.dart';
import 'package:yomiagerun_app/features/novel_reader/application/webview_notifier.dart';
import 'package:yomiagerun_app/features/novel_reader/application/novel_reader_notifier.dart';
import 'package:yomiagerun_app/features/novel_reader/domain/models/webview_state.dart';
import 'package:yomiagerun_app/features/novel_reader/domain/models/novel_reader_state.dart';
import 'package:yomiagerun_app/features/novel_reader/domain/models/novel_content.dart';

void main() {
  group('PlaybackController Widget', () {
    // Issue #10: 初期状態（非小説ページ）では無効化メッセージが表示される
    testWidgets('初期表示で「小説ページで有効化されます」と表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: PlaybackController(),
            ),
          ),
        ),
      );

      // 非小説ページでは無効化メッセージが表示される
      expect(find.text('小説ページで有効化されます'), findsOneWidget);
      expect(find.text('停止中'), findsNothing);
      expect(find.text('再生中'), findsNothing);
    });

    // Issue #10: 小説ページでコンテンツがある場合に「停止中」と表示される
    testWidgets('小説ページでは停止中と表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // 小説ページ状態をオーバーライド
            webViewNotifierProvider.overrideWith(
              () => _TestWebViewNotifier(
                const WebViewState(
                  isNovelPage: true,
                  currentNovelUrl: 'https://ncode.syosetu.com/n1234ab/1/',
                ),
              ),
            ),
            // 小説コンテンツをオーバーライド
            novelReaderNotifierProvider.overrideWith(
              () => _TestNovelReaderNotifier(
                NovelReaderState(
                  novelContent: NovelContent(
                    title: 'テスト小説',
                    author: 'テスト作者',
                    url: 'https://ncode.syosetu.com/n1234ab/1/',
                    paragraphs: const ['段落1', '段落2'],
                    fetchedAt: DateTime.now(),
                  ),
                ),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: PlaybackController(),
            ),
          ),
        ),
      );

      // 停止中が表示されている
      expect(find.text('停止中'), findsOneWidget);
      expect(find.text('再生中'), findsNothing);
      expect(find.text('小説ページで有効化されます'), findsNothing);
    });

    testWidgets('再生/一時停止/停止ボタンが表示されている', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: PlaybackController(),
            ),
          ),
        ),
      );

      // 各ボタンのアイコンが表示されている
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsOneWidget);
      expect(find.byIcon(Icons.stop), findsOneWidget);
    });

    testWidgets('初期状態で一時停止と停止ボタンが無効', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: PlaybackController(),
            ),
          ),
        ),
      );

      // 一時停止ボタンと停止ボタンを探す
      final pauseButton = find.widgetWithIcon(IconButton, Icons.pause);
      final stopButton = find.widgetWithIcon(IconButton, Icons.stop);

      // ボタンが存在することを確認
      expect(pauseButton, findsOneWidget);
      expect(stopButton, findsOneWidget);

      // 実際のウィジェットを取得して無効状態を確認
      final pauseIconButton = tester.widget<IconButton>(pauseButton);
      final stopIconButton = tester.widget<IconButton>(stopButton);

      // 初期状態では一時停止と停止ボタンは無効（onPressed が null）
      expect(pauseIconButton.onPressed, isNull);
      expect(stopIconButton.onPressed, isNull);
    });

    // Issue #10: 小説ページで再生中の場合に「再生中」と表示される
    testWidgets('小説ページで再生中は表示が「再生中」になる', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // 小説ページ状態をオーバーライド
            webViewNotifierProvider.overrideWith(
              () => _TestWebViewNotifier(
                const WebViewState(
                  isNovelPage: true,
                  currentNovelUrl: 'https://ncode.syosetu.com/n1234ab/1/',
                ),
              ),
            ),
            // 小説コンテンツをオーバーライド
            novelReaderNotifierProvider.overrideWith(
              () => _TestNovelReaderNotifier(
                NovelReaderState(
                  novelContent: NovelContent(
                    title: 'テスト小説',
                    author: 'テスト作者',
                    url: 'https://ncode.syosetu.com/n1234ab/1/',
                    paragraphs: const ['段落1', '段落2'],
                    fetchedAt: DateTime.now(),
                  ),
                ),
              ),
            ),
            // 再生中の状態をオーバーライド
            playbackControllerNotifierProvider.overrideWith(
              () => _TestPlaybackControllerNotifier(
                const PlaybackState(isPlaying: true),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: PlaybackController(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 再生中が表示されている
      expect(find.text('再生中'), findsOneWidget);
      expect(find.text('停止中'), findsNothing);
      expect(find.text('小説ページで有効化されます'), findsNothing);
    });

    testWidgets('Card 内に配置されている', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: PlaybackController(),
            ),
          ),
        ),
      );

      // Card ウィジェットが存在する
      expect(find.byType(Card), findsOneWidget);
    });

    // Issue #10: 小説ページで再生中のテキストが表示される
    testWidgets('小説ページで再生中のテキストが表示される', (WidgetTester tester) async {
      const testText = 'これはテストテキストです';

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // 小説ページ状態をオーバーライド
            webViewNotifierProvider.overrideWith(
              () => _TestWebViewNotifier(
                const WebViewState(
                  isNovelPage: true,
                  currentNovelUrl: 'https://ncode.syosetu.com/n1234ab/1/',
                ),
              ),
            ),
            // 小説コンテンツをオーバーライド
            novelReaderNotifierProvider.overrideWith(
              () => _TestNovelReaderNotifier(
                NovelReaderState(
                  novelContent: NovelContent(
                    title: 'テスト小説',
                    author: 'テスト作者',
                    url: 'https://ncode.syosetu.com/n1234ab/1/',
                    paragraphs: const ['段落1', '段落2'],
                    fetchedAt: DateTime.now(),
                  ),
                ),
              ),
            ),
            playbackControllerNotifierProvider.overrideWith(
              () => _TestPlaybackControllerNotifier(
                const PlaybackState(
                  isPlaying: true,
                  currentText: testText,
                ),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: PlaybackController(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 再生中のテキストが表示されている
      expect(find.text(testText), findsOneWidget);
    });
  });
}

/// テスト用の WebViewNotifier
class _TestWebViewNotifier extends WebViewNotifier {
  _TestWebViewNotifier(this.initialState);

  final WebViewState initialState;

  @override
  WebViewState build() {
    return initialState;
  }
}

/// テスト用の NovelReaderNotifier
class _TestNovelReaderNotifier extends NovelReaderNotifier {
  _TestNovelReaderNotifier(this.initialState);

  final NovelReaderState initialState;

  @override
  NovelReaderState build() {
    return initialState;
  }
}

/// テスト用の PlaybackControllerNotifier
class _TestPlaybackControllerNotifier extends PlaybackControllerNotifier {
  _TestPlaybackControllerNotifier(this.initialState);

  final PlaybackState initialState;

  @override
  PlaybackState build() {
    return initialState;
  }
}
