import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yomiagerun_app/features/tts/application/tts_service.dart';

part 'speed_settings_notifier.g.dart';

/// 読み上げ速度設定の状態を管理する Notifier
///
/// TtsService と連携して速度設定を管理します。
@riverpod
class SpeedSettingsNotifier extends _$SpeedSettingsNotifier {
  @override
  double build() {
    // デフォルトは 1.0（通常速度）
    return 1.0;
  }

  /// 速度を設定
  ///
  /// [speed] 読み上げ速度（0.5〜2.0）
  ///
  /// TtsService に速度を反映し、状態を更新します。
  Future<void> setSpeed(double speed) async {
    // 範囲チェック
    if (speed < 0.5 || speed > 2.0) {
      throw ArgumentError('速度は 0.5 〜 2.0 の範囲で指定してください');
    }

    // TtsService に速度を設定
    final ttsNotifier = ref.read(ttsServiceNotifierProvider.notifier);
    await ttsNotifier.setSpeed(speed);

    // 状態を更新
    state = speed;
  }

  /// 速度をリセット（1.0 に戻す）
  Future<void> resetSpeed() async {
    await setSpeed(1.0);
  }
}
