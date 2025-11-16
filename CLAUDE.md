# CLAUDE.md - AI Assistant Guide for yomiagerun_app

このドキュメントは、AI アシスタント（Claude など）がこのリポジトリで作業する際のガイドラインです。

## プロジェクト概要

**yomiagerun_app**（読み上げ実行）は、Flutter を使用したクロスプラットフォームアプリケーションです。

- **プラットフォーム**: Android、iOS、macOS、Windows、Linux、Web
- **言語**: Dart 3.10.0+
- **フレームワーク**: Flutter (stable channel)
- **現在の状態**: カウンターアプリを含むスターター/テンプレートプロジェクト

## 必須の Git ワークフロールール

### 🚫 絶対に守るべきルール

#### 1. **master ブランチへの直接 Push は禁止**
- master ブランチは保護されています
- いかなる変更も直接 master にコミット・Push してはいけません

#### 2. **Issue ごとにブランチを作成**
- 新しいタスクや機能開発を始める前に、必ず専用のブランチを作成してください
- ブランチ命名規則:
  ```bash
  # 機能追加の場合
  feature/issue-{番号}-{簡潔な説明}

  # バグ修正の場合
  fix/issue-{番号}-{簡潔な説明}

  # リファクタリングの場合
  refactor/issue-{番号}-{簡潔な説明}

  # 例
  feature/issue-123-add-webview
  fix/issue-456-counter-overflow
  ```

#### 3. **Issue 着手時には Issue に実施計画をコメント**
- Issue に取り組む前に、以下の内容をコメントしてください：
  - 実施する内容の概要
  - 実施手順（ステップバイステップ）
  - 予想される影響範囲
  - テスト計画

  **コメントテンプレート**:
  ```markdown
  ## 実施計画

  ### 概要
  {この Issue で実施する内容の概要}

  ### 実施手順
  1. {ステップ1}
  2. {ステップ2}
  3. {ステップ3}

  ### 影響範囲
  - {影響を受けるファイルやコンポーネント}

  ### テスト計画
  - {テスト項目1}
  - {テスト項目2}

  ### 予想作業時間
  {おおよその作業時間}
  ```

#### 4. **作業実施後は Issue に作業内容をコメント**
- 作業完了後、以下の内容を Issue にコメントしてください：
  - 実施した内容の詳細
  - 変更したファイル一覧
  - テスト結果
  - 残課題や次のステップ（あれば）

  **コメントテンプレート**:
  ```markdown
  ## 作業完了報告

  ### 実施内容
  {実際に行った作業の詳細}

  ### 変更ファイル
  - `{ファイルパス1}`: {変更内容}
  - `{ファイルパス2}`: {変更内容}

  ### テスト結果
  ```bash
  {テスト実行結果のログ}
  ```

  ### 確認事項
  - [ ] コードレビュー準備完了
  - [ ] テスト通過
  - [ ] ドキュメント更新

  ### 残課題・次のステップ
  {もしあれば記載}

  ### プルリクエスト
  #{PR番号}
  ```

### Git ワークフロー例

```bash
# 1. 最新の master を取得
git fetch origin master
git checkout master
git pull origin master

# 2. Issue 用のブランチを作成
git checkout -b feature/issue-123-add-webview

# 3. 作業を実施
# ... コーディング ...

# 4. 変更をコミット
git add .
git commit -m "feat: Add webview functionality for issue #123"

# 5. リモートにプッシュ
git push -u origin feature/issue-123-add-webview

# 6. プルリクエストを作成
# GitHub UI または gh CLI を使用
gh pr create --title "Add webview functionality" --body "Closes #123"

# 7. レビュー後、master にマージ
# GitHub UI でマージボタンを使用
```

## プロジェクト構造

```
flutter_web_view/
├── lib/                          # メインアプリケーションコード
│   └── main.dart                # エントリーポイント（122行）
├── test/                        # テストコード
│   └── widget_test.dart        # ウィジェットテスト（30行）
├── web/                         # Web プラットフォーム用アセット
│   ├── index.html              # Web エントリーポイント
│   ├── manifest.json           # PWA マニフェスト
│   ├── favicon.png             # ブラウザアイコン
│   └── icons/                  # Web アプリアイコン
├── android/                     # Android ネイティブ設定
├── ios/                         # iOS ネイティブ設定
├── macos/                       # macOS ネイティブ設定
├── windows/                     # Windows ネイティブ設定
├── linux/                       # Linux ネイティブ設定
├── pubspec.yaml                # 依存関係とメタデータ
├── analysis_options.yaml       # Dart アナライザールール
└── .gitignore                  # Git 除外パターン
```

## 重要なファイル

### `lib/main.dart`
- **MyApp**: ルートウィジェット（Material テーマ設定）
- **MyHomePage**: カウンターデモのステートフルウィジェット
- **テーマ**: Deep purple シードカラー、Material 3 デザイン

### `pubspec.yaml`
- **直接依存関係**:
  - `flutter`: コアフレームワーク
  - `cupertino_icons: ^1.0.8`: iOS スタイルアイコン
- **開発依存関係**:
  - `flutter_test`: テストフレームワーク
  - `flutter_lints: ^6.0.0`: コードスタイルルール

### `test/widget_test.dart`
- カウンター機能の基本テスト
- 初期状態とボタンタップ後の動作を検証

## 開発ワークフロー

### セットアップ

```bash
# 依存関係のインストール
flutter pub get

# デバイス確認
flutter devices

# アプリの実行
flutter run

# Web で実行
flutter run -d web
```

### コーディング規約

1. **コードフォーマット**
   ```bash
   flutter format lib/ test/
   ```

2. **静的解析**
   ```bash
   flutter analyze
   ```

3. **自動修正**
   ```bash
   flutter fix lib/ test/
   ```

4. **Lint ルール**
   - `flutter_lints` パッケージを使用
   - `analysis_options.yaml` でカスタマイズ可能

### テスト

```bash
# すべてのテストを実行
flutter test

# 特定のテストファイルを実行
flutter test test/widget_test.dart

# 詳細出力付きで実行
flutter test -v

# カバレッジレポート生成
flutter test --coverage
```

### ビルド

```bash
# Web
flutter build web

# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios

# macOS
flutter build macos

# Windows
flutter build windows

# Linux
flutter build linux
```

## 依存関係管理

### パッケージの追加

```bash
# 通常の依存関係
flutter pub add package_name

# 開発依存関係
flutter pub add --dev package_name

# 依存関係の更新
flutter pub upgrade

# 特定パッケージの更新
flutter pub upgrade package_name
```

### 主要な依存関係

| パッケージ | バージョン | 用途 |
|---------|---------|------|
| flutter | SDK | Flutter コアフレームワーク |
| cupertino_icons | ^1.0.8 | iOS スタイルアイコン |
| flutter_test | SDK | ウィジェットテスト |
| flutter_lints | ^6.0.0 | コードスタイルルール |

## プラットフォーム別の詳細

### Android
- **パッケージ名**: com.example.yomiagerun_app
- **Gradle**: Kotlin DSL (`build.gradle.kts`)
- **最小 SDK**: Flutter により管理
- **Java バージョン**: 17

### iOS
- **Bundle ID**: Runner.xcodeproj で設定
- **Xcode プロジェクト**: `ios/Runner.xcodeproj`
- **CI/CD**: GitHub Actions + Fastlane

### Web
- **ブートストラップ**: `flutter_bootstrap.js`
- **PWA サポート**: `web/manifest.json` で設定
- **テーマカラー**: #0175C2

## コード品質基準

### 必須チェック項目

作業完了前に必ず以下を確認してください：

- [ ] `flutter analyze` がエラーなく完了
- [ ] `flutter test` がすべて成功
- [ ] `flutter format` でコードをフォーマット済み
- [ ] 新しいコードにコメント/ドキュメントを追加
- [ ] 新機能に対応するテストを作成
- [ ] `pubspec.yaml` の依存関係が最新

### コードレビュー基準

- **可読性**: 変数名、関数名は明確で理解しやすいか
- **保守性**: コードは適切に分割され、再利用可能か
- **テスト**: 十分なテストカバレッジがあるか
- **パフォーマンス**: 不要な再レンダリングや処理はないか
- **ドキュメント**: 複雑なロジックにコメントがあるか

## 推奨アーキテクチャパターン

### 状態管理
- **小規模アプリ**: setState（現在の実装）
- **中規模アプリ**: Provider または Riverpod
- **大規模アプリ**: BLoC パターン

### コードの整理
```
lib/
├── main.dart                    # エントリーポイント
├── app/                        # アプリ全体の設定
│   ├── app.dart
│   └── theme.dart
├── features/                   # 機能別ディレクトリ
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── home_state.dart
│   └── settings/
│       ├── settings_screen.dart
│       └── settings_state.dart
├── shared/                     # 共通コンポーネント
│   ├── widgets/
│   └── utils/
└── models/                     # データモデル
```

## トラブルシューティング

### ホットリロードが効かない
```bash
# アプリを再起動
flutter run
```

### 依存関係の問題
```bash
# クリーンビルド
flutter clean
flutter pub get
flutter run
```

### プラットフォーム固有のビルドエラー
```bash
# Android
cd android && ./gradlew clean && cd ..

# iOS
cd ios && pod install && cd ..

# その後
flutter clean
flutter pub get
```

## パフォーマンス最適化

### 推奨事項
- `const` コンストラクタを積極的に使用
- 大きなリストには `ListView.builder` を使用
- 重い計算は `compute()` で別スレッドに移動
- 画像は適切なサイズにリサイズ
- DevTools でパフォーマンスをプロファイル

### ビルド最適化
- **Android**: ProGuard/R8 を有効化（リリースビルド）
- **iOS**: Bitcode を有効化
- **Web**: `flutter build web --release --web-renderer html` または `canvaskit`

## CI/CD

### 現在の設定
- **iOS**: GitHub Actions + Fastlane
- **ブランチ**: master
- **ビルドパイプライン**: iOS 用に設定済み

### 推奨 CI/CD フロー
```yaml
# .github/workflows/flutter.yml
name: Flutter CI

on:
  pull_request:
    branches: [ master ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build web
```

## セキュリティ

### 注意事項
- **API キー**: 環境変数または秘匿ファイルで管理
- **`.gitignore`**: 機密情報を含むファイルを除外
- **依存関係**: 定期的に `flutter pub upgrade` で更新
- **脆弱性スキャン**: `flutter pub audit` を定期実行（利用可能な場合）

## よくある質問（FAQ）

### Q: 新しい依存関係を追加した後は？
A: `flutter pub get` を実行してください。

### Q: iOS でビルドエラーが出る
A: `cd ios && pod install && cd ..` を実行後、再ビルドしてください。

### Q: Web で日本語フォントが表示されない
A: `pubspec.yaml` にフォントを追加し、`FontLoader` で読み込んでください。

### Q: テストをスキップしてビルドできる？
A: 技術的には可能ですが、品質保証のため推奨しません。

## 参考リンク

- [Flutter 公式ドキュメント](https://flutter.dev)
- [Dart 言語ガイド](https://dart.dev)
- [Material Design 3](https://m3.material.io/)
- [Flutter Testing Guide](https://flutter.dev/docs/testing)
- [Flutter Widget Catalog](https://flutter.dev/docs/development/ui/widgets)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

## IDE 設定

### VS Code
1. 拡張機能をインストール:
   - Flutter
   - Dart
2. `.vscode/settings.json`:
   ```json
   {
     "dart.flutterSdkPath": "/path/to/flutter",
     "editor.formatOnSave": true,
     "dart.lineLength": 80
   }
   ```

### Android Studio / IntelliJ
1. Flutter および Dart プラグインをインストール
2. SDK パスを設定: Preferences → Languages & Frameworks → Flutter

## AI アシスタント向け追加情報

### 作業開始時のチェックリスト
1. [ ] Issue の内容を完全に理解
2. [ ] 実施計画を Issue にコメント
3. [ ] 適切な名前でブランチを作成
4. [ ] 最新の master から分岐していることを確認

### 作業中の注意事項
- 複数ファイルを変更する場合は、変更の影響範囲を常に意識
- テストを書いてから実装（TDD）を推奨
- コミットは小さく、頻繁に（Atomic Commits）
- コミットメッセージは明確に（Conventional Commits 推奨）

### コミットメッセージ規約
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type**:
- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメント変更
- `style`: コードスタイル変更（動作に影響なし）
- `refactor`: リファクタリング
- `test`: テスト追加・修正
- `chore`: ビルドプロセスやツールの変更

**例**:
```
feat(webview): Add WebView integration

- Add webview_flutter package
- Create WebViewScreen widget
- Add navigation to WebView from home screen

Closes #123
```

### 作業完了時のチェックリスト
1. [ ] すべてのテストが成功
2. [ ] コードフォーマット済み
3. [ ] 静的解析でエラーなし
4. [ ] 作業内容を Issue にコメント
5. [ ] プルリクエストを作成
6. [ ] PR の説明が明確

## プロジェクトのビジョン

このプロジェクトは、クロスプラットフォーム対応の読み上げ実行アプリケーションを目指しています。現在はスターターテンプレートの状態ですが、今後の拡張により以下の機能が追加される可能性があります：

- WebView 統合
- テキスト読み上げ機能
- マルチ言語対応
- オフライン機能
- クラウド同期

---

**最終更新**: 2025-11-16
**Flutter SDK バージョン**: 3.10.0+
**対応プラットフォーム**: Android, iOS, macOS, Windows, Linux, Web

## 変更履歴

| 日付 | バージョン | 変更内容 |
|------|----------|---------|
| 2025-11-16 | 1.0.0 | 初版作成 - Git ワークフロールールと Issue 管理ルールを追加 |
