# よみあげRun (Yomiage Run)

「小説家になろう」専用の読み上げブラウザアプリ

## 概要

**よみあげRun** は、Flutter を使用したクロスプラットフォーム対応の Web小説読み上げアプリです。
WebView ベースのブラウザとして「小説家になろう」サイトを閲覧しながら、Text-to-Speech (TTS) 機能で小説を音声で楽しむことができます。

### 主な特徴

- 📱 **クロスプラットフォーム対応**: Android、iOS、macOS、Windows、Linux、Web
- 🌐 **WebViewブラウザ**: 小説家になろうサイトをそのまま表示
- 🎙️ **自動読み上げ**: 小説ページで自動的に TTS 機能が有効化
- ✨ **ハイライト表示**: 読み上げ中の段落を視覚的にハイライト
- 📜 **自動スクロール**: 読み上げ位置に自動的にスクロール
- ⚡ **速度調整**: 読み上げ速度を 0.5x ～ 2.0x の範囲で調整可能

## 動作環境

- **Flutter SDK**: 3.10.0+
- **Dart**: 3.10.0+
- **プラットフォーム**: Android、iOS、macOS、Windows、Linux、Web

## インストール

### 依存関係のインストール

```bash
flutter pub get
```

### コード生成（Freezed & Riverpod）

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 使い方

### アプリの起動

```bash
flutter run
```

### 基本的な使い方

1. **アプリ起動** - 「小説家になろう」のトップページが表示されます
2. **小説を探す** - WebView 内で自由にブラウジングして小説を探します
3. **小説ページへ** - 読みたい小説のページへ移動します
4. **自動検出** - 小説ページに到達すると、TTS コントロールが自動的に有効化されます
5. **再生開始** - 再生ボタンをタップすると、小説の読み上げが開始されます
6. **ハイライト** - 現在読み上げ中の段落が黄色でハイライト表示されます
7. **自動スクロール** - 読み上げ位置が画面中央に表示されるよう自動スクロールされます

### コントロール

- **再生ボタン** - 読み上げを開始（小説ページでのみ有効）
- **一時停止ボタン** - 読み上げを一時停止
- **停止ボタン** - 読み上げを停止してハイライトをクリア
- **速度スライダー** - 読み上げ速度を調整（0.5x ～ 2.0x）

## 技術仕様

### アーキテクチャ

- **状態管理**: Riverpod (Code Generation)
- **不変データ**: Freezed
- **WebView**: webview_flutter
- **TTS**: flutter_tts
- **アーキテクチャ**: Feature-first + Layered Architecture

### プロジェクト構造

```
lib/
├── main.dart                                    # エントリーポイント
├── features/
│   ├── novel_reader/                          # 小説リーダー機能
│   │   ├── presentation/                      # UI レイヤー
│   │   │   └── novel_reader_screen.dart      # メイン画面
│   │   ├── application/                       # アプリケーションロジック
│   │   │   ├── novel_reader_notifier.dart    # 小説データ管理
│   │   │   ├── webview_notifier.dart         # WebView 状態管理
│   │   │   └── javascript_injector.dart      # JavaScript Injection
│   │   └── domain/                            # ドメインモデル
│   │       └── models/                        # データモデル
│   ├── html_parser/                           # HTML パーサー
│   │   └── application/
│   │       ├── narou_parser_service.dart     # 小説家になろうパーサー
│   │       └── narou_url_detector.dart       # URL パターン検出
│   └── tts/                                   # TTS 機能
│       ├── presentation/                      # TTS UI
│       │   ├── playback_controller.dart      # 再生コントローラー
│       │   └── speed_settings.dart           # 速度設定
│       ├── application/                       # TTS ロジック
│       │   └── tts_service.dart              # TTS サービス
│       └── domain/                            # TTS ドメイン
│           └── models/                        # TTS モデル
```

### 主要機能の実装

#### 小説ページ自動検出（Issue #10）

WebView の URL を監視し、以下のパターンで小説ページを自動検出：

- 連載小説: `https://ncode.syosetu.com/nXXXX/Y/`
- 短編小説: `https://ncode.syosetu.com/nXXXX/`

検出されると、自動的に小説本文を抽出して TTS 機能を有効化します。

#### JavaScript Injection によるハイライト（Issue #11）

```javascript
// ハイライト表示
const paragraphs = document.querySelectorAll('#novel_honbun p');
paragraphs[index].classList.add('tts-highlight');
paragraphs[index].scrollIntoView({ behavior: 'smooth', block: 'center' });
```

現在読み上げ中の段落に CSS クラスを追加し、黄色の半透明背景でハイライト表示します。

## 開発

### コードフォーマット

```bash
flutter format lib/ test/
```

### 静的解析

```bash
flutter analyze
```

### テストの実行

```bash
flutter test
```

**注意**: WebView のプラットフォーム実装はテスト環境で利用できないため、一部のテストは `skip: true` でスキップされています。

### ビルド

#### Android

```bash
flutter build apk         # APK
flutter build appbundle   # App Bundle
```

#### iOS

```bash
flutter build ios
```

#### Web

```bash
flutter build web
```

#### デスクトップ

```bash
flutter build macos    # macOS
flutter build windows  # Windows
flutter build linux    # Linux
```

## iOS ビルドパイプライン

このプロジェクトには GitHub Actions を使用した自動 iOS ビルドパイプラインが含まれています。**Mac や Xcode は不要です！**

### 機能

- GitHub Actions macOS ランナーによる自動ビルド
- Fastlane による証明書とプロビジョニングプロファイル管理
- App Store Connect API 認証
- IPA の自動生成とアーティファクトアップロード

### セットアップ

詳細なセットアップガイドは以下を参照してください：

**[iOS Build Setup Guide](.github/workflows/IOS_BUILD_SETUP.md)**

必要なもの：
- Apple Developer Program アカウント（$99/年）
- App Store Connect API Key
- GitHub リポジトリシークレット設定

### クイックスタート

1. App Store Connect API Key を作成
2. GitHub Secrets を設定（セットアップガイド参照）
3. 変更をプッシュしてワークフローをトリガー
4. GitHub Actions アーティファクトから IPA をダウンロード

## MVP 完成状況

### 実装済み機能

- [x] WebView ベースのブラウザ実装
- [x] 小説家になろうサイトの表示
- [x] 小説ページの自動検出
- [x] 小説本文の自動抽出
- [x] TTS による読み上げ機能
- [x] 読み上げ速度調整
- [x] ハイライト表示（JavaScript Injection）
- [x] 自動スクロール（JavaScript Injection）
- [x] ページ遷移時の適切な動作
- [x] 統合テスト

### 既知の問題・制限事項

- WebView の実装はテスト環境で利用できないため、一部のテストはスキップされています
- 小説家になろう以外のサイトには対応していません
- 現在は段落単位での読み上げのみサポート（文単位の細かい制御は未実装）

### 将来の拡張予定

- しおり機能（読書位置の保存）
- お気に入り小説のブックマーク
- オフライン閲覧機能
- 他の小説サイトへの対応
- 音声のカスタマイズ（音程、性別など）
- ダークモード対応

## ライセンス

このプロジェクトは MIT ライセンスの下で公開されています。

## 貢献

バグ報告や機能リクエストは Issues にてお願いします。

## 参考リンク

- [Flutter 公式ドキュメント](https://flutter.dev)
- [小説家になろう](https://syosetu.com/)
- [webview_flutter パッケージ](https://pub.dev/packages/webview_flutter)
- [flutter_tts パッケージ](https://pub.dev/packages/flutter_tts)
- [Riverpod ドキュメント](https://riverpod.dev)

---

**バージョン**: 1.0.0 (MVP)
**最終更新**: 2025-12-28
**開発者**: Claude (AI Assistant) + aoisakanana
