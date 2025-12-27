import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yomiagerun_app/features/novel_reader/application/novel_reader_notifier.dart';
import 'package:yomiagerun_app/features/novel_reader/presentation/novel_content_view.dart';
import 'package:yomiagerun_app/features/tts/presentation/speed_settings.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller.dart';

/// 小説閲覧画面
///
/// WebView を使用して「小説家になろう」の小説を閲覧します。
/// 将来的には読み上げ機能や設定画面へのナビゲーションを含みます。
class NovelReaderScreen extends ConsumerStatefulWidget {
  const NovelReaderScreen({super.key});

  @override
  ConsumerState<NovelReaderScreen> createState() => _NovelReaderScreenState();
}

class _NovelReaderScreenState extends ConsumerState<NovelReaderScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  /// URL を読み込む
  Future<void> _loadUrl() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('URLを入力してください')),
      );
      return;
    }

    final notifier = ref.read(novelReaderNotifierProvider.notifier);
    await notifier.loadNovel(url);
  }

  @override
  Widget build(BuildContext context) {
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
          // URL入力欄
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        hintText: '小説のURLを入力',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.link),
                      ),
                      onSubmitted: (_) => _loadUrl(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: _loadUrl,
                    icon: const Icon(Icons.download),
                    label: const Text('読み込み'),
                  ),
                ],
              ),
            ),
          ),

          // 小説コンテンツ表示
          const Expanded(
            child: NovelContentView(),
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
