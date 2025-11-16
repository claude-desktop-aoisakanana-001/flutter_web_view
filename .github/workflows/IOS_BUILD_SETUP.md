# iOS ビルドパイプライン セットアップガイド（Mac不要版）

このガイドでは、**Mac や Xcode を持っていなくても**、GitHub Actions の macOS ランナーだけで iOS アプリの開発版パッケージをビルドする方法を説明します。

## 必要なもの

- **Apple Developer Program アカウント**（年間 $99 USD）
- **ブラウザ**（Mac は不要！）
- **GitHub アカウント**

---

## 概要

このワークフローは以下を自動で行います：

1. Flutter プロジェクトのビルド
2. Fastlane を使った証明書とプロビジョニングプロファイルの自動管理
3. App Store Connect API を使った自動認証
4. IPA ファイルの生成とアップロード

---

## ステップ 1: Apple Developer Program への登録

1. [Apple Developer Program](https://developer.apple.com/programs/) にアクセス
2. アカウントを作成して登録（$99/年）
3. 登録完了まで待つ（通常 1-2 日）

---

## ステップ 2: App Store Connect API Key の作成

### 2.1 API Key の生成

1. [App Store Connect](https://appstoreconnect.apple.com/) にログイン
2. **Users and Access** → **Keys** タブを選択
3. **App Store Connect API** セクションで **+** ボタンをクリック
4. 以下を設定：
   - **Name**: `GitHub Actions` (任意の名前)
   - **Access**: `Developer` または `Admin` を選択
5. **Generate** をクリック
6. 以下の情報をメモ：
   - **Key ID**（例: `ABC123DEF4`）
   - **Issuer ID**（ページ上部に表示されている UUID）
   - **Download API Key** ボタンをクリックして `.p8` ファイルをダウンロード

**重要**: `.p8` ファイルは一度しかダウンロードできません。安全な場所に保存してください。

### 2.2 API Key を Base64 エンコード

ダウンロードした `.p8` ファイルを Base64 形式に変換します。

#### オンラインツールを使う場合（Mac不要）

1. [Base64 Encode Online](https://www.base64encode.org/) などのサイトにアクセス
2. `.p8` ファイルの内容をコピーして貼り付け
3. **Encode** ボタンをクリック
4. 出力された Base64 文字列をコピー

#### コマンドライン（Mac/Linux/WSL）を使う場合

```bash
base64 -i AuthKey_ABC123DEF4.p8 | pbcopy  # macOS
# または
base64 -w 0 AuthKey_ABC123DEF4.p8  # Linux
```

---

## ステップ 3: Team ID の取得

1. [Apple Developer Portal](https://developer.apple.com/account/) にログイン
2. **Membership** セクションを開く
3. **Team ID** をコピー（例: `A1B2C3D4E5`）

---

## ステップ 4: App ID の作成（初回のみ）

### 4.1 App ID の登録

1. [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/identifiers/list) にアクセス
2. **Identifiers** → **+** ボタンをクリック
3. **App IDs** を選択 → **Continue**
4. **Type**: `App` を選択 → **Continue**
5. 以下を入力：
   - **Description**: `Yomiagerun App`
   - **Bundle ID**: `com.example.yomiagerunApp`（または独自の Bundle ID）
   - **Capabilities**: 必要な機能を選択（Push Notifications など）
6. **Continue** → **Register** をクリック

### 4.2 Bundle ID の変更（オプション）

デフォルトの `com.example.yomiagerunApp` を変更する場合：

1. リポジトリの `ios/Runner.xcodeproj/project.pbxproj` を編集
2. `PRODUCT_BUNDLE_IDENTIFIER` を検索して置換
3. または、次の手順で GitHub Actions 実行後に Xcode で変更可能

---

## ステップ 5: GitHub Secrets の設定

GitHub リポジトリで以下の Secrets を設定します。

1. GitHub リポジトリの **Settings** → **Secrets and variables** → **Actions** を開く
2. **New repository secret** をクリックして、以下を追加：

| Secret 名 | 値 | 説明 |
|----------|-----|------|
| `APP_STORE_CONNECT_KEY_ID` | ステップ 2.1 で取得した Key ID | 例: `ABC123DEF4` |
| `APP_STORE_CONNECT_ISSUER_ID` | ステップ 2.1 で取得した Issuer ID | UUID 形式（例: `12345678-1234-...`） |
| `APP_STORE_CONNECT_KEY_CONTENT` | ステップ 2.2 で取得した Base64 文字列 | `.p8` ファイルの Base64 エンコード |
| `APPLE_TEAM_ID` | ステップ 3 で取得した Team ID | 例: `A1B2C3D4E5` |

### Secret の追加手順

各 Secret について：
1. **Name** に上記の Secret 名を入力
2. **Secret** に対応する値を貼り付け
3. **Add secret** をクリック

---

## ステップ 6: ワークフローの実行

### 6.1 初回ビルド

1. 変更をコミット・プッシュ：
   ```bash
   git add .
   git commit -m "Add iOS build pipeline"
   git push origin main
   ```

2. GitHub リポジトリの **Actions** タブを開く
3. **iOS Build (Development)** ワークフローが自動で実行されます
4. 初回は証明書とプロビジョニングプロファイルが自動生成されます

### 6.2 ビルド成果物のダウンロード

1. ワークフローが成功したら、**Summary** ページを開く
2. **Artifacts** セクションに `ios-development-XXX` が表示されます
3. クリックして IPA ファイルをダウンロード

---

## ステップ 7: IPA のインストール方法

### 方法 1: TestFlight を使用（推奨）

現在のワークフローは開発版ビルドです。TestFlight を使う場合は別途 App Store Connect への IPA アップロードが必要です。

### 方法 2: 直接インストール（開発版）

1. iOS デバイスの UDID を取得：
   - iTunes（Windows）や Finder（macOS Catalina 以降）でデバイスを接続
   - デバイス情報をクリックして UDID をコピー
   - または、[UDID Calculator](https://www.udidcalculator.com/) などのオンラインツールを使用

2. UDID を Apple Developer Portal に登録：
   - [Devices](https://developer.apple.com/account/resources/devices/list) にアクセス
   - **+** ボタンをクリック
   - **Device Name** と **UDID** を入力
   - **Continue** → **Register** をクリック

3. 再度ワークフローを実行（プロビジョニングプロファイルが更新されます）

4. IPA を以下のいずれかの方法でインストール：
   - **Xcode**: Window → Devices and Simulators → デバイスを選択 → IPA をドラッグ
   - **Apple Configurator 2**（macOS）
   - **Diawi** や **TestFlight** などのサービス

---

## トラブルシューティング

### エラー: "No signing certificate found"

**原因**: App Store Connect API Key が正しく設定されていない

**解決策**:
1. GitHub Secrets が正しく設定されているか確認
2. API Key の権限が `Developer` または `Admin` であることを確認
3. Team ID が正しいか確認

### エラー: "No devices registered"

**原因**: プロビジョニングプロファイルにデバイスが登録されていない

**解決策**:
1. ステップ 7 の方法でデバイスを登録
2. ワークフローを再実行

### エラー: "Bundle identifier mismatch"

**原因**: Bundle ID が App ID と一致していない

**解決策**:
1. `ios/Runner.xcodeproj/project.pbxproj` の `PRODUCT_BUNDLE_IDENTIFIER` を確認
2. Apple Developer Portal の App ID と一致させる

### Fastlane エラー

ワークフローログで詳細なエラーメッセージを確認してください。

---

## 高度な設定

### Bundle ID の変更

`ios/fastlane/Fastfile` と `ios/Runner.xcodeproj/project.pbxproj` を編集してください。

### App Store 配布用ビルド

`ios/fastlane/Fastfile` の `build_release` レーンを使用：

```yaml
# .github/workflows/ios-build.yml
- name: Build IPA with Fastlane
  run: |
    bundle exec fastlane build_release  # 変更
```

### TestFlight への自動アップロード

Fastfile に以下を追加：

```ruby
lane :upload_testflight do
  build_release
  upload_to_testflight(
    api_key: api_key,
    skip_waiting_for_build_processing: true
  )
end
```

---

## セキュリティのベストプラクティス

1. **GitHub Secrets を使用**: API Key や Team ID は必ず Secrets に保存
2. **API Key の権限を最小限に**: 必要最小限の権限（Developer）を使用
3. **定期的なローテーション**: API Key を定期的に再生成
4. **Private リポジトリ**: ビルド設定は Private リポジトリで管理

---

## 参考リンク

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi)
- [Fastlane Documentation](https://docs.fastlane.tools/)
- [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)

---

## まとめ

このセットアップにより、Mac や Xcode を持っていなくても、以下が可能になります：

- ブラウザだけで iOS ビルドパイプラインを構築
- GitHub Actions の macOS ランナーで自動ビルド
- 証明書とプロビジョニングプロファイルの自動管理
- IPA ファイルの自動生成と配布

何か問題が発生した場合は、GitHub Actions のログを確認するか、Issue を作成してください。
