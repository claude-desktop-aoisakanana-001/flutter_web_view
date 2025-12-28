import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yomiagerun_app/features/novel_reader/application/novel_reader_notifier.dart';
// import 'package:yomiagerun_app/features/novel_reader/presentation/novel_content_view.dart';
import 'package:yomiagerun_app/features/novel_reader/application/webview_notifier.dart';
import 'package:yomiagerun_app/features/tts/presentation/speed_settings.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller.dart';

/// 小説閲覧画面
///
/// WebView を使用して「小説家になろう」のサイトをブラウザとして表示します。
/// Issue #9: WebView ベースのブラウザ実装
class NovelReaderScreen extends ConsumerStatefulWidget {
  const NovelReaderScreen({super.key});

  @override
  ConsumerState<NovelReaderScreen> createState() => _NovelReaderScreenState();
}

class _NovelReaderScreenState extends ConsumerState<NovelReaderScreen> {
  late final WebViewController _controller;

  // コメントアウト: Issue #9 - URL入力UIは使用しない
  // final TextEditingController _urlController = TextEditingController();

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
    // コメントアウト: Issue #9 - URL入力UIは使用しない
    // _urlController.dispose();
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

  // コメントアウト: Issue #9 - URL入力UIは使用しない
  // /// URL を読み込む
  // Future<void> _loadUrl() async {
  //   final url = _urlController.text.trim();
  //   if (url.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('URLを入力してください')),
  //     );
  //     return;
  //   }
  //
  //   final notifier = ref.read(novelReaderNotifierProvider.notifier);
  //   await notifier.loadNovel(url);
  // }

  @override
  Widget build(BuildContext context) {
    final webViewState = ref.watch(webViewNotifierProvider);

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

          // コメントアウト: Issue #9 - URL入力UIは使用しない
          // // URL入力欄
          // Card(
          //   margin: const EdgeInsets.all(16),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: TextField(
          //             controller: _urlController,
          //             decoration: const InputDecoration(
          //               hintText: '小説のURLを入力',
          //               border: InputBorder.none,
          //               prefixIcon: Icon(Icons.link),
          //             ),
          //             onSubmitted: (_) => _loadUrl(),
          //           ),
          //         ),
          //         const SizedBox(width: 8),
          //         FilledButton.icon(
          //           onPressed: _loadUrl,
          //           icon: const Icon(Icons.download),
          //           label: const Text('読み込み'),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // WebView（全画面）
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),

          // コメントアウト: Issue #9 - NovelContentViewは使用しない（Issue #11で削除）
          // // 小説コンテンツ表示
          // const Expanded(
          //   child: NovelContentView(),
          // ),

          // 読み上げ速度設定
          const SpeedSettings(),

          // 再生コントローラー
          const PlaybackController(),
        ],
      ),
    );
  }
}
