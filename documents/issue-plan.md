# Issue計画書

**プロジェクト名**: 小説家になろうリーダーアプリ
**バージョン**: 1.0.0
**最終更新**: 2025-11-30
**ステータス**: 承認済み

---

## 1. Issue分割方針

### 1.1 基本方針

- **垂直スライス**: 機能単位で分割（エンドツーエンドで動作する最小単位）
- **依存関係を考慮**: 基盤 → 機能実装 → 統合の順
- **適切な粒度**: 1 Issue = 1〜3時間の作業量を目安
- **テスト込み**: 各Issueにテスト作成を含める

### 1.2 Phase構成

- **Phase 1**: 基盤構築（4 Issues）
- **Phase 2**: TTS機能実装（3 Issues）
- **Phase 3**: UI統合とハイライト機能（3 Issues）
- **Phase 4**: 総合テストと調整（1 Issue）

**合計**: 11 Issues

---

## 2. Phase 1: 基盤構築

### Issue #1: プロジェクトセットアップと依存関係追加

**優先度**: 最高
**見積もり**: 1時間
**依存**: なし

#### 概要
必要なパッケージをインストールし、基本的なディレクトリ構造を作成する。

#### タスク
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

#### 成功基準
- [ ] `flutter pub get` が成功
- [ ] `flutter analyze` でエラーなし
- [ ] ディレクトリ構造が正しく作成されている

---

### Issue #2: 「小説家になろう」HTML構造の調査と解析戦略の策定

**優先度**: 最高
**見積もり**: 2時間
**依存**: Issue #1

#### 概要
「小説家になろう」の実際のHTMLを取得・解析し、本文抽出に必要なセレクタを特定する。

#### タスク
- [ ] サンプル小説URLを選定（テスト用）
- [ ] HTTP GETでHTMLを取得
- [ ] HTML構造を分析
  - 小説タイトルの要素とセレクタ
  - 作者名の要素とセレクタ
  - 本文（段落）の要素とセレクタ
  - ルビ（振り仮名）の扱い方
  - 章タイトルの検出方法
  - 特殊記法（傍点、改行など）の処理
- [ ] 解析結果を `documents/narou-html-analysis.md` にまとめる
  - セレクタ一覧
  - サンプルHTML抜粋
  - パース戦略
- [ ] エッジケースを特定
  - ルビがある場合
  - 特殊記法がある場合
  - 章分割がある場合

#### 成功基準
- [ ] 本文を正しく抽出できるセレクタが特定されている
- [ ] 解析結果ドキュメントが作成されている
- [ ] エッジケースが文書化されている

#### 成果物
- `documents/narou-html-analysis.md`

---

### Issue #3: WebView + JavaScript Injection による HTML解析機能の実装 ⚠️ **2025-11-30 更新**

**優先度**: 最高
**見積もり**: 3時間（WebView対応により増加）
**依存**: Issue #2

#### 概要
WebView と JavaScript Injection を使用して、小説家になろうのDOMから本文を抽出する機能を実装する。
**重要**: 利用規約を遵守するため、HTTP直接取得ではなくWebView方式を採用。

#### タスク
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
  - `parseFromWebView(String url)` メソッド
  - WebViewController でページを読み込み
  - JavaScript Injection で DOM から情報を取得
    - `document.querySelector('.novel_title')` でタイトル
    - `document.querySelector('#novel_honbun p')` で本文段落
    - `document.querySelector('.novel_writername')` で作者名
  - JSON形式で結果を受け取り、パース
  - ルビ（`<ruby>` タグ）の処理
- [ ] WebView の初期化とライフサイクル管理
  - ページ読み込み完了の検出
  - メモリリーク防止
- [ ] エラーハンドリング
  - ページ読み込みエラー
  - JavaScript実行エラー
  - パースエラー（想定外のHTML構造）
- [ ] ユニットテストを作成
  - モックWebViewでのパーステスト
  - エラーハンドリングのテスト
- [ ] コード生成を実行（`dart run build_runner build`）

#### 成功基準
- [ ] WebView経由でサンプル小説URLから正しく本文を抽出できる
- [ ] ルビが適切に処理されている
- [ ] ユニットテストが成功
- [ ] `flutter analyze` でエラーなし
- [ ] 利用規約を遵守した実装になっている

---

### Issue #4: 基本的なアプリ構造とルーティング設定

**優先度**: 高
**見積もり**: 1.5時間
**依存**: Issue #1

#### 概要
アプリのエントリーポイントと基本的な画面構成を作成する。

#### タスク
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

#### 成功基準
- [ ] アプリが正常に起動する
- [ ] NovelReaderScreen が表示される
- [ ] `flutter analyze` でエラーなし

---

## 3. Phase 2: TTS機能実装

### Issue #5: TTS基本機能の実装

**優先度**: 高
**見積もり**: 2.5時間
**依存**: Issue #1

#### 概要
flutter_tts を使用した基本的な読み上げ機能を実装する。

#### タスク
- [ ] `TTSConfig` モデルを作成（Freezed使用）
  ```dart
  @freezed
  class TTSConfig with _$TTSConfig {
    const factory TTSConfig({
      @Default(1.0) double speed,
      @Default(1.0) double pitch,
      @Default(1.0) double volume,
      @Default(0.0) double linePause,
      @Default(0.0) double paragraphPause,
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

#### 成功基準
- [ ] テキストを読み上げできる
- [ ] 一時停止・停止が動作する
- [ ] 速度設定が反映される
- [ ] ユニットテストが成功
- [ ] `flutter analyze` でエラーなし

---

### Issue #6: 読み上げ速度設定UI

**優先度**: 中
**見積もり**: 1.5時間
**依存**: Issue #5

#### 概要
読み上げ速度を調整するUIを作成する。

#### タスク
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

#### 成功基準
- [ ] スライダーで速度を変更できる
- [ ] 変更がリアルタイムで反映される
- [ ] ウィジェットテストが成功
- [ ] `flutter analyze` でエラーなし

---

### Issue #7: 再生コントローラーUI

**優先度**: 高
**見積もり**: 2時間
**依存**: Issue #5

#### 概要
再生/一時停止/停止のコントロールUIを作成する。

#### タスク
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

#### 成功基準
- [ ] 再生/一時停止/停止が動作する
- [ ] ボタンの状態が適切に切り替わる
- [ ] ウィジェットテストが成功
- [ ] `flutter analyze` でエラーなし

---

## 4. Phase 3: UI統合とハイライト機能

### Issue #8: 小説本文表示UIとデータ統合

**優先度**: 高
**見積もり**: 2.5時間
**依存**: Issue #3, Issue #4

#### 概要
HTML解析で取得した小説データを画面に表示する機能を実装する。

#### タスク
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

#### 成功基準
- [ ] URLから小説を読み込んで表示できる
- [ ] ローディング・エラー状態が適切に表示される
- [ ] テストが成功
- [ ] `flutter analyze` でエラーなし

---

### Issue #9: 読み上げ位置のハイライト表示機能

**優先度**: 高
**見積もり**: 2.5時間
**依存**: Issue #5, Issue #8

#### 概要
現在読み上げ中の文章をハイライト表示する機能を実装する。

#### タスク
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

#### 成功基準
- [ ] 読み上げ中の文章がハイライト表示される
- [ ] ハイライトが読み上げ位置に追従する
- [ ] ウィジェットテストが成功
- [ ] `flutter analyze` でエラーなし

---

### Issue #10: 読み上げ位置の自動スクロール機能

**優先度**: 高
**見積もり**: 2時間
**依存**: Issue #9

#### 概要
読み上げ位置が画面外に出ないように自動的にスクロールする機能を実装する。

#### タスク
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

#### 成功基準
- [ ] 読み上げ位置が常に画面内に表示される
- [ ] スムーズにスクロールする
- [ ] 手動スクロールが優先される
- [ ] ウィジェットテストが成功
- [ ] `flutter analyze` でエラーなし

---

## 5. Phase 4: 総合テストと調整

### Issue #11: MVPの総合テストと最終調整

**優先度**: 最高
**見積もり**: 3時間
**依存**: すべての前Issueが完了

#### 概要
すべての機能を統合し、エンドツーエンドで動作することを確認する。

#### タスク
- [ ] 統合テストシナリオの作成
  1. アプリ起動
  2. URL入力
  3. 小説読み込み
  4. 本文表示確認
  5. 再生ボタンタップ
  6. 読み上げ開始確認
  7. ハイライト表示確認
  8. 自動スクロール確認
  9. 速度変更
  10. 一時停止
  11. 再開
  12. 停止
- [ ] 実機でのテスト（iOS）
  - iPhone実機での動作確認
  - パフォーマンスチェック
  - メモリ使用量チェック
  - バッテリー消費チェック
- [ ] エッジケースのテスト
  - ネットワークエラー時の動作
  - 長文小説での動作
  - ルビが多い小説での動作
  - 特殊記法がある小説での動作
- [ ] UI/UX調整
  - レイアウトの微調整
  - 色・フォントの調整
  - アニメーションの調整
  - エラーメッセージの改善
- [ ] パフォーマンス最適化
  - 不要な rebuild の削減
  - メモリ使用量の最適化
- [ ] コードレビュー
  - コードの可読性チェック
  - コメント追加
  - リファクタリング
- [ ] ドキュメント更新
  - README.md の更新
  - 使い方ガイドの作成（オプション）
  - 既知の問題・制限事項の文書化

#### 成功基準
- [ ] すべての機能が正常に動作する
- [ ] すべてのテストが成功
- [ ] `flutter analyze` でエラーなし
- [ ] 実機で30分以上連続稼働しクラッシュしない
- [ ] MVP要件定義書の成功基準をすべて満たす

---

## 6. Issue間の依存関係図

```
[Phase 1: 基盤構築]
Issue #1 (セットアップ)
    ├─→ Issue #2 (HTML調査)
    │       └─→ Issue #3 (HTML解析実装)
    └─→ Issue #4 (アプリ構造)

[Phase 2: TTS機能]
Issue #1
    └─→ Issue #5 (TTS基本機能)
            ├─→ Issue #6 (速度設定UI)
            └─→ Issue #7 (再生コントローラー)

[Phase 3: UI統合]
Issue #3 + Issue #4
    └─→ Issue #8 (本文表示UI)
            ├─→ Issue #9 (ハイライト) ← Issue #5
            │       └─→ Issue #10 (自動スクロール)

[Phase 4: 総合テスト]
すべてのIssue
    └─→ Issue #11 (総合テスト)
```

---

## 7. 作業スケジュール（参考）

| Phase | Issues | 合計見積もり | 備考 |
|-------|--------|------------|------|
| Phase 1 | #1〜#4 | 6.5時間 | 基盤構築、並行作業可能な部分あり |
| Phase 2 | #5〜#7 | 6時間 | TTS機能、#6と#7は#5の後に並行可能 |
| Phase 3 | #8〜#10 | 7時間 | UI統合、順次実施 |
| Phase 4 | #11 | 3時間 | 総合テスト |
| **合計** | **11 Issues** | **22.5時間** | 約3日間の作業量 |

**注**: 見積もりは参考値。実際の作業時間は個人差あり。

---

## 8. 並行作業の可能性

以下のIssueは並行して作業可能：

### グループ1（Phase 1）
- Issue #1 完了後:
  - Issue #2（HTML調査）
  - Issue #4（アプリ構造）
  - Issue #5（TTS基本機能）

### グループ2（Phase 2）
- Issue #5 完了後:
  - Issue #6（速度設定UI）
  - Issue #7（再生コントローラー）

### グループ3（Phase 3）
- Issue #8 完了後、Issue #5も完了していれば:
  - Issue #9（ハイライト）を開始

---

## 9. リスクと対策

### リスク1: HTML構造の変更
- **影響度**: 高
- **対策**: Issue #2で詳細に調査し、エッジケースを文書化。変更検知の仕組みを将来的に検討。

### リスク2: TTS の動作が不安定
- **影響度**: 中
- **対策**: Issue #5で十分にテスト。エラーハンドリングを丁寧に実装。

### リスク3: ハイライト・自動スクロールのパフォーマンス
- **影響度**: 中
- **対策**: Issue #9, #10でパフォーマンステスト。最適化が必要な場合はリファクタリング。

### リスク4: 実機での動作不良
- **影響度**: 高
- **対策**: Issue #11で実機テストを実施。早期に問題を発見・修正。

---

## 10. Issue作成時のテンプレート

各Issueは以下のテンプレートで作成：

```markdown
## 概要
[Issueの概要を1-2文で記載]

## 目的
[このIssueで達成したいこと]

## タスク
- [ ] タスク1
- [ ] タスク2
- [ ] タスク3

## 成功基準
- [ ] 基準1
- [ ] 基準2

## 技術的詳細
[実装の詳細、使用するパッケージなど]

## テスト計画
[どのようなテストを書くか]

## 参考資料
[関連ドキュメントへのリンク]
```

---

## 11. 変更履歴

| 日付 | バージョン | 変更内容 |
|------|----------|---------|
| 2025-11-30 | 1.0.0 | 初版作成。HTTP直接取得を前提としたIssue計画 |
| 2025-11-30 | 1.1.0 | **重要な変更**: Issue #3をWebView + JavaScript Injection方式に変更。利用規約遵守のため、実装方針を全面的に見直し |

---

## 12. 承認

- **作成者**: Claude (AI Assistant)
- **レビュー**: ユーザー承認済み
- **承認日**: 2025-11-30

---

## 13. 次のステップ

このドキュメントが承認されたら、以下を実施：

1. GitHub Issues を作成（Issue #1〜#11）
2. 各Issueにラベルを付与（`phase-1`, `phase-2`, etc.）
3. マイルストーンを作成（`MVP v1.0.0`）
4. Issue #1から作業開始
