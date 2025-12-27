import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yomiagerun_app/features/tts/application/tts_service.dart';
import 'package:yomiagerun_app/features/tts/domain/models/playback_state.dart';

part 'playback_controller_notifier.g.dart';

/// 再生コントローラーの状態を管理する Notifier
///
/// TtsService と連携して再生/一時停止/停止を制御します。
@riverpod
class PlaybackControllerNotifier extends _$PlaybackControllerNotifier {
  @override
  PlaybackState build() {
    return const PlaybackState();
  }

  /// 再生を開始
  ///
  /// [text] 読み上げるテキスト
  Future<void> play(String text) async {
    if (text.isEmpty) {
      return;
    }

    try {
      final ttsNotifier = ref.read(ttsServiceNotifierProvider.notifier);
      await ttsNotifier.speak(text);

      state = state.copyWith(
        isPlaying: true,
        currentText: text,
      );
    } catch (e) {
      // エラーハンドリング
      state = state.copyWith(isPlaying: false);
      rethrow;
    }
  }

  /// 一時停止
  Future<void> pause() async {
    try {
      final ttsNotifier = ref.read(ttsServiceNotifierProvider.notifier);
      await ttsNotifier.pause();

      state = state.copyWith(isPlaying: false);
    } catch (e) {
      rethrow;
    }
  }

  /// 停止
  Future<void> stop() async {
    try {
      final ttsNotifier = ref.read(ttsServiceNotifierProvider.notifier);
      await ttsNotifier.stop();

      state = state.copyWith(
        isPlaying: false,
        currentPosition: 0,
        currentText: null,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// 再生位置を設定
  ///
  /// [position] 新しい再生位置（段落のインデックス）
  void setPosition(int position) {
    state = state.copyWith(currentPosition: position);
  }

  /// 全体の長さを設定
  ///
  /// [length] 段落の総数
  void setTotalLength(int length) {
    state = state.copyWith(totalLength: length);
  }
}
