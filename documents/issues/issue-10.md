# Phase 3: 読み上げ位置の自動スクロール機能

**ラベル**: `phase-3`, `priority-high`, `feature`
**見積もり**: 2時間
**依存**: Issue #9

---

## 概要
読み上げ位置が画面外に出ないように自動的にスクロールする機能を実装する。

## タスク
- [ ] NovelContentView に ScrollController を追加
- [ ] 読み上げ位置の変更を監視
  - `ref.listen` で currentHighlightPosition を監視
- [ ] スクロール位置の計算ロジック
  - ハイライト位置の画面上の座標を取得
  - 画面外に出る前にスクロール開始
  - 適切なオフセットを計算
- [ ] スムーズなスクロールアニメーション
  - `animateTo()` を使用
  - duration: 300ms
  - curve: Curves.easeOut
- [ ] ユーザーによる手動スクロールの検出
  - 手動スクロール中は自動スクロールを一時停止
  - 読み上げが進んだら再開
- [ ] ウィジェットテストを作成

## 成功基準
- [ ] 読み上げ位置が常に画面内に表示される
- [ ] スムーズにスクロールする
- [ ] 手動スクロールが優先される
- [ ] ウィジェットテストが成功
- [ ] `flutter analyze` でエラーなし

## 参考資料
- [architecture.md](../architecture.md)
- [mvp-requirements.md](../mvp-requirements.md)
- [issue-plan.md](../issue-plan.md)
