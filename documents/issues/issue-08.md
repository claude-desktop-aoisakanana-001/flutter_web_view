# Phase 3: 小説本文表示UIとデータ統合

**ラベル**: `phase-3`, `priority-high`
**見積もり**: 2.5時間
**依存**: Issue #3, Issue #4

---

## 概要
HTML解析で取得した小説データを画面に表示する機能を実装する。

## タスク
- [ ] `NovelContent` モデルを作成（Freezed使用）
  ```dart
  @freezed
  class NovelContent with _$NovelContent {
    const factory NovelContent({
      required String title,
      required String author,
      required String url,
      required List<String> paragraphs,
      DateTime? fetchedAt,
    }) = _NovelContent;

    factory NovelContent.fromJson(Map<String, dynamic> json)
        => _$NovelContentFromJson(json);
  }
  ```
- [ ] `NovelReaderState` モデルを作成
  ```dart
  @freezed
  class NovelReaderState with _$NovelReaderState {
    const factory NovelReaderState({
      NovelContent? novelContent,
      @Default(false) bool isLoading,
      String? errorMessage,
      @Default(0) int currentHighlightPosition,
    }) = _NovelReaderState;
  }
  ```
- [ ] `NovelReaderNotifier` を実装（Riverpod使用）
  - `loadNovel(String url)` メソッド
  - NarouParserService を使用してデータ取得
  - エラーハンドリング
- [ ] `NovelContentView` ウィジェットを作成
  - タイトル表示
  - 作者名表示
  - 本文表示（段落ごと）
  - スクロール可能
  - ローディング表示
  - エラー表示
- [ ] URL入力UIを追加
  - TextField でURL入力
  - 読み込みボタン
- [ ] ユニットテストとウィジェットテストを作成

## 成功基準
- [ ] URLから小説を読み込んで表示できる
- [ ] ローディング・エラー状態が適切に表示される
- [ ] テストが成功
- [ ] `flutter analyze` でエラーなし

## 参考資料
- [architecture.md](../architecture.md)
- [issue-plan.md](../issue-plan.md)
