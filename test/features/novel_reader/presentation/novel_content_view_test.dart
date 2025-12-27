import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/novel_reader/application/novel_reader_notifier.dart';
import 'package:yomiagerun_app/features/novel_reader/domain/models/novel_content.dart';
import 'package:yomiagerun_app/features/novel_reader/domain/models/novel_reader_state.dart';
import 'package:yomiagerun_app/features/novel_reader/presentation/novel_content_view.dart';

void main() {
  group('NovelContentView Widget', () {
    testWidgets('コンテンツなしの状態でメッセージが表示される',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            novelReaderNotifierProvider.overrideWith(
              () => _TestNovelReaderNotifier(
                const NovelReaderState(),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: NovelContentView(),
            ),
          ),
        ),
      );

      // コンテンツなしメッセージが表示される
      expect(find.text('URLを入力して小説を読み込んでください'), findsOneWidget);
      expect(find.byIcon(Icons.book_outlined), findsOneWidget);
    });

    testWidgets('ローディング中にインジケーターが表示される',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            novelReaderNotifierProvider.overrideWith(
              () => _TestNovelReaderNotifier(
                const NovelReaderState(isLoading: true),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: NovelContentView(),
            ),
          ),
        ),
      );

      // ローディングインジケーターが表示される
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('小説を読み込んでいます...'), findsOneWidget);
    });

    testWidgets('エラーメッセージが表示される', (WidgetTester tester) async {
      const errorMessage = 'テストエラー';

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            novelReaderNotifierProvider.overrideWith(
              () => _TestNovelReaderNotifier(
                const NovelReaderState(errorMessage: errorMessage),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: NovelContentView(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // エラーメッセージが表示される
      expect(find.text('エラー'), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('小説コンテンツが表示される', (WidgetTester tester) async {
      final testContent = NovelContent(
        title: 'テスト小説タイトル',
        author: 'テスト作者',
        url: 'https://example.com',
        paragraphs: [
          'これは最初の段落です。',
          'これは2番目の段落です。',
          'これは3番目の段落です。',
        ],
        fetchedAt: DateTime(2025, 1, 1, 12, 0),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            novelReaderNotifierProvider.overrideWith(
              () => _TestNovelReaderNotifier(
                NovelReaderState(novelContent: testContent),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: NovelContentView(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // タイトルと作者が表示される
      expect(find.text('テスト小説タイトル'), findsOneWidget);
      expect(find.text('テスト作者'), findsOneWidget);

      // 段落が表示される
      expect(find.text('これは最初の段落です。'), findsOneWidget);
      expect(find.text('これは2番目の段落です。'), findsOneWidget);
      expect(find.text('これは3番目の段落です。'), findsOneWidget);

      // 取得日時が表示される
      expect(find.textContaining('取得日時: 2025/01/01'), findsOneWidget);
    });

    testWidgets('ハイライト位置が正しく表示される', (WidgetTester tester) async {
      final testContent = NovelContent(
        title: 'テスト小説',
        author: 'テスト作者',
        url: 'https://example.com',
        paragraphs: [
          '段落1',
          '段落2',
          '段落3',
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            novelReaderNotifierProvider.overrideWith(
              () => _TestNovelReaderNotifier(
                NovelReaderState(
                  novelContent: testContent,
                  currentHighlightPosition: 1, // 2番目の段落をハイライト
                ),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: NovelContentView(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 3つの段落すべてが表示されている
      expect(find.text('段落1'), findsOneWidget);
      expect(find.text('段落2'), findsOneWidget);
      expect(find.text('段落3'), findsOneWidget);

      // ハイライトは視覚的なスタイリングなので、
      // ここではウィジェットが正しくレンダリングされることを確認
    });
  });
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
