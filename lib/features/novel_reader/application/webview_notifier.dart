import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/webview_state.dart';
import '../../html_parser/application/narou_url_detector.dart';

part 'webview_notifier.g.dart';

/// WebView の状態を管理する Notifier
@riverpod
class WebViewNotifier extends _$WebViewNotifier {
  @override
  WebViewState build() {
    return const WebViewState();
  }

  /// ページ読み込み開始時の処理
  void onPageStarted(String url) {
    state = state.copyWith(
      currentUrl: url,
      isLoading: true,
    );
  }

  /// ページ読み込み完了時の処理
  void onPageFinished(String url) {
    state = state.copyWith(
      currentUrl: url,
      isLoading: false,
    );
  }

  /// ナビゲーション状態の更新
  void updateNavigationState({
    required bool canGoBack,
    required bool canGoForward,
  }) {
    state = state.copyWith(
      canGoBack: canGoBack,
      canGoForward: canGoForward,
    );
  }

  /// エラー発生時の処理
  void onError(String errorMessage) {
    state = state.copyWith(isLoading: false);
    // TODO: エラーメッセージの表示は将来実装
  }

  /// ページタイトルの更新（将来使用）
  void updatePageTitle(String? title) {
    state = state.copyWith(pageTitle: title);
  }

  /// 小説ページかどうかを判定して状態を更新（Issue #10）
  void checkNovelPage(String url) {
    final isNovel = NarouUrlDetector.isNovelPage(url);
    state = state.copyWith(
      isNovelPage: isNovel,
      currentNovelUrl: isNovel ? url : null,
    );
  }

  /// 小説ページ情報をクリア（Issue #10）
  void clearNovelPage() {
    state = state.copyWith(
      isNovelPage: false,
      currentNovelUrl: null,
    );
  }
}
