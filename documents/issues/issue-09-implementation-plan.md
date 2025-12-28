# Issue-09 実施計画

**作成日**: 2025-12-27
**担当**: Claude (AI Assistant)
**見積もり**: 3時間

---

## 実施する内容の概要

アプリをWebViewベースのブラウザとして再構成し、小説家になろうサイトを直接閲覧できるようにします。URL入力フィールドを削除し、アプリ起動時に小説家になろうのトップページを表示します。下部にTTSコントロール（速度設定 + 再生コントローラー）を配置し、「サイトUI拡張」としての基本体験を確立します。

## 実施手順

### ステップ1: WebViewState モデルの作成（30分）

**ファイル**: `lib/features/novel_reader/domain/models/webview_state.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'webview_state.freezed.dart';

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

**実施内容**:
- Freezed を使用した immutable な状態モデル
- WebView の現在のURL、読み込み状態、ナビゲーション可否を管理
- コード生成: `dart run build_runner build --delete-conflicting-outputs`

### ステップ2: WebViewNotifier の作成（45分）

**ファイル**: `lib/features/novel_reader/application/webview_notifier.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/models/webview_state.dart';

part 'webview_notifier.g.dart';

@riverpod
class WebViewNotifier extends _$WebViewNotifier {
  @override
  WebViewState build() {
    return const WebViewState();
  }

  void onPageStarted(String url) {
    state = state.copyWith(
      currentUrl: url,
      isLoading: true,
    );
  }

  void onPageFinished(String url) {
    state = state.copyWith(
      currentUrl: url,
      isLoading: false,
    );
  }

  void updateNavigationState({
    required bool canGoBack,
    required bool canGoForward,
  }) {
    state = state.copyWith(
      canGoBack: canGoBack,
      canGoForward: canGoForward,
    );
  }

  void onError(String errorMessage) {
    state = state.copyWith(isLoading: false);
    // エラーハンドリングは将来拡張
  }
}
```

**実施内容**:
- Riverpod Notifier でWebViewの状態を管理
- ページ読み込み開始/完了のコールバック処理
- ナビゲーション状態（戻る/進む可否）の更新
- コード生成: `dart run build_runner build --delete-conflicting-outputs`

### ステップ3: NovelReaderScreen の大幅変更（60分）

**ファイル**: `lib/features/novel_reader/presentation/novel_reader_screen.dart`

**変更内容**:
1. **URL入力UIのコメントアウト**
   - `TextEditingController _urlController` をコメントアウト
   - URL入力フィールドとボタンをコメントアウト
   - `_loadUrl()` メソッドをコメントアウト

2. **WebViewController の追加**
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

3. **コールバックメソッドの実装**
   ```dart
   void _onPageStarted(String url) {
     ref.read(webViewNotifierProvider.notifier).onPageStarted(url);
   }

   void _onPageFinished(String url) async {
     ref.read(webViewNotifierProvider.notifier).onPageFinished(url);

     // ナビゲーション状態を更新
     final canGoBack = await _controller.canGoBack();
     final canGoForward = await _controller.canGoForward();
     ref.read(webViewNotifierProvider.notifier).updateNavigationState(
       canGoBack: canGoBack,
       canGoForward: canGoForward,
     );
   }

   void _onError(WebResourceError error) {
     ref.read(webViewNotifierProvider.notifier).onError(error.description);
   }
   ```

4. **レイアウトの変更**
   ```dart
   @override
   Widget build(BuildContext context) {
     final webViewState = ref.watch(webViewNotifierProvider);

     return Scaffold(
       appBar: AppBar(
         title: const Text('よみあげRun'),
         actions: [
           IconButton(
             icon: const Icon(Icons.settings),
             onPressed: () {
               // 設定画面（将来実装）
             },
           ),
         ],
       ),
       body: Column(
         children: [
           // ローディングインジケーター
           if (webViewState.isLoading)
             const LinearProgressIndicator(),

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

5. **NovelContentView の非表示化**
   - `NovelContentView()` の呼び出しをコメントアウト
   - import 文は残す（将来削除）

### ステップ4: テストの更新（30分）

**ファイル**: `test/features/novel_reader/presentation/novel_reader_screen_test.dart`

**更新内容**:
1. URL入力関連のテストをスキップ
   ```dart
   testWidgets('URL input is hidden', (tester) async {
     await tester.pumpWidget(
       ProviderScope(
         child: MaterialApp(home: NovelReaderScreen()),
       ),
     );

     // URL入力フィールドが存在しないことを確認
     expect(find.byType(TextField), findsNothing);
     expect(find.text('読み込み'), findsNothing);
   });
   ```

2. WebViewウィジェットの存在確認
   ```dart
   testWidgets('WebView is displayed', (tester) async {
     await tester.pumpWidget(
       ProviderScope(
         child: MaterialApp(home: NovelReaderScreen()),
       ),
     );

     // WebViewウィジェットが存在することを確認
     expect(find.byType(WebViewWidget), findsOneWidget);
   });
   ```

3. コントロールパネルの配置確認
   ```dart
   testWidgets('TTS controls are displayed at bottom', (tester) async {
     await tester.pumpWidget(
       ProviderScope(
         child: MaterialApp(home: NovelReaderScreen()),
       ),
     );

     // SpeedSettings と PlaybackController が表示されることを確認
     expect(find.byType(SpeedSettings), findsOneWidget);
     expect(find.byType(PlaybackController), findsOneWidget);
   });
   ```

**ファイル**: `test/widget_test.dart`

**更新内容**:
- URL入力関連の期待値を削除
- WebView表示の確認を追加

### ステップ5: WebViewNotifier のテスト作成（15分）

**ファイル**: `test/features/novel_reader/application/webview_notifier_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yomiagerun_app/features/novel_reader/application/webview_notifier.dart';

void main() {
  group('WebViewNotifier', () {
    test('initial state is correct', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(webViewNotifierProvider);

      expect(state.currentUrl, '');
      expect(state.isLoading, false);
      expect(state.canGoBack, false);
      expect(state.canGoForward, false);
    });

    test('onPageStarted updates state correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(webViewNotifierProvider.notifier);
      notifier.onPageStarted('https://syosetu.com/');

      final state = container.read(webViewNotifierProvider);
      expect(state.currentUrl, 'https://syosetu.com/');
      expect(state.isLoading, true);
    });

    test('onPageFinished updates state correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(webViewNotifierProvider.notifier);
      notifier.onPageStarted('https://syosetu.com/');
      notifier.onPageFinished('https://syosetu.com/');

      final state = container.read(webViewNotifierProvider);
      expect(state.isLoading, false);
    });

    test('updateNavigationState updates state correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(webViewNotifierProvider.notifier);
      notifier.updateNavigationState(canGoBack: true, canGoForward: false);

      final state = container.read(webViewNotifierProvider);
      expect(state.canGoBack, true);
      expect(state.canGoForward, false);
    });
  });
}
```

## 影響範囲

### 新規作成
- `lib/features/novel_reader/domain/models/webview_state.dart`
- `lib/features/novel_reader/application/webview_notifier.dart`
- `test/features/novel_reader/application/webview_notifier_test.dart`

### 修正
- `lib/features/novel_reader/presentation/novel_reader_screen.dart` - 大幅変更
- `test/features/novel_reader/presentation/novel_reader_screen_test.dart` - 大幅修正
- `test/widget_test.dart` - 軽微な修正

### コメントアウト（削除はしない）
- URL入力関連のUI（`TextField`, `_loadUrl()` など）
- `NovelContentView()` の呼び出し

### コード生成ファイル（自動生成）
- `lib/features/novel_reader/domain/models/webview_state.freezed.dart`
- `lib/features/novel_reader/application/webview_notifier.g.dart`

## テスト計画

### ユニットテスト
- ✅ `WebViewNotifier` の状態管理テスト
  - 初期状態の確認
  - `onPageStarted` のテスト
  - `onPageFinished` のテスト
  - `updateNavigationState` のテスト

### ウィジェットテスト
- ✅ `NovelReaderScreen` のレイアウトテスト
  - WebViewウィジェットの存在確認
  - TTSコントロールパネルの配置確認
  - URL入力フィールドが存在しないことの確認
  - ローディングインジケーターの表示確認

### 手動テスト（実機またはシミュレーター）
- ✅ アプリ起動時に小説家になろうのトップページが表示される
- ✅ WebView内でリンクをクリックしてページ遷移できる
- ✅ ページ読み込み中にローディングインジケーターが表示される
- ✅ TTSコントロールが下部に固定表示される

## 予想される課題と対策

### 課題1: WebView のプラットフォーム実装
- **問題**: テスト環境でWebViewのプラットフォーム実装がない
- **対策**: ウィジェットテストではモックを使用、または `skip: true` を使用

### 課題2: 既存テストの失敗
- **問題**: URL入力を前提としたテストが失敗する
- **対策**: 該当テストを更新またはスキップマークを付ける

### 課題3: NovelContentView の参照
- **問題**: コメントアウト後も import が残り、未使用警告が出る可能性
- **対策**: import は残す（将来削除するため）、警告は許容

## 予想作業時間

| タスク | 見積もり |
|--------|---------|
| WebViewState モデル作成 | 30分 |
| WebViewNotifier 作成 | 45分 |
| NovelReaderScreen 変更 | 60分 |
| テストの更新 | 30分 |
| WebViewNotifier テスト作成 | 15分 |
| **合計** | **3時間** |

## 成功基準

### 技術的基準
- [ ] `flutter analyze` でエラーなし
- [ ] すべてのテストが成功（スキップしたものを除く）
- [ ] コード生成が正常に完了

### 機能的基準
- [ ] アプリ起動時に `https://syosetu.com/` が表示される
- [ ] WebView内でリンクをクリックしてページ遷移できる
- [ ] ページ読み込み中にローディングインジケーターが表示される
- [ ] TTSコントロール（SpeedSettings + PlaybackController）が下部に表示される

### UX基準
- [ ] URL入力フィールドが表示されない
- [ ] NovelContentView が表示されない
- [ ] アプリが「ブラウザ」として機能する

## 次のステップ（Issue #10への準備）

この Issue 完了後、Issue #10で以下を実装します：
- 小説ページURLの検出（`ncode.syosetu.com/nXXXX/Y/`）
- TTSコントロールの有効/無効の自動切り替え
- 小説本文の自動抽出

そのため、現時点では：
- TTSコントロールは常時表示（有効/無効は問わない）
- ページ検出機能は実装しない
- 本文抽出は実装しない

---

**作成者**: Claude (AI Assistant)
**承認**: 実施前にユーザー確認
