# Phase 2: TTS基本機能の実装

**ラベル**: `phase-2`, `priority-high`
**見積もり**: 2.5時間
**依存**: Issue #1

---

## 概要
flutter_tts を使用した基本的な読み上げ機能を実装する。

## タスク
- [ ] `TTSConfig` モデルを作成（Freezed使用）
  ```dart
  @freezed
  class TTSConfig with _$TTSConfig {
    const factory TTSConfig({
      @Default(1.0) double speed,           // 読み上げ速度（MVP）
      @Default(1.0) double pitch,           // 音程（将来対応）
      @Default(1.0) double volume,          // 音量（将来対応）
      @Default(0.0) double linePause,       // 行間の間隔（将来対応）
      @Default(0.0) double paragraphPause,  // 段落間の間隔（将来対応）
    }) = _TTSConfig;

    factory TTSConfig.fromJson(Map<String, dynamic> json)
        => _$TTSConfigFromJson(json);
  }
  ```
  - **注**: MVP では speed のみ使用、他は将来の拡張性を担保
- [ ] `TTSState` モデルを作成
  ```dart
  @freezed
  class TTSState with _$TTSState {
    const factory TTSState({
      @Default(false) bool isInitialized,
      TTSConfig? config,
      String? errorMessage,
    }) = _TTSState;
  }
  ```
- [ ] `TtsService` を実装（Riverpod使用）
  - flutter_tts の初期化
  - `speak(String text)` メソッド
  - `pause()` メソッド
  - `stop()` メソッド
  - `setSpeed(double speed)` メソッド
  - `setConfig(TTSConfig config)` メソッド（将来の拡張用）
  - 読み上げ位置のコールバック設定
- [ ] 日本語音声の設定
- [ ] エラーハンドリング
- [ ] ユニットテストを作成
- [ ] コード生成を実行

## 成功基準
- [ ] テキストを読み上げできる
- [ ] 一時停止・停止が動作する
- [ ] 速度設定が反映される
- [ ] ユニットテストが成功
- [ ] `flutter analyze` でエラーなし

## 参考資料
- [tech-selection.md](../tech-selection.md)
- [architecture.md](../architecture.md)
- [issue-plan.md](../issue-plan.md)
