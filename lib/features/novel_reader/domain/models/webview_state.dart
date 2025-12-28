import 'package:freezed_annotation/freezed_annotation.dart';

part 'webview_state.freezed.dart';

/// WebView の状態を管理するモデル
@freezed
class WebViewState with _$WebViewState {
  const factory WebViewState({
    /// 現在表示中のURL
    @Default('') String currentUrl,

    /// ページ読み込み中かどうか
    @Default(false) bool isLoading,

    /// 戻るボタンが有効かどうか
    @Default(false) bool canGoBack,

    /// 進むボタンが有効かどうか
    @Default(false) bool canGoForward,

    /// ページタイトル（将来使用）
    String? pageTitle,
  }) = _WebViewState;
}
