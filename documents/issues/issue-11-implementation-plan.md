# Issue-11 実施計画

**作成日**: 2025-12-28
**担当**: Claude (AI Assistant)
**見積もり**: 4時間

---

## 実施する内容の概要

WebViewベースのブラウザとTTS機能の統合を完成させ、MVP を完成させます。JavaScript Injection によるハイライト表示と自動スクロール機能を追加し、未使用コードを削除してコードベースをクリーンアップします。

## 実施手順

### フェーズ1: コア機能実装（2.5時間）

#### ステップ1: JavaScript Injection ユーティリティの作成（30分）

**ファイル**: `lib/features/novel_reader/application/javascript_injector.dart`

段落のハイライトとスクロールを行う JavaScript を提供するユーティリティクラスを作成します。

**実装内容**:
```dart
class JavaScriptInjector {
  /// CSSスタイルをインジェクト（初回のみ）
  static String get injectHighlightStyle => '''
    if (!document.getElementById('tts-highlight-style')) {
      const style = document.createElement('style');
      style.id = 'tts-highlight-style';
      style.textContent = \`
        .tts-highlight {
          background-color: rgba(255, 255, 0, 0.3) !important;
          transition: background-color 0.3s ease;
        }
      \`;
      document.head.appendChild(style);
    }
  ''';

  /// 指定した段落をハイライトしてスクロール
  static String highlightAndScrollToParagraph(int index) => '''
    // 前のハイライトを削除
    const prevHighlight = document.querySelector('.tts-highlight');
    if (prevHighlight) {
      prevHighlight.classList.remove('tts-highlight');
    }

    // 新しい段落をハイライト
    const paragraphs = document.querySelectorAll('#novel_honbun p');
    if (paragraphs[$index]) {
      paragraphs[$index].classList.add('tts-highlight');
      paragraphs[$index].scrollIntoView({
        behavior: 'smooth',
        block: 'center'
      });
    }
  ''';

  /// すべてのハイライトを削除
  static String get clearHighlight => '''
    const highlighted = document.querySelector('.tts-highlight');
    if (highlighted) {
      highlighted.classList.remove('tts-highlight');
    }
  ''';
}
```

#### ステップ2: PlaybackControllerNotifier の更新（60分）

**ファイル**: `lib/features/tts/presentation/playback_controller_notifier.dart`

段落ごとの読み上げ時にハイライトとスクロールを実行するように更新します。

**変更点**:
1. `WebViewController` への参照を保持
2. `play()` メソッドで各段落読み上げ時に JavaScript を実行
3. `stop()` メソッドでハイライトをクリア

**実装内容**:
```dart
// WebViewController への参照を追加
WebViewController? _webViewController;

void setWebViewController(WebViewController controller) {
  _webViewController = controller;
}

Future<void> play([String? text]) async {
  // Issue #10: 小説コンテンツからの再生
  if (text == null) {
    if (!hasNovelContent) return;

    final novelContent = ref.read(novelReaderNotifierProvider).novelContent!;
    final ttsNotifier = ref.read(ttsServiceNotifierProvider.notifier);

    state = state.copyWith(
      isPlaying: true,
      currentPosition: 0,
      totalLength: novelContent.paragraphs.length,
    );

    try {
      // Issue #11: 初回スタイル注入
      if (_webViewController != null) {
        await _webViewController!.runJavaScript(
          JavaScriptInjector.injectHighlightStyle,
        );
      }

      for (int i = 0; i < novelContent.paragraphs.length; i++) {
        if (!state.isPlaying) break;

        state = state.copyWith(
          currentPosition: i,
          currentText: novelContent.paragraphs[i],
        );

        // Issue #11: ハイライトとスクロール
        if (_webViewController != null) {
          await _webViewController!.runJavaScript(
            JavaScriptInjector.highlightAndScrollToParagraph(i),
          );
        }

        await ttsNotifier.speak(novelContent.paragraphs[i]);
      }

      // 最後まで再生したら停止
      await _clearHighlight();
      state = state.copyWith(isPlaying: false);
    } catch (e) {
      await _clearHighlight();
      state = state.copyWith(isPlaying: false);
      rethrow;
    }
    return;
  }

  // 従来の動作...
}

Future<void> stop() async {
  try {
    final ttsNotifier = ref.read(ttsServiceNotifierProvider.notifier);
    await ttsNotifier.stop();

    // Issue #11: ハイライトをクリア
    await _clearHighlight();

    state = state.copyWith(
      isPlaying: false,
      currentPosition: 0,
      currentText: null,
    );
  } catch (e) {
    rethrow;
  }
}

Future<void> _clearHighlight() async {
  if (_webViewController != null) {
    try {
      await _webViewController!.runJavaScript(
        JavaScriptInjector.clearHighlight,
      );
    } catch (e) {
      // ページ遷移などでエラーが出る可能性があるが、無視
    }
  }
}
```

#### ステップ3: NovelReaderScreen の更新（30分）

**ファイル**: `lib/features/novel_reader/presentation/novel_reader_screen.dart`

PlaybackControllerNotifier に WebViewController への参照を設定します。

**変更点**:
```dart
@override
void initState() {
  super.initState();

  _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(/* ... */)
    ..loadRequest(Uri.parse('https://syosetu.com/'));
}

// Issue #11: WebViewController を PlaybackControllerNotifier に設定
void _initializePlaybackController() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(playbackControllerNotifierProvider.notifier)
        .setWebViewController(_controller);
  });
}

@override
Widget build(BuildContext context, WidgetRef ref) {
  _initializePlaybackController(); // Issue #11

  // 既存のビルドコード...
}
```

#### ステップ4: テストの作成（30分）

**ファイル**: `test/features/novel_reader/application/javascript_injector_test.dart`

JavaScriptInjector のテストを作成します。

**テスト内容**:
- `injectHighlightStyle` が正しい JavaScript を返す
- `highlightAndScrollToParagraph(index)` が正しいインデックスを含む
- `clearHighlight` が正しい JavaScript を返す

### フェーズ2: コードクリーンアップ（1時間）

#### ステップ5: 未使用コードの削除（40分）

以下のファイルとコードを削除：

**削除対象**:
1. `lib/features/novel_reader/presentation/novel_content_view.dart` - 全体削除
2. `test/features/novel_reader/presentation/novel_content_view_test.dart` - 全体削除
3. `novel_reader_screen.dart` 内のコメントアウトコード:
   - URL入力UI関連のコメント（行24-87）
   - NovelContentView 関連のコメント（行147-151）

#### ステップ6: インポートとテストの修正（20分）

削除したファイルに依存しているコードを修正：
- `widget_test.dart` から NovelContentView 関連のテストを削除（既にコメントアウト済み）
- インポート文のクリーンアップ

### フェーズ3: ドキュメント更新（30分）

#### ステップ7: README.md の更新（15分）

**ファイル**: `README.md`

アプリの説明を更新し、WebViewベースのブラウザであることを明記します。

**更新内容**:
- プロジェクト概要の更新
- 主要機能の説明（WebViewブラウザ、小説ページ検出、TTS統合）
- 使い方の説明

#### ステップ8: MVP完成報告書の作成（15分）

**ファイル**: `documents/mvp-completion-report.md`

MVP完成の報告書を作成します。

**内容**:
- 実装した機能の一覧
- テスト結果のサマリー
- 成功基準の確認
- 既知の問題・制限事項
- 次のステップ（将来機能）

## 影響範囲

### 新規作成
- `lib/features/novel_reader/application/javascript_injector.dart`
- `test/features/novel_reader/application/javascript_injector_test.dart`
- `documents/mvp-completion-report.md`

### 修正
- `lib/features/tts/presentation/playback_controller_notifier.dart` - ハイライト・スクロール統合
- `lib/features/novel_reader/presentation/novel_reader_screen.dart` - WebViewController 設定
- `README.md` - 更新

### 削除
- `lib/features/novel_reader/presentation/novel_content_view.dart` - 全体削除
- `test/features/novel_reader/presentation/novel_content_view_test.dart` - 全体削除
- `novel_reader_screen.dart` 内のコメントアウトコード

## テスト計画

### ユニットテスト
- JavaScriptInjector の JavaScript 生成テスト

### 統合テスト（手動）
1. アプリ起動 → syosetu.com が表示される
2. 小説ページに遷移 → TTSコントロールが有効化される
3. 再生ボタンを押す → 読み上げ開始
4. ハイライト表示を確認 → 読み上げ中の段落が黄色背景でハイライト
5. 自動スクロールを確認 → 読み上げ位置が画面中央に表示される
6. 一時停止 → ハイライトが維持される
7. 停止 → ハイライトがクリアされる
8. 非小説ページへ遷移 → TTSコントロールが無効化される

## 成功基準

### 技術的基準
- [ ] `flutter analyze` でエラーなし
- [ ] すべてのテストが成功
- [ ] コード生成が正常に完了

### 機能的基準
- [ ] 読み上げ中の段落がハイライト表示される
- [ ] 読み上げ位置に自動的にスクロールする
- [ ] 停止時にハイライトがクリアされる
- [ ] ページ遷移時に適切に動作する
- [ ] 未使用コードがすべて削除されている
- [ ] ドキュメントが最新の状態に更新されている

## 予想される課題と対策

### 課題1: JavaScript Injection のタイミング

**問題**: ページ読み込み完了前に JavaScript を実行するとエラーになる
**対策**: try-catch でエラーを捕捉し、無視する（ページ遷移時など）

### 課題2: WebViewController の参照管理

**問題**: PlaybackControllerNotifier が WebViewController への参照を持つ必要がある
**対策**: `setWebViewController()` メソッドで明示的に設定

### 課題3: ハイライトのタイミング

**問題**: TTS再生とハイライトのタイミングがずれる可能性
**対策**: 段落読み上げ開始直前にハイライトを実行

## 次のステップ（Issue-11完了後）

Issue-11完了後、以下のタスクが残ります：

1. **実機テスト** - ユーザーが実際のiPhoneで動作確認
2. **パフォーマンスチェック** - ユーザーが長時間使用でのパフォーマンスを確認
3. **エッジケーステスト** - ユーザーが様々なシナリオでテスト

これらはユーザー側で実施していただく内容です。

---

**作成者**: Claude (AI Assistant)
**承認**: 実施前にユーザー確認
