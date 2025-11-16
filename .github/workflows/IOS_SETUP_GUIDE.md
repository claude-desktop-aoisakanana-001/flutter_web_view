# iOS ビルドパイプライン セットアップガイド

このガイドでは、GitHub Actions で iOS アプリの開発版パッケージをビルドするために必要な手順を説明します。

## 前提条件

- Apple Developer Program への登録（有料アカウント）
- macOS マシン（証明書とプロビジョニングプロファイルの作成用）
- Xcode がインストールされていること

---

## ステップ 1: Apple Developer での設定

### 1.1 App ID の作成・確認

1. [Apple Developer Console](https://developer.apple.com/account/) にログイン
2. **Certificates, Identifiers & Profiles** を選択
3. **Identifiers** → **App IDs** を選択
4. 既存の App ID を確認するか、新規作成:
   - **Bundle ID**: `com.example.yomiagerunApp` (または独自の Bundle ID に変更)
   - **Description**: `Yomiagerun App`
   - 必要な **Capabilities** を選択（Push Notifications など）
5. **Continue** → **Register** をクリック

### 1.2 iOS Development Certificate の作成

1. **Certificates** → **+** ボタンをクリック
2. **iOS App Development** を選択 → **Continue**
3. **Certificate Signing Request (CSR)** を作成:

   macOS の **キーチェーンアクセス** アプリで:
   - **キーチェーンアクセス** → **証明書アシスタント** → **認証局に証明書を要求**
   - メールアドレスと名前を入力
   - **ディスクに保存** を選択
   - CSR ファイルを保存

4. CSR ファイルをアップロード → **Continue**
5. 証明書をダウンロード (`.cer` ファイル)

### 1.3 Development Provisioning Profile の作成

1. **Profiles** → **+** ボタンをクリック
2. **iOS App Development** を選択 → **Continue**
3. 作成した **App ID** (`com.example.yomiagerunApp`) を選択 → **Continue**
4. 作成した **Certificate** を選択 → **Continue**
5. テストに使用する **Devices** を選択 → **Continue**
   - デバイスが未登録の場合、**Devices** セクションで先に登録
6. **Provisioning Profile Name** を入力（例: `Yomiagerun Development`）
7. **Generate** をクリック
8. Provisioning Profile をダウンロード (`.mobileprovision` ファイル)

---

## ステップ 2: 証明書とプロファイルの P12 変換

### 2.1 証明書を P12 形式にエクスポート

1. ダウンロードした `.cer` ファイルをダブルクリックして、キーチェーンアクセスにインポート
2. **キーチェーンアクセス** → **自分の証明書** カテゴリを開く
3. インポートした証明書（例: `Apple Development: Your Name`）を右クリック
4. **書き出す** を選択
5. ファイル形式: **Personal Information Exchange (.p12)**
6. ファイル名: `build_certificate.p12`
7. パスワードを設定（このパスワードは後で GitHub Secrets に登録）
8. 保存

### 2.2 Base64 エンコード

ターミナルで以下のコマンドを実行:

```bash
# 証明書を Base64 エンコード
base64 -i build_certificate.p12 | pbcopy
# クリップボードにコピーされます

# Provisioning Profile を Base64 エンコード
base64 -i Yomiagerun_Development.mobileprovision | pbcopy
# クリップボードにコピーされます
```

---

## ステップ 3: GitHub Secrets の設定

1. GitHub リポジトリの **Settings** → **Secrets and variables** → **Actions** を開く
2. **New repository secret** をクリックして、以下の secrets を追加:

| Secret 名 | 値 | 説明 |
|----------|-----|------|
| `BUILD_CERTIFICATE_BASE64` | 手順 2.2 でコピーした証明書の Base64 文字列 | P12 証明書 |
| `P12_PASSWORD` | 手順 2.1 で設定したパスワード | P12 証明書のパスワード |
| `BUILD_PROVISION_PROFILE_BASE64` | 手順 2.2 でコピーしたプロビジョニングプロファイルの Base64 文字列 | Provisioning Profile |
| `KEYCHAIN_PASSWORD` | 任意の強力なパスワード | GitHub Actions のキーチェーン用（例: ランダム文字列） |

---

## ステップ 4: ExportOptions.plist の更新

`.github/workflows/ExportOptions.plist` ファイルを以下の情報で更新:

1. **Team ID** の取得:
   - Apple Developer Console → **Membership** を開く
   - **Team ID** をコピー（例: `A1B2C3D4E5`）

2. **Provisioning Profile Name** の確認:
   - 手順 1.3 で作成したプロファイル名を使用

3. ファイルを編集:

```xml
<key>teamID</key>
<string>A1B2C3D4E5</string>  <!-- ここに Team ID を記入 -->

<key>provisioningProfiles</key>
<dict>
    <key>com.example.yomiagerunApp</key>
    <string>Yomiagerun Development</string>  <!-- プロファイル名を記入 -->
</dict>
```

---

## ステップ 5: Bundle ID の変更（オプション）

デフォルトの Bundle ID (`com.example.yomiagerunApp`) を変更する場合:

1. Xcode でプロジェクトを開く:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Runner** プロジェクト → **TARGETS** → **Runner** を選択
3. **General** タブ → **Bundle Identifier** を変更
4. 新しい Bundle ID で Apple Developer Console で App ID を作成
5. `.github/workflows/ExportOptions.plist` の Bundle ID も更新

---

## ステップ 6: ワークフローの実行

1. 変更をコミット・プッシュ:
   ```bash
   git add .
   git commit -m "Add iOS build pipeline"
   git push origin main
   ```

2. GitHub リポジトリの **Actions** タブを開く
3. **iOS Build (Development)** ワークフローを確認
4. ビルドが成功すると、**Artifacts** セクションに IPA ファイルがアップロードされます

---

## ステップ 7: IPA のインストール（テスト）

### 方法 1: TestFlight を使用（推奨）

App Store Connect に IPA をアップロードして、TestFlight でテスターに配布できます。

### 方法 2: 直接インストール

1. GitHub Actions の Artifacts から IPA ファイルをダウンロード
2. Xcode → **Window** → **Devices and Simulators** を開く
3. デバイスを接続
4. IPA ファイルをドラッグ＆ドロップ

---

## トラブルシューティング

### ビルドが失敗する場合

1. **証明書の有効期限を確認**:
   - Apple Developer Console で証明書が有効か確認

2. **Provisioning Profile の有効性を確認**:
   - デバイスが登録されているか確認
   - Bundle ID が一致しているか確認

3. **GitHub Secrets が正しく設定されているか確認**:
   - Base64 エンコードが正しいか再確認

4. **Team ID が正しいか確認**:
   - ExportOptions.plist の Team ID を再確認

### Xcode のバージョン指定

特定の Xcode バージョンを使用する場合、ワークフローに以下を追加:

```yaml
- name: Select Xcode version
  run: sudo xcode-select -s /Applications/Xcode_15.0.app
```

---

## 参考リンク

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)
- [GitHub Actions - Building and testing iOS](https://docs.github.com/en/actions/deployment/deploying-xcode-applications/installing-an-apple-certificate-on-macos-runners-for-xcode-development)

---

**注意**: このガイドは開発版（Development）ビルド用です。App Store への配布には別途 Distribution 証明書とプロビジョニングプロファイルが必要です。
