import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/novel_reader/application/javascript_injector.dart';

void main() {
  group('JavaScriptInjector', () {
    group('injectHighlightStyle', () {
      test('CSSスタイル注入用のJavaScriptを返す', () {
        final script = JavaScriptInjector.injectHighlightStyle;

        // スクリプトの基本構造を確認
        expect(script, contains('getElementById'));
        expect(script, contains('tts-highlight-style'));
        expect(script, contains('createElement'));
        expect(script, contains('style'));

        // CSSクラス名とスタイルを確認
        expect(script, contains('.tts-highlight'));
        expect(script, contains('background-color'));
        expect(script, contains('transition'));
      });

      test('重複挿入を防ぐロジックが含まれる', () {
        final script = JavaScriptInjector.injectHighlightStyle;

        // 既存チェックのロジックを確認
        expect(script, contains('if (!document.getElementById'));
        expect(script, contains('tts-highlight-style'));
      });
    });

    group('highlightAndScrollToParagraph', () {
      test('指定したインデックスの段落をハイライトするJavaScriptを返す', () {
        final script = JavaScriptInjector.highlightAndScrollToParagraph(5);

        // 基本構造を確認
        expect(script, contains('querySelector'));
        expect(script, contains('querySelectorAll'));
        expect(script, contains('#novel_honbun p'));

        // インデックスが含まれることを確認
        expect(script, contains('[5]'));

        // ハイライトクラスの操作を確認
        expect(script, contains('.tts-highlight'));
        expect(script, contains('classList.add'));
        expect(script, contains('classList.remove'));
      });

      test('スクロール機能が含まれる', () {
        final script = JavaScriptInjector.highlightAndScrollToParagraph(0);

        // scrollIntoView の呼び出しを確認
        expect(script, contains('scrollIntoView'));
        expect(script, contains('behavior'));
        expect(script, contains('smooth'));
        expect(script, contains('block'));
        expect(script, contains('center'));
      });

      test('前のハイライトを削除するロジックが含まれる', () {
        final script = JavaScriptInjector.highlightAndScrollToParagraph(3);

        // 前のハイライト削除のロジックを確認
        expect(script, contains('prevHighlight'));
        expect(script, contains('querySelector(\'.tts-highlight\')'));
        expect(script, contains('classList.remove'));
      });

      test('エラーハンドリングが含まれる', () {
        final script = JavaScriptInjector.highlightAndScrollToParagraph(0);

        // try-catch ブロックを確認
        expect(script, contains('try'));
        expect(script, contains('catch'));
      });

      test('異なるインデックスで異なるJavaScriptを返す', () {
        final script0 = JavaScriptInjector.highlightAndScrollToParagraph(0);
        final script10 = JavaScriptInjector.highlightAndScrollToParagraph(10);

        // インデックスが異なることを確認
        expect(script0, contains('[0]'));
        expect(script10, contains('[10]'));
        expect(script0, isNot(equals(script10)));
      });
    });

    group('clearHighlight', () {
      test('ハイライトをクリアするJavaScriptを返す', () {
        final script = JavaScriptInjector.clearHighlight;

        // 基本構造を確認
        expect(script, contains('querySelector'));
        expect(script, contains('.tts-highlight'));
        expect(script, contains('classList.remove'));
      });

      test('エラーハンドリングが含まれる', () {
        final script = JavaScriptInjector.clearHighlight;

        // try-catch ブロックを確認
        expect(script, contains('try'));
        expect(script, contains('catch'));
      });

      test('存在チェックが含まれる', () {
        final script = JavaScriptInjector.clearHighlight;

        // 要素の存在チェックを確認
        expect(script, contains('if (highlighted)'));
      });
    });
  });
}
