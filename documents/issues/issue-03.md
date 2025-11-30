# Phase 1: HTML解析機能の実装

**ラベル**: `phase-1`, `priority-high`
**見積もり**: 2時間
**依存**: Issue #2

---

## 概要
Issue #2で特定したセレクタを使用して、小説家になろうのHTMLから本文を抽出する機能を実装する。

## タスク
- [ ] `ParsedNovel` モデルを作成（Freezed使用）
  ```dart
  @freezed
  class ParsedNovel with _$ParsedNovel {
    const factory ParsedNovel({
      required String title,
      required String author,
      required List<String> paragraphs,
      Map<String, String>? metadata,
    }) = _ParsedNovel;
  }
  ```
- [ ] `NarouParserService` を実装（Riverpod使用）
  - `parseFromUrl(String url)` メソッド
  - HTTP GET → HTML取得
  - htmlパッケージでパース
  - セレクタで要素を抽出
  - ルビの処理
- [ ] エラーハンドリング
  - ネットワークエラー
  - パースエラー（想定外のHTML構造）
- [ ] ユニットテストを作成
  - サンプルHTMLでのパーステスト
  - エラーハンドリングのテスト
- [ ] コード生成を実行（`dart run build_runner build`）

## 成功基準
- [ ] サンプル小説URLから正しく本文を抽出できる
- [ ] ルビが適切に処理されている
- [ ] ユニットテストが成功
- [ ] `flutter analyze` でエラーなし

## 参考資料
- [architecture.md](../architecture.md)
- [narou-html-analysis.md](../narou-html-analysis.md)（Issue #2で作成）
- [issue-plan.md](../issue-plan.md)
