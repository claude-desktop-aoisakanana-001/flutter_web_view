# Phase 1: WebView + JavaScript Injection による HTML解析機能の実装

**ラベル**: `phase-1`, `priority-high`, `webview`
**見積もり**: 3時間（WebView対応により増加）
**依存**: Issue #2

⚠️ **2025-11-30 更新**: 利用規約遵守のため、HTTP直接取得からWebView方式に変更

---

## 概要
WebView と JavaScript Injection を使用して、小説家になろうのDOMから本文を抽出する機能を実装する。

**重要な背景**:
- Issue #2の調査により、小説家になろうの利用規約ではコンテンツの自動スクレイピングが禁止されていることが判明
- HTTP直接取得は規約違反となるため、WebView内での閲覧方式を採用
- WebView経由でのDOM取得により、公式サイトを通じた正規の閲覧として扱われる

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
  - `parseFromWebView(String url)` メソッド
  - WebViewController を注入して使用
  - ページ読み込みとJavaScript実行
    ```dart
    // タイトル取得
    final title = await webViewController.runJavaScriptReturningResult(
      "document.querySelector('.novel_title')?.textContent || ''",
    );

    // 作者名取得
    final author = await webViewController.runJavaScriptReturningResult(
      "document.querySelector('.novel_writername')?.textContent || ''",
    );

    // 本文段落取得（JSON形式）
    final paragraphsJson = await webViewController.runJavaScriptReturningResult(
      """
      JSON.stringify(
        Array.from(document.querySelectorAll('#novel_honbun p'))
          .map(p => p.textContent.trim())
      )
      """,
    );
    ```
  - JSON形式で受け取った結果をパース
  - ルビ（`<ruby>` タグ）の処理
    - `textContent` でルビを除外したテキストを取得
    - または `innerHTML` でルビ情報も保持
- [ ] WebView の初期化とライフサイクル管理
  - `WebViewController` の作成と設定
  - ページ読み込み完了の検出
    - `NavigationDelegate` の使用
    - `onPageFinished` コールバック
  - メモリリーク防止
    - WebView の適切な dispose
- [ ] エラーハンドリング
  - ページ読み込みエラー
    - タイムアウト処理
    - ネットワークエラー
  - JavaScript実行エラー
    - 要素が見つからない場合
    - JSON パースエラー
  - パースエラー（想定外のHTML構造）
- [ ] ユニットテストを作成
  - モックWebViewでのパーステスト
  - エラーハンドリングのテスト
  - ルビ処理のテスト
- [ ] コード生成を実行（`dart run build_runner build`）

## 成功基準
- [ ] WebView経由でサンプル小説URLから正しく本文を抽出できる
- [ ] ルビが適切に処理されている
- [ ] ユニットテストが成功
- [ ] `flutter analyze` でエラーなし
- [ ] **利用規約を遵守した実装になっている**

## 技術的詳細

### WebView の設定
```dart
final WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(
    NavigationDelegate(
      onPageFinished: (String url) {
        // ページ読み込み完了時の処理
      },
    ),
  );
```

### JavaScript Injection のパターン
- **単一要素取得**: `querySelector()` + `textContent`
- **複数要素取得**: `querySelectorAll()` + `Array.from()` + `map()` + `JSON.stringify()`
- **エラーハンドリング**: `?.` (Optional Chaining) と `|| ''` (デフォルト値)

### ルビの扱い
- **TTS用**: `textContent` でルビを除外（ベーステキストのみ）
- **表示用**: `innerHTML` でルビタグも保持（将来対応）

## 参考資料
- [architecture.md](../architecture.md) - HTML解析戦略（5.3節）
- [narou-html-analysis.md](../narou-html-analysis.md) - セレクタ情報
- [tech-selection.md](../tech-selection.md) - WebView採用の理由（5.1節）
- [issue-plan.md](../issue-plan.md) - Issue全体計画
- [webview_flutter 公式ドキュメント](https://pub.dev/packages/webview_flutter)

## 注意事項

### 利用規約遵守
- WebView経由のアクセスは公式サイトを通じた正規の閲覧
- JavaScript Injection はDOM取得のみに使用し、サイト改変は行わない
- 過度なアクセスを避ける（レート制限の考慮）

### パフォーマンス
- WebView の初期化コストを考慮
- 複数ページの連続読み込み時は WebView を再利用
- 不要になったら適切に dispose

### クロスプラットフォーム
- iOS と Android で WebView の挙動が異なる可能性
- 両プラットフォームでテストを実施
