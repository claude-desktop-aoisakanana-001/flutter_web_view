import 'package:flutter/material.dart';
import 'package:yomiagerun_app/features/tts/presentation/speed_settings.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller.dart';

/// 小説閲覧画面
///
/// WebView を使用して「小説家になろう」の小説を閲覧します。
/// 将来的には読み上げ機能や設定画面へのナビゲーションを含みます。
class NovelReaderScreen extends StatefulWidget {
  const NovelReaderScreen({super.key});

  @override
  State<NovelReaderScreen> createState() => _NovelReaderScreenState();
}

class _NovelReaderScreenState extends State<NovelReaderScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // プレースホルダーコンテンツ
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    Icons.auto_stories,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'よみあげRun',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '小説閲覧画面（準備中）',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'WebView 統合は Issue #8 で実装予定',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
            ),

            // 読み上げ速度設定
            const SpeedSettings(),

            // 再生コントローラー
            const PlaybackController(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Issue #5 で URL 入力ダイアログを実装
        },
        tooltip: 'URL を入力',
        child: const Icon(Icons.add),
      ),
    );
  }
}
