import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/novel_reader/domain/models/novel_reader_state.dart';

void main() {
  group('NovelReaderNotifier', () {
    test('初期状態が正しく設定される', () {
      const state = NovelReaderState();

      expect(state.novelContent, isNull);
      expect(state.isLoading, false);
      expect(state.errorMessage, isNull);
      expect(state.currentHighlightPosition, 0);
    });

    test('copyWith で部分的に状態を更新できる', () {
      const state = NovelReaderState();
      final updatedState = state.copyWith(isLoading: true);

      expect(updatedState.isLoading, true);
      expect(updatedState.novelContent, isNull);
      expect(updatedState.errorMessage, isNull);
    });

    test('エラーメッセージを設定できる', () {
      const state = NovelReaderState();
      const errorMessage = 'テストエラー';
      final updatedState = state.copyWith(errorMessage: errorMessage);

      expect(updatedState.errorMessage, errorMessage);
      expect(updatedState.isLoading, false);
    });

    // 注意: loadNovel() のような非同期メソッドの完全なテストには
    // モックされた NarouParserService と WebViewController が必要です。
    // これらは統合テストまたは E2E テストで検証することを推奨します。
  });
}
