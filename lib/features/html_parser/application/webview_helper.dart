import 'package:webview_flutter/webview_flutter.dart';

/// WebView の初期化と設定のヘルパークラス
///
/// NarouParserService で使用する WebViewController を作成・設定します。
class WebViewHelper {
  /// WebViewController を作成
  ///
  /// JavaScript実行を有効化し、ページ読み込み完了を検出できるように設定します。
  static WebViewController createController({
    void Function(String url)? onPageFinished,
  }) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: onPageFinished,
          onWebResourceError: (WebResourceError error) {
            // エラーハンドリング
            print('WebView resource error: ${error.description}');
          },
        ),
      );
  }

  /// 使用例:
  ///
  /// ```dart
  /// // WebView初期化
  /// final controller = WebViewHelper.createController(
  ///   onPageFinished: (url) {
  ///     print('Page loaded: $url');
  ///   },
  /// );
  ///
  /// // パーサーに渡す
  /// final parserService = ref.read(narouParserServiceProvider.notifier);
  /// final novel = await parserService.parseFromWebView(
  ///   webViewController: controller,
  ///   url: 'https://ncode.syosetu.com/n1234ab/1/',
  /// );
  /// ```
}
