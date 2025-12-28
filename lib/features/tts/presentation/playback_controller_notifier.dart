import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yomiagerun_app/features/tts/application/tts_service.dart';
import 'package:yomiagerun_app/features/tts/domain/models/playback_state.dart';
import 'package:yomiagerun_app/features/novel_reader/application/novel_reader_notifier.dart';
import 'package:yomiagerun_app/features/novel_reader/application/javascript_injector.dart';

part 'playback_controller_notifier.g.dart';

/// 再生コントローラーの状態を管理する Notifier
///
/// TtsService と連携して再生/一時停止/停止を制御します。
/// Issue #10: 小説コンテンツとの統合
/// Issue #11: JavaScript Injection によるハイライトとスクロール
@riverpod
class PlaybackControllerNotifier extends _$PlaybackControllerNotifier {
  // Issue #11: WebViewController への参照
  WebViewController? _webViewController;

  @override
  PlaybackState build() {
    return const PlaybackState();
  }

  /// WebViewController を設定（Issue #11）
  ///
  /// NovelReaderScreen から呼び出され、JavaScript Injection を有効にします。
  void setWebViewController(WebViewController controller) {
    _webViewController = controller;
  }

  /// 小説コンテンツが利用可能かどうか（Issue #10）
  bool get hasNovelContent {
    final novelContent = ref.read(novelReaderNotifierProvider).novelContent;
    return novelContent != null && novelContent.paragraphs.isNotEmpty;
  }

  /// 再生を開始
  ///
  /// [text] 読み上げるテキスト（オプション）
  /// Issue #10: text が null の場合、小説コンテンツから再生します
  /// Issue #11: ハイライトと自動スクロールを実行
  Future<void> play([String? text]) async {
    // Issue #10: 小説コンテンツからの再生
    if (text == null) {
      if (!hasNovelContent) {
        return;
      }

      final novelContent = ref.read(novelReaderNotifierProvider).novelContent!;
      final ttsNotifier = ref.read(ttsServiceNotifierProvider.notifier);

      state = state.copyWith(
        isPlaying: true,
        currentPosition: 0,
        totalLength: novelContent.paragraphs.length,
      );

      try {
        // Issue #11: 初回CSSスタイルを注入
        await _injectHighlightStyle();

        for (int i = 0; i < novelContent.paragraphs.length; i++) {
          // 停止された場合は中断
          if (!state.isPlaying) break;

          state = state.copyWith(
            currentPosition: i,
            currentText: novelContent.paragraphs[i],
          );

          // Issue #11: ハイライトとスクロール
          await _highlightAndScrollToParagraph(i);

          await ttsNotifier.speak(novelContent.paragraphs[i]);
        }

        // 最後まで再生したら停止
        await _clearHighlight();
        state = state.copyWith(isPlaying: false);
      } catch (e) {
        await _clearHighlight();
        state = state.copyWith(isPlaying: false);
        rethrow;
      }
      return;
    }

    // 従来の動作（テキストを直接指定）
    if (text.isEmpty) {
      return;
    }

    try {
      final ttsNotifier = ref.read(ttsServiceNotifierProvider.notifier);
      await ttsNotifier.speak(text);

      state = state.copyWith(
        isPlaying: true,
        currentText: text,
      );
    } catch (e) {
      // エラーハンドリング
      state = state.copyWith(isPlaying: false);
      rethrow;
    }
  }

  /// 一時停止
  Future<void> pause() async {
    try {
      final ttsNotifier = ref.read(ttsServiceNotifierProvider.notifier);
      await ttsNotifier.pause();

      state = state.copyWith(isPlaying: false);
    } catch (e) {
      rethrow;
    }
  }

  /// 停止（Issue #11: ハイライトをクリア）
  Future<void> stop() async {
    try {
      final ttsNotifier = ref.read(ttsServiceNotifierProvider.notifier);
      await ttsNotifier.stop();

      // Issue #11: ハイライトをクリア
      await _clearHighlight();

      state = state.copyWith(
        isPlaying: false,
        currentPosition: 0,
        currentText: null,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// CSSスタイルを注入（Issue #11）
  Future<void> _injectHighlightStyle() async {
    if (_webViewController == null) return;

    try {
      await _webViewController!.runJavaScript(
        JavaScriptInjector.injectHighlightStyle,
      );
    } catch (e) {
      // ページ遷移などでエラーが出る可能性があるが、無視
    }
  }

  /// 段落をハイライトしてスクロール（Issue #11）
  Future<void> _highlightAndScrollToParagraph(int index) async {
    if (_webViewController == null) return;

    try {
      await _webViewController!.runJavaScript(
        JavaScriptInjector.highlightAndScrollToParagraph(index),
      );
    } catch (e) {
      // ページ遷移などでエラーが出る可能性があるが、無視
    }
  }

  /// ハイライトをクリア（Issue #11）
  Future<void> _clearHighlight() async {
    if (_webViewController == null) return;

    try {
      await _webViewController!.runJavaScript(
        JavaScriptInjector.clearHighlight,
      );
    } catch (e) {
      // ページ遷移などでエラーが出る可能性があるが、無視
    }
  }

  /// 再生位置を設定
  ///
  /// [position] 新しい再生位置（段落のインデックス）
  void setPosition(int position) {
    state = state.copyWith(currentPosition: position);
  }

  /// 全体の長さを設定
  ///
  /// [length] 段落の総数
  void setTotalLength(int length) {
    state = state.copyWith(totalLength: length);
  }
}
