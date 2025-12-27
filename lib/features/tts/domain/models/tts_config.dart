import 'package:freezed_annotation/freezed_annotation.dart';

part 'tts_config.freezed.dart';
part 'tts_config.g.dart';

/// TTS（Text-to-Speech）の設定
///
/// MVP では speed のみ使用。
/// 他のパラメータは将来の拡張性を担保するために定義。
@freezed
class TTSConfig with _$TTSConfig {
  const factory TTSConfig({
    /// 読み上げ速度（0.5 〜 2.0）
    /// - 1.0: 通常速度
    /// - 0.5: 半分の速度（ゆっくり）
    /// - 2.0: 倍速
    @Default(1.0) double speed,

    /// 音程（0.5 〜 2.0）
    /// ※ 将来対応
    @Default(1.0) double pitch,

    /// 音量（0.0 〜 1.0）
    /// ※ 将来対応
    @Default(1.0) double volume,

    /// 行間の間隔（秒）
    /// ※ 将来対応
    @Default(0.0) double linePause,

    /// 段落間の間隔（秒）
    /// ※ 将来対応
    @Default(0.0) double paragraphPause,
  }) = _TTSConfig;

  factory TTSConfig.fromJson(Map<String, dynamic> json) =>
      _$TTSConfigFromJson(json);
}
