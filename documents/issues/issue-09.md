# Phase 3: WebViewブラウザ実装とUI統合

**ラベル**: `phase-3`, `priority-highest`, `feature`
**見積もり**: 3時間
**依存**: Issue #6, Issue #7, Issue #8

---

## 概要
アプリをWebViewベースのブラウザとして再構成し、小説家になろうサイトを直接閲覧できるようにする。URL入力ではなく、サイトトップから自然にブラウジングできる体験を提供する。

## 目的
- URL入力UIを削除し、全画面WebViewに置き換える
- 初期表示を小説家になろうのトップページにする
- 下部にTTSコントロール（速度設定 + 再生コントローラー）を配置
- サイトUI拡張としての基本体験を確立

## タスク

### 1. WebViewブラウザの実装
- [ ] `NovelReaderScreen` をWebView中心のレイアウトに変更
  - 全画面WebViewコンポーネント
  - 下部固定のコントロールパネル
  - URL入力フィールドの削除
- [ ] WebViewController の初期化と設定
  - 初期URL: `https://syosetu.com/` （暫定、後で変更可能）
  - JavaScript有効化
  - ナビゲーション設定
  - URL変更の監視準備
- [ ] WebView の基本ナビゲーション機能
  - リンククリックでの遷移
  - 戻る/進むボタン（必要に応じて）
  - ページ読み込み状態の表示

### 2. UI レイアウトの再構成
- [ ] Column レイアウトで構成
  ```
  ┌─────────────────────┐
  │                     │
  │                     │
  │     WebView         │
  │  (Expanded)         │
  │                     │
  ├─────────────────────┤
  │  Speed Settings     │
  ├─────────────────────┤
  │  Playback Control   │
  └─────────────────────┘
  ```
- [ ] 既存の `SpeedSettings` と `PlaybackController` を下部に配置
- [ ] `NovelContentView` の非表示化（削除はしない）
  - 将来的に削除するが、今は使用を停止するのみ

### 3. WebView状態管理
- [ ] `WebViewState` モデルを作成（Freezed使用）
  ```dart
  @freezed
  class WebViewState with _$WebViewState {
    const factory WebViewState({
      @Default('') String currentUrl,
      @Default(false) bool isLoading,
      @Default(false) bool canGoBack,
      @Default(false) bool canGoForward,
      String? pageTitle,
    }) = _WebViewState;
  }
  ```
- [ ] `WebViewNotifier` を実装（Riverpod使用）
  - URL変更の監視
  - ページ読み込み状態の管理
  - 戻る/進むの可否判定

### 4. TTSコントロールの表示制御準備
- [ ] コントロールパネルは常時表示（Issue #10で有効/無効を切り替え）
- [ ] 現時点では機能無効化（グレーアウト、またはダミー動作）
- [ ] Issue #10でページ検出後に有効化する設計にする

### 5. 既存コードの整理
- [ ] `NovelReaderNotifier.loadNovel()` の使用を停止
  - メソッド自体は削除しない（後で整理）
- [ ] URL入力関連のUIコードをコメントアウト
  - 削除ではなく、コメントアウトで対応
- [ ] 既存のテストは維持（一部スキップマークを付けても良い）

### 6. テスト作成
- [ ] WebViewの初期化テスト
- [ ] 初期URLの確認テスト
- [ ] レイアウト構成のウィジェットテスト
- [ ] ナビゲーション機能のテスト（モック使用）

## 成功基準
- [ ] アプリ起動時に小説家になろうのトップページが表示される
- [ ] WebView内でリンクをクリックしてページ遷移できる
- [ ] 下部にTTSコントロールが常時表示されている
- [ ] ページ読み込み中のローディング表示が適切に動作する
- [ ] `flutter analyze` でエラーなし
- [ ] 新規作成したテストが成功

## 技術的詳細

### WebViewの初期化
```dart
late final WebViewController _controller;

@override
void initState() {
  super.initState();
  _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) => _onPageStarted(url),
        onPageFinished: (url) => _onPageFinished(url),
        onWebResourceError: (error) => _onError(error),
      ),
    )
    ..loadRequest(Uri.parse('https://syosetu.com/'));
}
```

### レイアウト構成
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('よみあげRun')),
    body: Column(
      children: [
        // WebView（可変高さ）
        Expanded(
          child: WebViewWidget(controller: _controller),
        ),
        // 速度設定（固定高さ）
        const SpeedSettings(),
        // 再生コントローラー（固定高さ）
        const PlaybackController(),
      ],
    ),
  );
}
```

## 影響範囲
- `lib/features/novel_reader/presentation/novel_reader_screen.dart` - 大幅変更
- `lib/features/novel_reader/application/webview_notifier.dart` - 新規作成
- `lib/features/novel_reader/domain/models/webview_state.dart` - 新規作成
- `test/features/novel_reader/presentation/novel_reader_screen_test.dart` - 修正
- `test/widget_test.dart` - 修正

## 注意事項
- **既存コードは削除しない**: `NovelReaderNotifier`, `NovelContentView` などは将来削除するが、今は使用停止のみ
- **段階移行**: Issue #10でページ検出機能を追加してから、TTS機能を統合
- **暫定的な初期URL**: `https://syosetu.com/` はあとから変更可能な設計にする
- **テストの調整**: 既存テストで失敗するものはスキップマーク（`skip: true`）を使用

## 参考資料
- [architecture.md](../architecture.md)
- [mvp-requirements.md](../mvp-requirements.md)
- [issue-plan.md](../issue-plan.md)
- [WebView Flutter公式ドキュメント](https://pub.dev/packages/webview_flutter)
