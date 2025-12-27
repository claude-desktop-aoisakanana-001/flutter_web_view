import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yomiagerun_app/features/tts/domain/models/tts_config.dart';

part 'tts_state.freezed.dart';

/// TTS サービスの状態
///
/// TTS の初期化状態、設定、エラーメッセージを管理。
@freezed
class TTSState with _$TTSState {
  const factory TTSState({
    /// TTS が初期化済みかどうか
    @Default(false) bool isInitialized,

    /// TTS の設定
    TTSConfig? config,

    /// エラーメッセージ（エラーがない場合は null）
    String? errorMessage,
  }) = _TTSState;
}
