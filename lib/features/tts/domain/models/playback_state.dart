import 'package:freezed_annotation/freezed_annotation.dart';

part 'playback_state.freezed.dart';

/// 再生状態を表すモデル
///
/// TTS の再生/一時停止/停止状態と、現在の再生位置を管理します。
@freezed
class PlaybackState with _$PlaybackState {
  const factory PlaybackState({
    /// 再生中かどうか
    @Default(false) bool isPlaying,

    /// 現在の再生位置（段落のインデックス）
    @Default(0) int currentPosition,

    /// 全体の長さ（段落の総数）
    @Default(0) int totalLength,

    /// 現在再生中のテキスト
    String? currentText,
  }) = _PlaybackState;
}
