# Phase 2: 再生コントローラーUI

**ラベル**: `phase-2`, `priority-high`
**見積もり**: 2時間
**依存**: Issue #5

---

## 概要
再生/一時停止/停止のコントロールUIを作成する。

## タスク
- [ ] `PlaybackState` モデルを作成（Freezed使用）
  ```dart
  @freezed
  class PlaybackState with _$PlaybackState {
    const factory PlaybackState({
      @Default(false) bool isPlaying,
      @Default(0) int currentPosition,
      @Default(0) int totalLength,
      String? currentText,
    }) = _PlaybackState;
  }
  ```
- [ ] `PlaybackController` ウィジェットを作成
  - 再生ボタン（Icons.play_arrow）
  - 一時停止ボタン（Icons.pause）
  - 停止ボタン（Icons.stop）
  - 現在の再生状態表示
  - ボタンの有効/無効制御
- [ ] `PlaybackControllerNotifier` を作成（Riverpod使用）
  - 再生状態の管理
  - TtsService の呼び出し
- [ ] UI配置
  - 画面下部に固定配置
  - FloatingActionButton または BottomAppBar
- [ ] ウィジェットテストを作成

## 成功基準
- [ ] 再生/一時停止/停止が動作する
- [ ] ボタンの状態が適切に切り替わる
- [ ] ウィジェットテストが成功
- [ ] `flutter analyze` でエラーなし

## 参考資料
- [architecture.md](../architecture.md)
- [issue-plan.md](../issue-plan.md)
