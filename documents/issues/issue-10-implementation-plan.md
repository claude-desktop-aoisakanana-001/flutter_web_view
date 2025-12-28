# Issue-10 実施計画

**作成日**: 2025-12-28
**担当**: Claude (AI Assistant)
**見積もり**: 3.5時間

---

## 実施する内容の概要

WebView内のURL変化を監視し、小説ページを自動検出してTTS機能を有効化します。小説ページでは本文を自動抽出し、再生コントローラーを有効にします。非小説ページでは無効化します。

## 実施手順

### ステップ1: NarouUrlDetector の作成（30分）

**ファイル**: `lib/features/html_parser/application/narou_url_detector.dart`

**実装内容**:
```dart
class NarouUrlDetector {
  // 小説本文ページのパターン（連載）
  static final RegExp _novelPagePattern = RegExp(
    r'^https?://ncode\.syosetu\.com/n\w+/\d+/?$',
  );

  // 短編小説のパターン
  static final RegExp _shortStoryPattern = RegExp(
    r'^https?://ncode\.syosetu\.com/n\w+/?$',
  );

  /// URLが小説ページかどうかを判定
  static bool isNovelPage(String url) {
    return _novelPagePattern.hasMatch(url) ||
           _shortStoryPattern.hasMatch(url);
  }

  /// ページタイプを判定
  static NovelPageType? getPageType(String url) {
    if (_novelPagePattern.hasMatch(url)) {
      return NovelPageType.series;
    } else if (_shortStoryPattern.hasMatch(url)) {
      return NovelPageType.shortStory;
    }
    return null;
  }
}

enum NovelPageType {
  series,      // 連載
  shortStory,  // 短編
}
```

### ステップ2: WebViewState の更新（20分）

**ファイル**: `lib/features/novel_reader/domain/models/webview_state.dart`

**追加フィールド**:
```dart
@freezed
class WebViewState with _$WebViewState {
  const factory WebViewState({
    @Default('') String currentUrl,
    @Default(false) bool isLoading,
    @Default(false) bool canGoBack,
    @Default(false) bool canGoForward,
    String? pageTitle,
    // 追加
    @Default(false) bool isNovelPage,  // 小説ページかどうか
    String? currentNovelUrl,           // 現在の小説URL
  }) = _WebViewState;
}
```

### ステップ3: WebViewNotifier の更新（40分）

**ファイル**: `lib/features/novel_reader/application/webview_notifier.dart`

**追加メソッド**:
```dart
/// ページ完了時に小説ページかどうかを判定
void checkNovelPage(String url) {
  final isNovel = NarouUrlDetector.isNovelPage(url);
  state = state.copyWith(
    isNovelPage: isNovel,
    currentNovelUrl: isNovel ? url : null,
  );
}

/// 小説ページ情報をクリア
void clearNovelPage() {
  state = state.copyWith(
    isNovelPage: false,
    currentNovelUrl: null,
  );
}
```

### ステップ4: NovelReaderScreen の更新（60分）

**ファイル**: `lib/features/novel_reader/presentation/novel_reader_screen.dart`

**更新内容**:
1. `_onPageFinished` で小説ページを検出
2. 小説ページの場合、本文を自動抽出
3. NovelReaderNotifier を使用して本文を保存

```dart
Future<void> _onPageFinished(String url) async {
  ref.read(webViewNotifierProvider.notifier).onPageFinished(url);

  // ナビゲーション状態を更新
  final canGoBack = await _controller.canGoBack();
  final canGoForward = await _controller.canGoForward();
  ref.read(webViewNotifierProvider.notifier).updateNavigationState(
    canGoBack: canGoBack,
    canGoForward: canGoForward,
  );

  // 小説ページかどうかを判定
  ref.read(webViewNotifierProvider.notifier).checkNovelPage(url);

  // 小説ページの場合、本文を抽出
  if (NarouUrlDetector.isNovelPage(url)) {
    await _extractNovelContent(url);
  } else {
    // 非小説ページの場合、本文をクリア
    ref.read(novelReaderNotifierProvider.notifier).clearContent();
  }
}

Future<void> _extractNovelContent(String url) async {
  try {
    final notifier = ref.read(novelReaderNotifierProvider.notifier);
    await notifier.loadNovelFromController(_controller, url);
  } catch (e) {
    // エラーハンドリング
    print('Failed to extract novel content: $e');
  }
}
```

### ステップ5: NovelReaderNotifier の更新（30分）

**ファイル**: `lib/features/novel_reader/application/novel_reader_notifier.dart`

**新規メソッド追加**:
```dart
/// WebViewController から小説を読み込む
Future<void> loadNovelFromController(
  WebViewController controller,
  String url,
) async {
  state = state.copyWith(isLoading: true, errorMessage: null);

  try {
    final parserService = ref.read(narouParserServiceProvider);
    final parsed = await parserService.parseFromWebView(controller);

    final content = NovelContent(
      title: parsed.title,
      author: parsed.author,
      url: url,
      paragraphs: parsed.paragraphs,
      fetchedAt: DateTime.now(),
    );

    state = state.copyWith(
      novelContent: content,
      isLoading: false,
    );
  } catch (e) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: 'Failed to load novel: $e',
    );
  }
}

/// 小説コンテンツをクリア
void clearContent() {
  state = state.copyWith(novelContent: null);
}
```

### ステップ6: PlaybackControllerNotifier の更新（40分）

**ファイル**: `lib/features/tts/presentation/playback_controller_notifier.dart`

**更新内容**:
1. 小説コンテンツの有無を監視
2. 再生ボタン押下時に小説を読み上げ

```dart
/// 小説コンテンツが利用可能かどうか
bool get hasContent {
  final novelContent = ref.watch(novelReaderNotifierProvider).novelContent;
  return novelContent != null && novelContent.paragraphs.isNotEmpty;
}

/// 再生を開始
Future<void> play() async {
  if (!hasContent) return;

  final novelContent = ref.read(novelReaderNotifierProvider).novelContent!;
  final ttsService = ref.read(ttsServiceProvider);

  state = state.copyWith(isPlaying: true, currentPosition: 0);

  try {
    for (int i = 0; i < novelContent.paragraphs.length; i++) {
      if (!state.isPlaying) break; // 停止された場合

      state = state.copyWith(
        currentPosition: i,
        currentText: novelContent.paragraphs[i],
      );

      await ttsService.speak(novelContent.paragraphs[i]);
    }

    // 最後まで再生したら停止
    state = state.copyWith(isPlaying: false);
  } catch (e) {
    state = state.copyWith(isPlaying: false);
    // エラーハンドリング
  }
}
```

### ステップ7: PlaybackController UI の更新（30分）

**ファイル**: `lib/features/tts/presentation/playback_controller.dart`

**更新内容**:
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(playbackControllerNotifierProvider);
  final webViewState = ref.watch(webViewNotifierProvider);

  // 小説ページでのみ有効化
  final isEnabled = webViewState.isNovelPage;

  return Card(
    // ... 既存のレイアウト
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: isEnabled ? () {
            if (state.isPlaying) {
              ref.read(playbackControllerNotifierProvider.notifier).pause();
            } else {
              ref.read(playbackControllerNotifierProvider.notifier).play();
            }
          } : null, // 無効時は null
          tooltip: isEnabled
            ? (state.isPlaying ? '一時停止' : '再生')
            : '小説ページで有効になります',
        ),
        // ... 他のボタン
      ],
    ),
  );
}
```

### ステップ8: テスト作成（30分）

**ファイル**: `test/features/html_parser/application/narou_url_detector_test.dart`

```dart
void main() {
  group('NarouUrlDetector', () {
    test('連載小説のURLを正しく検出する', () {
      expect(
        NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n1234ab/1/'),
        true,
      );
      expect(
        NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n1234ab/10/'),
        true,
      );
    });

    test('短編小説のURLを正しく検出する', () {
      expect(
        NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/n1234ab/'),
        true,
      );
    });

    test('非小説ページのURLを正しく判定する', () {
      expect(
        NarouUrlDetector.isNovelPage('https://syosetu.com/'),
        false,
      );
      expect(
        NarouUrlDetector.isNovelPage('https://ncode.syosetu.com/'),
        false,
      );
    });

    test('ページタイプを正しく判定する', () {
      expect(
        NarouUrlDetector.getPageType('https://ncode.syosetu.com/n1234ab/1/'),
        NovelPageType.series,
      );
      expect(
        NarouUrlDetector.getPageType('https://ncode.syosetu.com/n1234ab/'),
        NovelPageType.shortStory,
      );
      expect(
        NarouUrlDetector.getPageType('https://syosetu.com/'),
        null,
      );
    });
  });
}
```

## 影響範囲

### 新規作成
- `lib/features/html_parser/application/narou_url_detector.dart`
- `test/features/html_parser/application/narou_url_detector_test.dart`

### 修正
- `lib/features/novel_reader/domain/models/webview_state.dart` - isNovelPage, currentNovelUrl 追加
- `lib/features/novel_reader/application/webview_notifier.dart` - checkNovelPage(), clearNovelPage() 追加
- `lib/features/novel_reader/application/novel_reader_notifier.dart` - loadNovelFromController(), clearContent() 追加
- `lib/features/novel_reader/presentation/novel_reader_screen.dart` - ページ検出と自動抽出
- `lib/features/tts/presentation/playback_controller.dart` - 有効/無効制御
- `lib/features/tts/presentation/playback_controller_notifier.dart` - 小説読み上げ統合

## テスト計画

### ユニットテスト
- NarouUrlDetector の URL 判定テスト
- WebViewNotifier の小説ページ検出テスト
- NovelReaderNotifier の自動抽出テスト

### 統合テスト（手動）
- 小説ページに遷移 → 本文が自動抽出される
- TTSコントロールが有効化される
- 再生ボタンで読み上げ開始
- 非小説ページに遷移 → TTSコントロールが無効化される

## 予想される課題と対策

### 課題1: ページ読み込み完了のタイミング
- **問題**: JavaScript読み込みが完了する前に本文抽出を試みる可能性
- **対策**: 適切な遅延を追加、またはリトライロジックを実装

### 課題2: TTS再生中のページ遷移
- **問題**: 再生中に別ページに遷移すると状態が不整合になる
- **対策**: ページ遷移時に再生を自動停止

### 課題3: メモリリーク
- **問題**: 本文データを長時間保持するとメモリが増加
- **対策**: ページ遷移時に適切にクリア

## 成功基準

### 技術的基準
- [ ] `flutter analyze` でエラーなし
- [ ] すべてのテストが成功
- [ ] コード生成が正常に完了

### 機能的基準
- [ ] 小説ページに遷移すると自動的に本文が抽出される
- [ ] 小説ページでTTSコントロールが有効になる
- [ ] 非小説ページでTTSコントロールが無効になる
- [ ] 再生ボタンで小説を読み上げできる
- [ ] ページ遷移時に適切に状態がクリアされる

## 次のステップ（Issue #11への準備）

この Issue 完了後、Issue #11で以下を実装します：
- JavaScript Injection によるハイライト表示
- JavaScript Injection による自動スクロール
- 総合テストとUX改善

---

**作成者**: Claude (AI Assistant)
**承認**: 実施前にユーザー確認
