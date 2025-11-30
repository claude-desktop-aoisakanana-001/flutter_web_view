# Phase 1: 基本的なアプリ構造とルーティング設定

**ラベル**: `phase-1`, `priority-high`
**見積もり**: 1.5時間
**依存**: Issue #1

---

## 概要
アプリのエントリーポイントと基本的な画面構成を作成する。

## タスク
- [ ] `lib/app/app.dart` を作成
  - MaterialApp の設定
  - テーマ設定
  - ProviderScope の設定
- [ ] `lib/main.dart` を更新
  - ProviderScope でアプリをラップ
- [ ] `NovelReaderScreen` のスケルトンを作成
  - 基本的な Scaffold
  - AppBar
  - 後で実装する部分はプレースホルダー
- [ ] 動作確認（アプリが起動すること）

## 成功基準
- [ ] アプリが正常に起動する
- [ ] NovelReaderScreen が表示される
- [ ] `flutter analyze` でエラーなし

## 参考資料
- [architecture.md](../architecture.md)
- [tech-selection.md](../tech-selection.md)
- [issue-plan.md](../issue-plan.md)
