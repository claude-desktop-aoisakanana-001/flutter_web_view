# Phase 3: 小説ページ検出とTTS統合

**ラベル**: `phase-3`, `priority-highest`, `feature`
**見積もり**: 3.5時間
**依存**: Issue #5, Issue #9

---

## 概要
WebView内のURL変化を監視し、小説ページを自動検出してTTS機能を有効化する。小説ページでは本文を抽出し、再生コントローラーを有効にする。

## 目的
- WebView内のURL変化を監視
- 小説ページのURL パターンを検出
- 小説ページで自動的に本文を抽出
- TTSコントロールの有効/無効を自動切り替え
- 既存のTtsServiceと統合

## タスク

### 1. 小説ページURLパターンの定義
- [ ] 小説ページURLパターンを特定
  - 小説本文ページ: `https://ncode.syosetu.com/nXXXX/Y/`
  - 短編: `https://ncode.syosetu.com/nXXXX/`
  - 正規表現パターンの作成
- [ ] URL判定ユーティリティを作成
  ```dart
  class NarouUrlDetector {
    static bool isNovelPage(String url) {
      // URLが小説ページかどうかを判定
    }

    static NovelPageType? getPageType(String url) {
      // 短編 or 連載 or その他を判定
    }
  }
  ```

### 2. URL監視とページ検出機能
- [ ] WebViewNotifier にURL監視機能を追加
  - `onNavigationRequest` でURL変化をキャプチャ
  - `onPageFinished` で最終URLを確認
- [ ] 小説ページ検出時のイベント処理
  ```dart
  void _onPageFinished(String url) {
    if (NarouUrlDetector.isNovelPage(url)) {
      _onNovelPageDetected(url);
    } else {
      _onNonNovelPageDetected();
    }
  }
  ```
- [ ] ページタイプに応じた状態管理
  - `WebViewState` に `isNovelPage` フラグを追加
  - `currentNovelUrl` を保存

### 3. 小説本文の自動抽出
- [ ] 小説ページ検出時に `NarouParserService` を呼び出し
  - 既存の `parseFromWebView()` を再利用
  - WebViewController を渡して解析実行
- [ ] 抽出した本文をTTSサービスに渡す準備
  - `NovelReaderNotifier` または新しい `TtsContentNotifier` で管理
  - 段落リストを保持
- [ ] エラーハンドリング
  - 解析失敗時の処理
  - ネットワークエラー時の処理

### 4. TTSコントロールの有効化制御
- [ ] `PlaybackController` の状態制御
  - 小説ページ: ボタン有効化
  - 非小説ページ: ボタン無効化（グレーアウト）
- [ ] `PlaybackControllerNotifier` の更新
  - 本文データの有無に応じて有効/無効を切り替え
  - 再生可能状態の管理
- [ ] UI表示の調整
  - 無効時: ツールチップで「小説ページで有効になります」表示
  - 有効時: 通常の再生コントロール

### 5. TTS再生機能との統合
- [ ] 再生ボタン押下時の処理
  - 抽出済みの段落リストを取得
  - `TtsService.speak()` で読み上げ開始
  - 現在の段落位置を追跡
- [ ] 段落単位での読み上げ制御
  - 段落ごとに `speak()` を呼び出し
  - 段落間の自然な間隔
- [ ] 再生位置の管理
  - 現在読み上げ中の段落インデックス
  - 一時停止時の位置保存
  - 停止時の位置リセット

### 6. ページ遷移時の処理
- [ ] 小説ページ → 非小説ページ遷移時
  - 再生中の場合は自動停止
  - TTSコントロールを無効化
  - 本文データをクリア
- [ ] 小説ページ → 別の小説ページ遷移時
  - 再生中の場合は自動停止
  - 新しいページの本文を抽出
  - TTSコントロールは有効のまま
- [ ] 状態のクリーンアップ
  - メモリリーク防止
  - WebViewController のリソース管理

### 7. テスト作成
- [ ] URL検出のユニットテスト
  - 小説ページURL判定のテスト
  - 各種URLパターンのテスト
- [ ] ページ検出のウィジェットテスト
  - モックWebViewでのテスト
- [ ] TTS統合のテスト
  - 本文抽出 → TTS再生のフローテスト
  - ページ遷移時の状態変更テスト

## 成功基準
- [ ] 小説ページに遷移すると、自動的に本文が抽出される
- [ ] 小説ページでTTSコントロールが有効になる
- [ ] 非小説ページでTTSコントロールが無効になる
- [ ] 再生ボタンで小説を読み上げできる
- [ ] ページ遷移時に適切に状態がクリアされる
- [ ] すべてのテストが成功
- [ ] `flutter analyze` でエラーなし

## 技術的詳細

### URL検出パターン
```dart
class NarouUrlDetector {
  // 小説本文ページのパターン
  static final RegExp _novelPagePattern = RegExp(
    r'^https?://ncode\.syosetu\.com/n\w+/\d+/?$',
  );

  // 短編小説のパターン
  static final RegExp _shortStoryPattern = RegExp(
    r'^https?://ncode\.syosetu\.com/n\w+/?$',
  );

  static bool isNovelPage(String url) {
    return _novelPagePattern.hasMatch(url) ||
           _shortStoryPattern.hasMatch(url);
  }
}
```

### ページ検出とTTS制御フロー
```dart
void _onPageFinished(String url) {
  final isNovel = NarouUrlDetector.isNovelPage(url);

  if (isNovel) {
    // 小説本文を抽出
    _extractNovelContent(url);
    // TTSコントロールを有効化
    _enableTtsControls();
  } else {
    // 再生中なら停止
    _stopPlaybackIfPlaying();
    // TTSコントロールを無効化
    _disableTtsControls();
    // 本文データをクリア
    _clearNovelContent();
  }
}
```

### TTS再生との統合
```dart
Future<void> _playNovel() async {
  final paragraphs = ref.read(novelContentProvider)?.paragraphs;
  if (paragraphs == null || paragraphs.isEmpty) return;

  for (int i = 0; i < paragraphs.length; i++) {
    await ttsService.speak(paragraphs[i]);
    // 現在位置を更新（Issue #11でハイライト対応）
    ref.read(playbackControllerNotifierProvider.notifier)
        .updatePosition(i);
  }
}
```

## 影響範囲
- `lib/features/novel_reader/application/webview_notifier.dart` - 修正
- `lib/features/novel_reader/domain/models/webview_state.dart` - 修正
- `lib/features/html_parser/application/narou_url_detector.dart` - 新規作成
- `lib/features/tts/presentation/playback_controller.dart` - 修正
- `lib/features/tts/presentation/playback_controller_notifier.dart` - 修正
- `test/features/html_parser/application/narou_url_detector_test.dart` - 新規作成

## 注意事項
- **既存の NarouParserService を再利用**: すでに実装済みの解析ロジックを活用
- **段階的な機能追加**: まずは基本的な検出と有効化のみ、ハイライトはIssue #11で対応
- **メモリ管理**: ページ遷移時に適切にリソースを解放
- **エラーハンドリング**: 解析失敗時もアプリがクラッシュしないように

## 参考資料
- [architecture.md](../architecture.md)
- [mvp-requirements.md](../mvp-requirements.md)
- [issue-plan.md](../issue-plan.md)
- [narou-html-analysis.md](../narou-html-analysis.md)
