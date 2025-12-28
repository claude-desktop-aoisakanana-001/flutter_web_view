import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yomiagerun_app/features/tts/presentation/playback_controller_notifier.dart';
import 'package:yomiagerun_app/features/novel_reader/application/webview_notifier.dart';
import 'package:yomiagerun_app/features/novel_reader/application/novel_reader_notifier.dart';

/// 再生コントローラーウィジェット
///
/// 再生/一時停止/停止ボタンを提供します。
/// Issue #10: 小説ページでのみ有効化されます。
class PlaybackController extends ConsumerWidget {
  const PlaybackController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackState = ref.watch(playbackControllerNotifierProvider);
    final notifier = ref.read(playbackControllerNotifierProvider.notifier);

    // Issue #10: 小説ページかどうかを判定
    final webViewState = ref.watch(webViewNotifierProvider);
    final novelReaderState = ref.watch(novelReaderNotifierProvider);
    final isNovelPageWithContent = webViewState.isNovelPage &&
                                   novelReaderState.novelContent != null;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 再生状態表示（Issue #10: 有効/無効状態も表示）
            Text(
              !isNovelPageWithContent
                  ? '小説ページで有効化されます'
                  : (playbackState.isPlaying ? '再生中' : '停止中'),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: !isNovelPageWithContent
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : (playbackState.isPlaying
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface),
                  ),
            ),
            const SizedBox(height: 16),

            // コントロールボタン（Issue #10: 小説ページでのみ有効）
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 再生ボタン
                IconButton.filled(
                  onPressed: (!isNovelPageWithContent || playbackState.isPlaying)
                      ? null
                      : () {
                          // Issue #10: 小説コンテンツ全体を順次再生
                          notifier.play();
                        },
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 32,
                  tooltip: '再生',
                ),

                // 一時停止ボタン
                IconButton.filled(
                  onPressed: (!isNovelPageWithContent || !playbackState.isPlaying)
                      ? null
                      : () => notifier.pause(),
                  icon: const Icon(Icons.pause),
                  iconSize: 32,
                  tooltip: '一時停止',
                ),

                // 停止ボタン
                IconButton.filled(
                  onPressed: (!isNovelPageWithContent ||
                          (!playbackState.isPlaying &&
                              playbackState.currentPosition == 0))
                      ? null
                      : () => notifier.stop(),
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
