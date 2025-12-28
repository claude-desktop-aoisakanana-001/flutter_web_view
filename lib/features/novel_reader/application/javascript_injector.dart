/// JavaScript Injection ユーティリティ
///
/// WebView内でのハイライト表示と自動スクロールを行うJavaScriptコードを提供します。
/// Issue #11: MVP完成のための統合機能
class JavaScriptInjector {
  /// CSSスタイルをインジェクト（初回のみ）
  ///
  /// TTSハイライト用のCSSスタイルを定義します。
  /// 黄色の半透明背景でハイライトし、滑らかなトランジションを適用します。
  static String get injectHighlightStyle => '''
    if (!document.getElementById('tts-highlight-style')) {
      const style = document.createElement('style');
      style.id = 'tts-highlight-style';
      style.textContent = \`
        .tts-highlight {
          background-color: rgba(255, 255, 0, 0.3) !important;
          transition: background-color 0.3s ease;
        }
      \`;
      document.head.appendChild(style);
    }
  ''';

  /// 指定した段落をハイライトしてスクロール
  ///
  /// [index] ハイライトする段落のインデックス（0始まり）
  ///
  /// 前のハイライトを削除し、新しい段落をハイライトして画面中央にスクロールします。
  /// 小説家になろうのサイト構造（#novel_honbun p）に依存します。
  static String highlightAndScrollToParagraph(int index) => '''
    (function() {
      try {
        // 前のハイライトを削除
        const prevHighlight = document.querySelector('.tts-highlight');
        if (prevHighlight) {
          prevHighlight.classList.remove('tts-highlight');
        }

        // 新しい段落をハイライト
        const paragraphs = document.querySelectorAll('#novel_honbun p');
        if (paragraphs && paragraphs[$index]) {
          paragraphs[$index].classList.add('tts-highlight');
          paragraphs[$index].scrollIntoView({
            behavior: 'smooth',
            block: 'center'
          });
        }
      } catch (e) {
        console.error('Failed to highlight paragraph:', e);
      }
    })();
  ''';

  /// すべてのハイライトを削除
  ///
  /// TTS停止時やページ遷移時に呼び出されます。
  static String get clearHighlight => '''
    (function() {
      try {
        const highlighted = document.querySelector('.tts-highlight');
        if (highlighted) {
          highlighted.classList.remove('tts-highlight');
        }
      } catch (e) {
        console.error('Failed to clear highlight:', e);
      }
    })();
  ''';
}
