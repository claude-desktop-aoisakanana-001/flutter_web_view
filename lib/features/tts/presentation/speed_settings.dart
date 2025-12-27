import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yomiagerun_app/features/tts/presentation/speed_settings_notifier.dart';

/// 読み上げ速度設定ウィジェット
///
/// Slider を使用して読み上げ速度を調整します。
/// 0.5倍速 〜 2.0倍速の範囲で設定可能。
class SpeedSettings extends ConsumerWidget {
  const SpeedSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speed = ref.watch(speedSettingsNotifierProvider);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '読み上げ速度',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton.icon(
                  onPressed: () {
                    ref
                        .read(speedSettingsNotifierProvider.notifier)
                        .resetSpeed();
                  },
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('リセット'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('0.5x'),
                Expanded(
                  child: Slider(
                    value: speed,
                    min: 0.5,
                    max: 2.0,
                    divisions: 15, // 0.1刻み
                    label: '${speed.toStringAsFixed(1)}x',
                    onChanged: (value) {
                      ref
                          .read(speedSettingsNotifierProvider.notifier)
                          .setSpeed(value);
                    },
                  ),
                ),
                const Text('2.0x'),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '現在の速度: ${speed.toStringAsFixed(1)}x',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
