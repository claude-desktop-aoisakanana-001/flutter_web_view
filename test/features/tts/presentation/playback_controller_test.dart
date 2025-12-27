import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller_notifier.dart';
import 'package:yomiagerun_app/features/tts/domain/models/playback_state.dart';

void main() {
  group('PlaybackController Widget', () {
    testWidgets('初期表示で停止中と表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: PlaybackController(),
            ),
          ),
        ),
      );

      // 停止中が表示されている
      expect(find.text('停止中'), findsOneWidget);
      expect(find.text('再生中'), findsNothing);
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

    testWidgets('再生中は表示が「再生中」になる', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
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

    testWidgets('再生中のテキストが表示される', (WidgetTester tester) async {
      const testText = 'これはテストテキストです';

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
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

/// テスト用の PlaybackControllerNotifier
class _TestPlaybackControllerNotifier extends PlaybackControllerNotifier {
  _TestPlaybackControllerNotifier(this.initialState);

  final PlaybackState initialState;

  @override
  PlaybackState build() {
    return initialState;
  }
}
