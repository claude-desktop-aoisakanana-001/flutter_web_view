import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yomiagerun_app/features/tts/domain/models/tts_config.dart';
import 'package:yomiagerun_app/features/tts/domain/models/tts_state.dart';

part 'tts_service.g.dart';

/// TTS サービス例外
class TtsServiceException implements Exception {
  final String message;
  TtsServiceException(this.message);

  @override
  String toString() => 'TtsServiceException: $message';
}

/// TTS サービスの状態を管理する Provider
@riverpod
class TtsServiceNotifier extends _$TtsServiceNotifier {
  late FlutterTts _flutterTts;

  @override
  TTSState build() {
    _flutterTts = FlutterTts();
    _initializeTts();
    return const TTSState();
  }

  /// TTS を初期化
  Future<void> _initializeTts() async {
    try {
      // 日本語音声を設定
      await _flutterTts.setLanguage('ja-JP');

      // デフォルト設定を適用
      final defaultConfig = const TTSConfig();
      await _flutterTts.setSpeechRate(defaultConfig.speed);
      await _flutterTts.setPitch(defaultConfig.pitch);
      await _flutterTts.setVolume(defaultConfig.volume);

      // コールバックを設定
      _flutterTts.setStartHandler(() {
        // 読み上げ開始時の処理（将来の UI 更新用）
      });

      _flutterTts.setCompletionHandler(() {
        // 読み上げ完了時の処理（将来の UI 更新用）
      });

      _flutterTts.setProgressHandler(
        (String text, int startOffset, int endOffset, String word) {
          // 読み上げ進捗のコールバック（将来のハイライト機能用）
        },
      );

      _flutterTts.setErrorHandler((msg) {
        state = state.copyWith(
          errorMessage: 'TTS エラー: $msg',
        );
      });

      // 初期化完了
      state = state.copyWith(
        isInitialized: true,
        config: defaultConfig,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isInitialized: false,
        errorMessage: 'TTS の初期化に失敗しました: $e',
      );
      throw TtsServiceException('TTS の初期化に失敗しました: $e');
    }
  }

  /// テキストを読み上げる
  ///
  /// [text] 読み上げるテキスト
  ///
  /// 例外が発生した場合は [TtsServiceException] をスロー。
  Future<void> speak(String text) async {
    if (!state.isInitialized) {
      throw TtsServiceException('TTS が初期化されていません');
    }

    if (text.isEmpty) {
      throw TtsServiceException('読み上げるテキストが空です');
    }

    try {
      await _flutterTts.speak(text);
      state = state.copyWith(errorMessage: null);
    } catch (e) {
      final errorMsg = 'テキストの読み上げに失敗しました: $e';
      state = state.copyWith(errorMessage: errorMsg);
      throw TtsServiceException(errorMsg);
    }
  }

  /// 読み上げを一時停止
  ///
  /// 例外が発生した場合は [TtsServiceException] をスロー。
  Future<void> pause() async {
    if (!state.isInitialized) {
      throw TtsServiceException('TTS が初期化されていません');
    }

    try {
      await _flutterTts.pause();
      state = state.copyWith(errorMessage: null);
    } catch (e) {
      final errorMsg = '一時停止に失敗しました: $e';
      state = state.copyWith(errorMessage: errorMsg);
      throw TtsServiceException(errorMsg);
    }
  }

  /// 読み上げを停止
  ///
  /// 例外が発生した場合は [TtsServiceException] をスロー。
  Future<void> stop() async {
    if (!state.isInitialized) {
      throw TtsServiceException('TTS が初期化されていません');
    }

    try {
      await _flutterTts.stop();
      state = state.copyWith(errorMessage: null);
    } catch (e) {
      final errorMsg = '停止に失敗しました: $e';
      state = state.copyWith(errorMessage: errorMsg);
      throw TtsServiceException(errorMsg);
    }
  }

  /// 読み上げ速度を設定
  ///
  /// [speed] 読み上げ速度（0.5 〜 2.0）
  ///   - 1.0: 通常速度
  ///   - 0.5: 半分の速度
  ///   - 2.0: 倍速
  ///
  /// 例外が発生した場合は [TtsServiceException] をスロー。
  Future<void> setSpeed(double speed) async {
    if (!state.isInitialized) {
      throw TtsServiceException('TTS が初期化されていません');
    }

    if (speed < 0.5 || speed > 2.0) {
      throw TtsServiceException('速度は 0.5 〜 2.0 の範囲で指定してください');
    }

    try {
      await _flutterTts.setSpeechRate(speed);
      final updatedConfig = (state.config ?? const TTSConfig()).copyWith(
        speed: speed,
      );
      state = state.copyWith(
        config: updatedConfig,
        errorMessage: null,
      );
    } catch (e) {
      final errorMsg = '速度の設定に失敗しました: $e';
      state = state.copyWith(errorMessage: errorMsg);
      throw TtsServiceException(errorMsg);
    }
  }

  /// TTS 設定を一括で適用
  ///
  /// [config] 適用する TTS 設定
  ///
  /// MVP では speed のみ使用。
  /// 将来的には pitch, volume, linePause, paragraphPause も対応予定。
  ///
  /// 例外が発生した場合は [TtsServiceException] をスロー。
  Future<void> setConfig(TTSConfig config) async {
    if (!state.isInitialized) {
      throw TtsServiceException('TTS が初期化されていません');
    }

    try {
      // MVP では speed のみ適用
      await _flutterTts.setSpeechRate(config.speed);

      // 将来対応予定のパラメータ（現在は設定のみ保存）
      // await _flutterTts.setPitch(config.pitch);
      // await _flutterTts.setVolume(config.volume);

      state = state.copyWith(
        config: config,
        errorMessage: null,
      );
    } catch (e) {
      final errorMsg = '設定の適用に失敗しました: $e';
      state = state.copyWith(errorMessage: errorMsg);
      throw TtsServiceException(errorMsg);
    }
  }

  /// リソースを解放（dispose 時に呼ばれる）
  Future<void> dispose() async {
    await _flutterTts.stop();
  }
}
