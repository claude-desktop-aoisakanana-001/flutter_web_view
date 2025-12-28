import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yomiagerun_app/features/novel_reader/application/novel_reader_notifier.dart';
import 'package:yomiagerun_app/features/novel_reader/application/webview_notifier.dart';
import 'package:yomiagerun_app/features/tts/presentation/speed_settings.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller_notifier.dart';

/// 小説閲覧画面
///
/// WebView を使用して「小説家になろう」のサイトをブラウザとして表示します。
/// Issue #9: WebView ベースのブラウザ実装
/// Issue #11: JavaScript Injection によるハイライトとスクロール
class NovelReaderScreen extends ConsumerStatefulWidget {
  const NovelReaderScreen({super.key});

  @override
  ConsumerState<NovelReaderScreen> createState() => _NovelReaderScreenState();
}

class _NovelReaderScreenState extends ConsumerState<NovelReaderScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // WebViewController の初期化
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => _onPageStarted(url),
          onPageFinished: (url) => _onPageFinished(url),
          onWebResourceError: (error) => _onError(error),
        ),
      )
      ..loadRequest(Uri.parse('https://syosetu.com/'));
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// ページ読み込み開始時の処理
  void _onPageStarted(String url) {
    ref.read(webViewNotifierProvider.notifier).onPageStarted(url);
  }

  /// ページ読み込み完了時の処理
  Future<void> _onPageFinished(String url) async {
    ref.read(webViewNotifierProvider.notifier).onPageFinished(url);

    // ナビゲーション状態を更新
    final canGoBack = await _controller.canGoBack();
    final canGoForward = await _controller.canGoForward();
    ref.read(webViewNotifierProvider.notifier).updateNavigationState(
          canGoBack: canGoBack,
          canGoForward: canGoForward,
        );

    // Issue #10: 小説ページ検出と自動抽出
    ref.read(webViewNotifierProvider.notifier).checkNovelPage(url);
    final webViewState = ref.read(webViewNotifierProvider);

    if (webViewState.isNovelPage) {
      // 小説ページの場合、自動的にコンテンツを抽出
      await ref.read(novelReaderNotifierProvider.notifier).loadNovelFromController(
            _controller,
            url,
          );
    } else {
      // 小説ページでない場合、コンテンツをクリア
      ref.read(novelReaderNotifierProvider.notifier).clearContent();
    }
  }

  /// エラー発生時の処理
  void _onError(WebResourceError error) {
    ref.read(webViewNotifierProvider.notifier).onError(error.description);
  }

  @override
  Widget build(BuildContext context) {
    final webViewState = ref.watch(webViewNotifierProvider);

    // Issue #11: PlaybackControllerNotifier に WebViewController を設定
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(playbackControllerNotifierProvider.notifier)
          .setWebViewController(_controller);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('よみあげRun'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // 将来: 設定ボタン
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: 設定画面へ遷移
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ローディングインジケーター
          if (webViewState.isLoading) const LinearProgressIndicator(),

          // WebView（全画面）
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),

          // 読み上げ速度設定
          const SpeedSettings(),

          // 再生コントローラー
          const PlaybackController(),
        ],
      ),
    );
  }
}
