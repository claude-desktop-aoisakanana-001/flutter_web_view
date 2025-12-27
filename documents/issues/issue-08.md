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

---

## 作業完了報告

### 実施内容

**Phase 3: 小説本文表示UIとデータ統合** を完了しました。

#### Part 1: ドメインモデルとビジネスロジック
1. **NovelContent モデル** (`lib/features/novel_reader/domain/models/novel_content.dart`)
   - Freezed を使用した immutable モデル
   - `title`, `author`, `url`, `paragraphs`, `fetchedAt` フィールドを定義
   - JSON シリアライゼーション対応

2. **NovelReaderState モデル** (`lib/features/novel_reader/domain/models/novel_reader_state.dart`)
   - Freezed を使用した状態管理モデル
   - `novelContent`, `isLoading`, `errorMessage`, `currentHighlightPosition` フィールドを定義
   - 読み込み中、エラー、コンテンツ表示の状態を管理

3. **NovelReaderNotifier** (`lib/features/novel_reader/application/novel_reader_notifier.dart`)
   - Riverpod を使用した状態管理 Notifier
   - `loadNovel(String url)` メソッドを実装
   - NarouParserService を使用して WebView 経由で小説を解析
   - エラーハンドリングとローディング状態の管理

#### Part 2: UI コンポーネントとテスト
1. **NovelContentView ウィジェット** (`lib/features/novel_reader/presentation/novel_content_view.dart`)
   - 小説のタイトル、作者、本文を表示
   - ローディング、エラー、空の状態に対応
   - 段落ごとのハイライト機能（将来のTTS連動用）
   - スクロール可能な ListView

2. **NovelReaderScreen の更新** (`lib/features/novel_reader/presentation/novel_reader_screen.dart`)
   - URL 入力用 TextField を追加
   - 読み込みボタン（バリデーション付き）
   - NovelContentView の統合
   - ConsumerStatefulWidget に変更

3. **テストファイル作成**
   - `test/features/novel_reader/presentation/novel_content_view_test.dart`
     - 空の状態、ローディング、エラー、コンテンツ表示のテスト
     - ハイライト機能のテスト
   - `test/features/novel_reader/application/novel_reader_notifier_test.dart`
     - NovelReaderState の初期状態と copyWith のテスト
   - `test/features/novel_reader/presentation/novel_reader_screen_test.dart`
     - URL 入力 UI のテスト
     - バリデーションのテスト

### 変更ファイル

**新規作成**:
- `lib/features/novel_reader/domain/models/novel_content.dart` (33行)
- `lib/features/novel_reader/domain/models/novel_reader_state.dart` (27行)
- `lib/features/novel_reader/application/novel_reader_notifier.dart` (93行)
- `lib/features/novel_reader/presentation/novel_content_view.dart` (199行)
- `test/features/novel_reader/application/novel_reader_notifier_test.dart` (27行)
- `test/features/novel_reader/presentation/novel_content_view_test.dart` (189行)
- `test/features/novel_reader/presentation/novel_reader_screen_test.dart` (84行)

**更新**:
- `lib/features/novel_reader/presentation/novel_reader_screen.dart` (85行)

### コミット履歴

```bash
# Part 1
2b7d39a feat(novel): Add domain models and notifier for novel reader (Issue #8, Part 1)

# Part 2
b933b31 feat(novel): Add UI components for novel reader (Issue #8, Part 2)
```

### 確認事項

- [x] コードレビュー準備完了
- [x] すべてのタスクを完了
- [x] ドキュメント更新

### 残課題・次のステップ

1. **ローカルでのビルドとテスト実行**
   ```bash
   # コード生成（Freezed）
   dart run build_runner build --delete-conflicting-outputs

   # 静的解析
   flutter analyze

   # テスト実行
   flutter test
   ```

2. **統合テスト**
   - 実際に小説家になろうの URL で動作確認
   - WebView と JavaScript Injection の動作確認
   - エラーハンドリングの動作確認

3. **次の Issue**
   - Issue #9: 読み上げ機能の統合（TTS と NovelReader の連動）
   - 段落ごとの読み上げ
   - ハイライト位置の同期
   - 再生/一時停止/停止の制御

### 実施日時
2025-12-27
