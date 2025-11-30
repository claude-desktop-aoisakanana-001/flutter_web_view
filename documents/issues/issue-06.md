# Phase 2: 読み上げ速度設定UI

**ラベル**: `phase-2`, `priority-medium`
**見積もり**: 1.5時間
**依存**: Issue #5

---

## 概要
読み上げ速度を調整するUIを作成する。

## タスク
- [ ] `SpeedSettings` ウィジェットを作成
  - Slider を使用
  - 0.5倍速 〜 2.0倍速の範囲
  - 現在の速度を表示
- [ ] `SpeedSettingsNotifier` を作成（Riverpod使用）
  - 速度の状態管理
  - TtsService への速度反映
- [ ] UI配置
  - NovelReaderScreen に統合
  - 折りたたみ可能なパネルまたはボトムシート
- [ ] ウィジェットテストを作成

## 成功基準
- [ ] スライダーで速度を変更できる
- [ ] 変更がリアルタイムで反映される
- [ ] ウィジェットテストが成功
- [ ] `flutter analyze` でエラーなし

## 参考資料
- [architecture.md](../architecture.md)
- [issue-plan.md](../issue-plan.md)
