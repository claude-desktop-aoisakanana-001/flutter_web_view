# 技術選定書

**プロジェクト名**: 小説家になろうリーダーアプリ
**バージョン**: 1.0.0
**最終更新**: 2025-11-30
**ステータス**: 承認済み

---

## 1. 技術スタック概要

| カテゴリ | 選定技術 | バージョン |
|---------|---------|----------|
| フレームワーク | Flutter | 3.10.0+ |
| 言語 | Dart | 3.0.0+ |
| 状態管理 | Riverpod | 2.4.0+ |
| WebView | webview_flutter | 4.0.0+ |
| TTS | flutter_tts | 4.0.0+ |
| HTML解析 | html | 0.15.0+ |
| HTTP通信 | http | 1.0.0+ |

---

## 2. 必須パッケージ

### 2.1 コア機能パッケージ

#### webview_flutter
- **バージョン**: ^4.0.0
- **用途**: WebView表示（将来的な拡張用）
- **選定理由**:
  - Flutter公式プラグイン
  - iOS/Android両対応
  - MVPではHTTP直接取得を優先するが、将来的にWebView内表示を行う可能性あり
  - JavaScript実行機能も利用可能
- **ライセンス**: BSD-3-Clause

#### flutter_riverpod
- **バージョン**: ^2.4.0
- **用途**: 状態管理フレームワーク
- **選定理由**:
  - 型安全性が高い
  - テストが容易
  - コンパイル時の安全性
  - ボイラープレートが少ない
  - 学習コストが適切
  - コード生成によるさらなる簡潔化が可能
- **ライセンス**: MIT
- **関連パッケージ**:
  - `riverpod_annotation`: コード生成用アノテーション
  - `riverpod_generator`: コード生成ツール

#### flutter_tts
- **バージョン**: ^4.0.0
- **用途**: テキスト読み上げ（Text-to-Speech）
- **選定理由**:
  - iOS/Android両対応
  - 日本語音声に対応
  - 速度、ピッチ、音量などの詳細設定可能
  - コールバック機能で読み上げ位置を追跡可能
  - アクティブにメンテナンスされている
- **ライセンス**: MIT
- **プラットフォーム対応**:
  - iOS: AVSpeechSynthesizer
  - Android: TextToSpeech

#### html
- **バージョン**: ^0.15.0
- **用途**: HTML解析・パース
- **選定理由**:
  - Dart公式パッケージ
  - DOM操作が可能
  - セレクタによる要素検索
  - 小説家になろうの本文抽出に必要
- **ライセンス**: MIT

#### http
- **バージョン**: ^1.0.0
- **用途**: HTTP通信
- **選定理由**:
  - Dart公式パッケージ
  - シンプルで使いやすいAPI
  - 小説ページのHTML取得に使用（Option B採用）
  - 信頼性が高い
- **ライセンス**: BSD-3-Clause

---

## 3. 開発補助パッケージ

### 3.1 コード生成ツール

#### freezed
- **バージョン**: ^2.4.0
- **用途**: 不変データクラス生成
- **選定理由**:
  - copyWith メソッド自動生成
  - パターンマッチング対応
  - JSON シリアライズ対応
  - Union types サポート
  - ボイラープレート削減
- **ライセンス**: MIT

#### freezed_annotation
- **バージョン**: ^2.4.0
- **用途**: Freezed用アノテーション
- **ライセンス**: MIT

#### build_runner
- **バージョン**: ^2.4.0
- **用途**: Dartコード生成ツール
- **使用場面**:
  - freezed によるモデル生成
  - riverpod_generator によるProvider生成
- **ライセンス**: BSD-3-Clause

#### riverpod_generator
- **バージョン**: ^2.3.0
- **用途**: Riverpod Providerのコード生成
- **選定理由**:
  - ボイラープレートの削減
  - タイプセーフなProvider定義
  - 可読性の向上
- **ライセンス**: MIT

#### riverpod_annotation
- **バージョン**: ^2.3.0
- **用途**: Riverpod Generator用アノテーション
- **ライセンス**: MIT

---

## 4. オプション検討パッケージ

以下のパッケージは将来的な機能拡張時に検討：

### 4.1 データ永続化
- **shared_preferences**: ^2.2.0
  - 用途: 読み上げ速度などの設定保存
  - MVP範囲外だが、設定機能実装時に追加検討

### 4.2 ローカルストレージ
- **sqflite**: ^2.3.0
  - 用途: しおり機能、読書履歴の保存
  - MVP範囲外

### 4.3 ナビゲーション
- **go_router**: ^13.0.0
  - 用途: 画面遷移管理
  - MVPでは画面が少ないため、Navigator.pushで十分
  - 将来的に複雑化したら導入検討

---

## 5. 技術選定の理由詳細

### 5.1 WebView vs HTTP直接取得

**決定**: WebView内表示（Option A）を採用 ⚠️ **2025-11-30 更新**

| 項目 | WebView (Option A) | HTTP直接取得 (Option B) |
|------|-------------------|----------------------|
| 実装の複雑さ | 中程度 | 低い |
| パフォーマンス | レンダリングコスト有 | 軽量 |
| HTML取得の信頼性 | JavaScript実行が可能 | シンプルなGET |
| デバッグのしやすさ | 中程度 | 容易 |
| メモリ消費 | やや大きい | 小さい |
| 利用規約遵守 | ✓ 準拠 | ✗ 違反の可能性 |
| ユーザー体験 | 公式サイトと同等 | カスタマイズ可能 |

**採用理由（2025-11-30 更新）**:
- **最重要**: 小説家になろうの利用規約を遵守
  - コンテンツの自動スクレイピングは規約違反
  - WebView内での閲覧は公式サイトの利用と同等
- ユーザーが公式サイトを通じて小説を閲覧
- JavaScript実行やログイン状態の保持が可能
- 将来的な機能拡張に対応しやすい
- `webview_flutter` は Flutter 公式プラグインで信頼性が高い

**注意事項**:
- WebView からのDOM取得にはJavaScript Injectionを使用
- クロスプラットフォーム対応（iOS/Android）
- メモリ管理に注意が必要

### 5.2 状態管理: Riverpod

**他の候補との比較**:

| 状態管理 | 学習コスト | 型安全性 | テスト容易性 | ボイラープレート |
|---------|----------|---------|------------|--------------|
| setState | 低 | 低 | 低 | 少 |
| Provider | 中 | 中 | 中 | 中 |
| Riverpod | 中 | 高 | 高 | 少 |
| BLoC | 高 | 高 | 高 | 多 |
| Redux | 高 | 中 | 高 | 多 |

**採用理由**:
- 型安全性が高く、コンパイル時エラーで問題を早期発見
- テストが容易（依存性注入が簡単）
- コード生成でボイラープレートを削減可能
- 中規模〜大規模アプリに適している
- 学習コストは適切な範囲

### 5.3 TTS: flutter_tts

**他の候補との比較**:

| パッケージ | iOS対応 | Android対応 | 日本語対応 | 詳細設定 | メンテナンス |
|----------|--------|-----------|----------|---------|-----------|
| flutter_tts | ✓ | ✓ | ✓ | ✓ | アクティブ |
| text_to_speech | ✓ | ✓ | ✓ | △ | 停滞気味 |
| tts | △ | △ | ✓ | × | 古い |

**採用理由**:
- iOS/Android両対応
- 日本語音声が利用可能
- 速度、ピッチ、音量などの詳細設定が可能
- コールバック機能で読み上げ位置の追跡が可能（ハイライト機能に必要）
- アクティブにメンテナンスされている
- ドキュメントが充実

---

## 6. コード生成戦略

### 6.1 使用するコード生成

1. **Freezed**: データモデルの生成
   ```dart
   @freezed
   class NovelContent with _$NovelContent {
     const factory NovelContent({
       required String title,
       required String author,
       required List<String> paragraphs,
     }) = _NovelContent;
   }
   ```

2. **Riverpod Generator**: Provider生成
   ```dart
   @riverpod
   class TtsService extends _$TtsService {
     // コード生成でProviderが自動作成される
   }
   ```

### 6.2 コード生成コマンド

```bash
# 一度だけ実行
dart run build_runner build

# 監視モード（開発中）
dart run build_runner watch

# キャッシュクリア後に実行
dart run build_runner build --delete-conflicting-outputs
```

---

## 7. パッケージバージョン管理方針

### 7.1 バージョン指定ルール

- **Caret記法（^）を使用**: `^2.4.0`
  - マイナーバージョンとパッチバージョンの自動更新を許可
  - メジャーバージョンは固定（破壊的変更を避ける）

### 7.2 依存関係の更新

```bash
# 依存関係の最新バージョン確認
flutter pub outdated

# 依存関係の更新
flutter pub upgrade

# 特定パッケージのみ更新
flutter pub upgrade package_name
```

### 7.3 定期メンテナンス

- 月1回、依存関係の更新確認
- セキュリティアップデートは即座に適用
- メジャーバージョンアップは慎重に検討

---

## 8. pubspec.yaml 構成

```yaml
name: yomiagerun_app
description: "小説家になろうリーダーアプリ"
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.0.0

dependencies:
  flutter:
    sdk: flutter

  # UI
  cupertino_icons: ^1.0.8

  # 状態管理
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0

  # WebView（将来的な拡張用）
  webview_flutter: ^4.0.0

  # TTS
  flutter_tts: ^4.0.0

  # HTTP & HTML解析
  http: ^1.0.0
  html: ^0.15.0

  # データモデル
  freezed_annotation: ^2.4.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

  # コード生成
  build_runner: ^2.4.0
  freezed: ^2.4.0
  riverpod_generator: ^2.3.0
```

---

## 9. ライセンス一覧

| パッケージ | ライセンス | 商用利用 |
|-----------|----------|---------|
| flutter | BSD-3-Clause | ✓ |
| flutter_riverpod | MIT | ✓ |
| flutter_tts | MIT | ✓ |
| webview_flutter | BSD-3-Clause | ✓ |
| html | MIT | ✓ |
| http | BSD-3-Clause | ✓ |
| freezed | MIT | ✓ |

**結論**: すべてのパッケージが商用利用可能なライセンス

---

## 10. プラットフォーム互換性

### 10.1 iOS
- **最小バージョン**: iOS 12.0+
- **推奨バージョン**: iOS 15.0+
- **TTS**: AVSpeechSynthesizer使用
- **WebView**: WKWebView使用

### 10.2 Android（将来対応）
- **最小バージョン**: Android 5.0 (API 21)+
- **推奨バージョン**: Android 10.0 (API 29)+
- **TTS**: Android TextToSpeech使用
- **WebView**: WebView使用

---

## 11. セキュリティ考慮事項

### 11.1 依存関係のセキュリティ

```bash
# パッケージの脆弱性スキャン（将来のDartバージョンで利用可能）
flutter pub audit
```

### 11.2 ネットワーク通信

- **HTTPS通信**: 小説家になろうはHTTPS対応
- **証明書検証**: デフォルトで有効
- **タイムアウト設定**: 適切なタイムアウトを設定

### 11.3 データ保護

- ユーザーデータは端末内のみに保存
- 外部サーバーへの送信なし
- キャッシュデータの適切な管理

---

## 12. パフォーマンス考慮事項

### 12.1 メモリ使用量

- HTML解析後は必要な部分のみメモリに保持
- 大きな小説の場合は分割読み込みを検討

### 12.2 バッテリー消費

- TTS実行中はWake Lockを適切に管理
- バックグラウンド時の処理を最小化

---

## 13. 変更履歴

| 日付 | バージョン | 変更内容 |
|------|----------|---------|
| 2025-11-30 | 1.0.0 | 初版作成。HTTP直接取得（Option B）を仮採用、パッケージ一覧確定 |
| 2025-11-30 | 1.1.0 | **重要な変更**: WebView内表示（Option A）に変更。利用規約調査により、HTTP直接スクレイピングは規約違反と判明。WebView採用により利用規約を遵守 |

---

## 14. 承認

- **作成者**: Claude (AI Assistant)
- **レビュー**: ユーザー承認済み
- **承認日**: 2025-11-30
