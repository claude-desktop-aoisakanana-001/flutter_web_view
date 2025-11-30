# Phase 3: 読み上げ位置のハイライト表示機能

**ラベル**: `phase-3`, `priority-high`, `feature`
**見積もり**: 2.5時間
**依存**: Issue #5, Issue #8

---

## 概要
現在読み上げ中の文章をハイライト表示する機能を実装する。

## タスク
- [ ] TtsService に読み上げ位置コールバックを追加
  - `setProgressHandler()` を実装
  - 現在読み上げ中のテキストと位置を通知
- [ ] NovelReaderNotifier に位置更新機能を追加
  - `updateHighlightPosition(int position, String text)` メソッド
  - currentHighlightPosition の更新
- [ ] NovelContentView でハイライト表示を実装
  - RichText + TextSpan を使用
  - 現在読み上げ中の段落/文章を識別
  - 背景色を変更（例: 黄色のハイライト）
  - テキストスタイルの調整
- [ ] ハイライトのスムーズな切り替え
- [ ] ウィジェットテストを作成
  - ハイライト位置の変更を確認

## 成功基準
- [ ] 読み上げ中の文章がハイライト表示される
- [ ] ハイライトが読み上げ位置に追従する
- [ ] ウィジェットテストが成功
- [ ] `flutter analyze` でエラーなし

## 参考資料
- [architecture.md](../architecture.md)
- [mvp-requirements.md](../mvp-requirements.md)
- [issue-plan.md](../issue-plan.md)
