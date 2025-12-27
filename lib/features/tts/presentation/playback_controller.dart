import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller_notifier.dart';

/// 再生コントローラーウィジェット
///
/// 再生/一時停止/停止ボタンを提供します。
class PlaybackController extends ConsumerWidget {
  const PlaybackController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackState = ref.watch(playbackControllerNotifierProvider);
    final notifier = ref.read(playbackControllerNotifierProvider.notifier);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 再生状態表示
            Text(
              playbackState.isPlaying ? '再生中' : '停止中',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: playbackState.isPlaying
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 16),

            // コントロールボタン
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 再生ボタン
                IconButton.filled(
                  onPressed: playbackState.isPlaying
                      ? null
                      : () {
                          // テスト用のサンプルテキスト
                          // 実際の使用時は小説のテキストを渡す
                          notifier.play('これはテスト用のテキストです。');
                        },
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 32,
                  tooltip: '再生',
                ),

                // 一時停止ボタン
                IconButton.filled(
                  onPressed: playbackState.isPlaying
                      ? () => notifier.pause()
                      : null,
                  icon: const Icon(Icons.pause),
                  iconSize: 32,
                  tooltip: '一時停止',
                ),

                // 停止ボタン
                IconButton.filled(
                  onPressed: playbackState.isPlaying ||
                          playbackState.currentPosition > 0
                      ? () => notifier.stop()
                      : null,
                  icon: const Icon(Icons.stop),
                  iconSize: 32,
                  tooltip: '停止',
                ),
              ],
            ),

            // 現在のテキスト表示（再生中のみ）
            if (playbackState.currentText != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  playbackState.currentText!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
