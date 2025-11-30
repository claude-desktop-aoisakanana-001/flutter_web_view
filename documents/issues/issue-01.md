# Phase 1: プロジェクトセットアップと依存関係追加

**ラベル**: `phase-1`, `priority-high`
**見積もり**: 1時間
**依存**: なし

---

## 概要
必要なパッケージをインストールし、基本的なディレクトリ構造を作成する。

## タスク
- [ ] pubspec.yaml に依存パッケージを追加
  - flutter_riverpod, riverpod_annotation, riverpod_generator
  - flutter_tts
  - http, html
  - freezed, freezed_annotation, build_runner
- [ ] `flutter pub get` を実行
- [ ] ディレクトリ構造を作成
  ```
  lib/
  ├── app/
  ├── features/
  │   ├── novel_reader/
  │   ├── tts/
  │   └── html_parser/
  └── shared/
  ```
- [ ] analysis_options.yaml でLintルールを確認
- [ ] 動作確認（flutter analyze が成功すること）

## 成功基準
- [ ] `flutter pub get` が成功
- [ ] `flutter analyze` でエラーなし
- [ ] ディレクトリ構造が正しく作成されている

## 参考資料
- [tech-selection.md](../tech-selection.md)
- [architecture.md](../architecture.md)
- [issue-plan.md](../issue-plan.md)
