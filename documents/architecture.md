# アーキテクチャ設計書

**プロジェクト名**: 小説家になろうリーダーアプリ
**バージョン**: 1.0.0
**最終更新**: 2025-11-30
**ステータス**: 承認済み

---

## 1. アーキテクチャ概要

### 1.1 アーキテクチャスタイル

**レイヤードアーキテクチャ + Feature-First構成**

- 機能（Feature）ごとにディレクトリを分割
- 各機能内で Presentation / Application / Domain の3層構造
- 状態管理は Riverpod によるリアクティブなデータフロー

### 1.2 設計原則

1. **シンプルさ優先**: 過度な抽象化を避ける
2. **小説家になろう専用**: 汎用性より最適化を優先
3. **自然な拡張性**: 過度な設計はしないが、自然な拡張は許容
4. **テスト容易性**: Riverpod による依存性注入でテストしやすく

---

## 2. ディレクトリ構造

```
lib/
├── main.dart                              # エントリーポイント
├── app/                                  # アプリケーション層
│   ├── app.dart                          # AppWidget（ルートウィジェット）
│   └── router.dart                       # ルーティング設定（将来的に拡張）
├── features/                             # 機能別ディレクトリ
│   ├── novel_reader/                     # 小説閲覧・読み上げ機能
│   │   ├── presentation/                # Presentation層（UI）
│   │   │   ├── novel_reader_screen.dart # メイン画面
│   │   │   └── widgets/                 # ウィジェット
│   │   │       ├── playback_controller.dart  # 再生コントローラー
│   │   │       ├── novel_content_view.dart   # 本文表示
│   │   │       └── speed_settings.dart       # 速度設定UI
│   │   ├── application/                 # Application層（ビジネスロジック）
│   │   │   ├── novel_reader_state.dart  # 状態定義（Freezed）
│   │   │   ├── novel_reader_notifier.dart    # 状態管理（Riverpod）
│   │   │   └── playback_controller.dart      # 再生制御ロジック
│   │   └── domain/                      # Domain層（モデル）
│   │       └── models/
│   │           ├── novel_content.dart   # 小説コンテンツモデル
│   │           └── playback_state.dart  # 再生状態モデル
│   ├── tts/                             # TTS（音声合成）機能
│   │   ├── application/
│   │   │   ├── tts_service.dart         # TTSサービス（Riverpod）
│   │   │   └── tts_state.dart           # TTS状態定義
│   │   └── domain/
│   │       └── models/
│   │           └── tts_config.dart      # TTS設定モデル
│   └── html_parser/                     # HTML解析機能
│       ├── application/
│       │   └── narou_parser_service.dart     # 小説家になろうパーサー
│       └── domain/
│           └── models/
│               └── parsed_novel.dart    # 解析結果モデル
└── shared/                              # 共通コンポーネント
    ├── widgets/                         # 共通ウィジェット
    │   ├── error_view.dart              # エラー表示
    │   └── loading_view.dart            # ローディング表示
    ├── utils/                           # ユーティリティ
    │   ├── logger.dart                  # ロガー
    │   └── constants.dart               # 定数定義
    └── extensions/                      # 拡張メソッド
        └── string_extensions.dart       # String拡張
```

---

## 3. レイヤー詳細

### 3.1 Presentation層（UI）

**責務**:
- ユーザーインターフェースの表示
- ユーザー入力の受け取り
- Application層の状態を監視して表示を更新

**主要コンポーネント**:

#### NovelReaderScreen
```dart
class NovelReaderScreen extends ConsumerWidget {
  // 小説閲覧画面のメインウィジェット
  // - NovelContentView（本文表示）
  // - PlaybackController（再生コントローラー）
  // - SpeedSettings（速度設定）
  // を組み合わせて構成
}
```

#### PlaybackController
```dart
class PlaybackController extends ConsumerWidget {
  // 再生/一時停止/停止のコントロールUI
  // - 再生ボタン
  // - 一時停止ボタン
  // - 停止ボタン
  // - 現在の再生状態表示
}
```

#### NovelContentView
```dart
class NovelContentView extends ConsumerWidget {
  // 小説本文の表示
  // - テキスト表示
  // - ハイライト表示（読み上げ中の文章）
  // - 自動スクロール
}
```

### 3.2 Application層（ビジネスロジック）

**責務**:
- ビジネスロジックの実装
- 状態管理
- Domain層とPresentation層の橋渡し

**主要コンポーネント**:

#### NovelReaderNotifier
```dart
@riverpod
class NovelReaderNotifier extends _$NovelReaderNotifier {
  // 小説閲覧の状態管理
  // - 現在表示中の小説データ
  // - 読み上げ位置
  // - スクロール位置

  Future<void> loadNovel(String url);
  Future<void> startReading();
  void pauseReading();
  void stopReading();
  void updateHighlightPosition(int position);
}
```

#### TtsService
```dart
@riverpod
class TtsService extends _$TtsService {
  // TTS機能のサービス
  // - flutter_tts のラッパー
  // - 読み上げの開始/停止/一時停止
  // - 読み上げ位置のコールバック
  // - 設定の適用

  Future<void> speak(String text);
  Future<void> pause();
  Future<void> stop();
  void setSpeed(double speed);
  void setConfig(TTSConfig config);
}
```

#### NarouParserService
```dart
@riverpod
class NarouParserService extends _$NarouParserService {
  // 小説家になろうのHTML解析
  // - URLから小説データを取得
  // - HTMLをパースして本文を抽出
  // - ParsedNovelモデルに変換

  Future<ParsedNovel> parseFromUrl(String url);
}
```

### 3.3 Domain層（ドメインモデル）

**責務**:
- ビジネスドメインの概念をモデル化
- 不変データ構造（Freezed使用）
- ビジネスルールのカプセル化

**主要モデル**:

#### NovelContent
```dart
@freezed
class NovelContent with _$NovelContent {
  const factory NovelContent({
    required String title,           // 小説タイトル
    required String author,          // 作者名
    required String url,             // 元URL
    required List<String> paragraphs, // 段落ごとのテキスト
    DateTime? fetchedAt,            // 取得日時
  }) = _NovelContent;

  factory NovelContent.fromJson(Map<String, dynamic> json)
      => _$NovelContentFromJson(json);
}
```

#### PlaybackState
```dart
@freezed
class PlaybackState with _$PlaybackState {
  const factory PlaybackState({
    @Default(false) bool isPlaying,        // 再生中か
    @Default(0) int currentPosition,       // 現在の読み上げ位置
    @Default(0) int totalLength,           // 全体の長さ
    String? currentText,                   // 現在読み上げ中のテキスト
  }) = _PlaybackState;
}
```

#### TTSConfig
```dart
@freezed
class TTSConfig with _$TTSConfig {
  const factory TTSConfig({
    @Default(1.0) double speed,           // 読み上げ速度（MVP）
    @Default(1.0) double pitch,           // 音程（将来対応）
    @Default(1.0) double volume,          // 音量（将来対応）
    @Default(0.0) double linePause,       // 行間の間隔（将来対応）
    @Default(0.0) double paragraphPause,  // 段落間の間隔（将来対応）
  }) = _TTSConfig;

  factory TTSConfig.fromJson(Map<String, dynamic> json)
      => _$TTSConfigFromJson(json);
}
```

#### ParsedNovel
```dart
@freezed
class ParsedNovel with _$ParsedNovel {
  const factory ParsedNovel({
    required String title,
    required String author,
    required List<String> paragraphs,
    Map<String, String>? metadata,  // 追加メタデータ
  }) = _ParsedNovel;
}
```

---

## 4. データフロー

### 4.1 小説読み込みから読み上げまでのフロー ⚠️ **2025-11-30 更新**

```
1. ユーザーがURLを入力
    ↓
2. NovelReaderNotifier.loadNovel(url)
    ↓
3. NarouParserService.parseFromWebView(url)
    ↓
    3-1. WebViewController でページを読み込み
    ↓
    3-2. ページ読み込み完了を待機
    ↓
    3-3. JavaScript Injection でDOMから情報を取得
         - document.querySelector('.novel_title')
         - document.querySelector('#novel_honbun p')
         - など
    ↓
    3-4. JSON形式で結果を受け取り
    ↓
    3-5. ParsedNovelモデルに変換
    ↓
4. NovelContentに変換して状態に保存
    ↓
5. UI（NovelContentView）で本文を表示
    ↓
6. ユーザーが再生ボタンをタップ
    ↓
7. NovelReaderNotifier.startReading()
    ↓
8. TtsService.speak(text)
    ↓
9. flutter_ttsで読み上げ開始
    ↓
10. 読み上げ位置のコールバック
    ↓
11. NovelReaderNotifier.updateHighlightPosition(position)
    ↓
12. UI（NovelContentView）でハイライト表示 + 自動スクロール
```

**WebView使用時の追加考慮事項**:
- WebView の初期化は起動時に一度だけ実行
- JavaScript Bridge の設定
- メモリリーク防止のための適切なライフサイクル管理

### 4.2 状態管理のフロー

```
Provider (Riverpod)
    ↓
ConsumerWidget が監視
    ↓
状態変更時に自動的に rebuild
    ↓
UIが更新される
```

---

## 5. 主要な設計判断

### 5.1 Feature-First vs Layer-First

**採用**: Feature-First

**理由**:
- 機能ごとにコードがまとまり、可読性が高い
- 機能の追加・削除が容易
- チーム開発でのコンフリクトが減少
- 小規模〜中規模アプリに適している

### 5.2 状態管理アーキテクチャ

**採用**: Riverpod with Code Generation

**パターン**:
```dart
// Provider定義（コード生成）
@riverpod
class NovelReaderNotifier extends _$NovelReaderNotifier {
  @override
  NovelReaderState build() {
    return const NovelReaderState();
  }

  // ビジネスロジック
}

// UI側で使用
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(novelReaderNotifierProvider);
    // UIを構築
  }
}
```

### 5.3 HTML解析戦略 ⚠️ **2025-11-30 更新**

**アプローチ**: WebView + JavaScript Injection による DOM取得

```dart
class NarouParserService {
  final WebViewController _webViewController;

  Future<ParsedNovel> parseFromWebView(String url) async {
    // 1. WebView でページを読み込み
    await _webViewController.loadRequest(Uri.parse(url));

    // 2. ページ読み込み完了を待機
    await _waitForPageLoad();

    // 3. JavaScript を実行して DOM から情報を取得
    final title = await _webViewController.runJavaScriptReturningResult(
      "document.querySelector('.novel_title')?.textContent || ''",
    ) as String;

    final author = await _webViewController.runJavaScriptReturningResult(
      "document.querySelector('.novel_writername')?.textContent || ''",
    ) as String;

    final paragraphsJson = await _webViewController.runJavaScriptReturningResult(
      """
      JSON.stringify(
        Array.from(document.querySelectorAll('#novel_honbun p'))
          .map(p => p.textContent.trim())
      )
      """,
    ) as String;
    final paragraphs = (jsonDecode(paragraphsJson) as List).cast<String>();

    // 4. モデルに変換
    return ParsedNovel(
      title: title,
      author: author,
      paragraphs: paragraphs,
    );
  }

  Future<void> _waitForPageLoad() async {
    // ページ読み込み完了の検出ロジック
    // JavaScript の document.readyState を監視
  }
}
```

**利点**:
- **利用規約を遵守**: 公式サイトを通じた閲覧
- JavaScript実行済みのDOMにアクセス可能
- ログイン状態の保持が可能
- 動的コンテンツにも対応

**注意点**:
- WebView の初期化とライフサイクル管理が必要
- JavaScript 実行の非同期処理に注意
- メモリ使用量がHTTP直接取得より大きい
- セレクタはHTML構造に依存するため、サイトの変更に脆弱

---

## 6. ハイライトと自動スクロールの実装方針

### 6.1 ハイライト表示

**アプローチ**: RichText + TextSpan

```dart
class NovelContentView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(novelReaderNotifierProvider);
    final highlightPosition = state.currentPosition;

    return RichText(
      text: TextSpan(
        children: _buildHighlightedText(
          state.novelContent.paragraphs,
          highlightPosition,
        ),
      ),
    );
  }

  List<TextSpan> _buildHighlightedText(
    List<String> paragraphs,
    int highlightPosition,
  ) {
    // 現在読み上げ中の部分だけ背景色を変更
    // TextSpanでスタイルを適用
  }
}
```

### 6.2 自動スクロール

**アプローチ**: ScrollController + animateTo

```dart
class NovelContentView extends ConsumerStatefulWidget {
  @override
  ConsumerState<NovelContentView> createState() => _State();
}

class _State extends ConsumerState<NovelContentView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 読み上げ位置の変更を監視
    ref.listenManual(
      novelReaderNotifierProvider.select((s) => s.currentPosition),
      (prev, next) {
        _scrollToPosition(next);
      },
    );
  }

  void _scrollToPosition(int position) {
    // positionに基づいてスクロール位置を計算
    final offset = _calculateOffset(position);

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
```

---

## 7. エラーハンドリング戦略

### 7.1 エラーの種類

1. **ネットワークエラー**: HTTP通信失敗
2. **パースエラー**: HTML構造が想定と異なる
3. **TTSエラー**: 音声合成の初期化失敗

### 7.2 エラーハンドリングパターン

```dart
@freezed
class NovelReaderState with _$NovelReaderState {
  const factory NovelReaderState({
    NovelContent? novelContent,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _NovelReaderState;
}

// Notifier内でのエラーハンドリング
class NovelReaderNotifier extends _$NovelReaderNotifier {
  Future<void> loadNovel(String url) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final parsed = await ref.read(narouParserServiceProvider).parseFromUrl(url);
      final content = NovelContent(/* ... */);
      state = state.copyWith(novelContent: content, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
    }
  }
}

// UI側でのエラー表示
class NovelReaderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(novelReaderNotifierProvider);

    if (state.errorMessage != null) {
      return ErrorView(message: state.errorMessage!);
    }

    // 通常の表示
  }
}
```

---

## 8. テスト戦略

### 8.1 単体テスト

**対象**:
- Domain層のモデル
- Application層のロジック
- HTML解析ロジック

**例**:
```dart
void main() {
  group('NarouParserService', () {
    test('should parse novel content correctly', () async {
      final service = NarouParserService();
      final html = '''
        <div class="novel_title">テストタイトル</div>
        <div class="novel_author">テスト作者</div>
        <div class="novel_text">
          <p>第一段落</p>
          <p>第二段落</p>
        </div>
      ''';

      final result = service.parseHtml(html);

      expect(result.title, 'テストタイトル');
      expect(result.paragraphs.length, 2);
    });
  });
}
```

### 8.2 ウィジェットテスト

**対象**:
- Presentation層のウィジェット
- ユーザーインタラクション

**例**:
```dart
void main() {
  testWidgets('PlaybackController should toggle play/pause', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: PlaybackController()),
      ),
    );

    // 再生ボタンをタップ
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();

    // 一時停止ボタンが表示されることを確認
    expect(find.byIcon(Icons.pause), findsOneWidget);
  });
}
```

### 8.3 統合テスト

**対象**:
- エンドツーエンドのフロー
- 実機での動作確認

---

## 9. パフォーマンス最適化

### 9.1 メモリ管理

- 大きな小説の場合、全文をメモリに保持せず、章ごとに分割
- 画面外のウィジェットは適切に破棄

### 9.2 UI最適化

- `const` コンストラクタを積極的に使用
- 不要な rebuild を避ける（Riverpod の select 使用）
- ListView.builder で効率的なリスト表示

### 9.3 ネットワーク最適化

- タイムアウト設定
- キャッシュ戦略（将来的に検討）

---

## 10. セキュリティ考慮事項

### 10.1 HTTPS通信

- すべてのHTTP通信はHTTPSを使用
- 証明書検証を有効化

### 10.2 入力検証

- URLの妥当性チェック
- HTML injection対策（表示時にサニタイズ）

---

## 11. 将来の拡張性

### 11.1 拡張ポイント

1. **WebView表示**: HTTP直接取得からWebView内表示への切り替え
2. **データ永続化**: shared_preferences, sqflite の追加
3. **しおり機能**: 読書位置の保存
4. **お気に入り**: 小説のブックマーク
5. **Android対応**: プラットフォーム固有の実装

### 11.2 拡張時の注意点

- 既存のインターフェースを壊さない
- 新機能は新しいFeatureディレクトリに追加
- 共通化できる部分は shared/ に移動

---

## 12. 変更履歴

| 日付 | バージョン | 変更内容 |
|------|----------|---------|
| 2025-11-30 | 1.0.0 | 初版作成。HTTP直接取得を前提としたアーキテクチャ |
| 2025-11-30 | 1.1.0 | **重要な変更**: WebView + JavaScript Injection方式に変更。HTML解析戦略とデータフローを更新。利用規約遵守のため |

---

## 13. 承認

- **作成者**: Claude (AI Assistant)
- **レビュー**: ユーザー承認済み
- **承認日**: 2025-11-30
