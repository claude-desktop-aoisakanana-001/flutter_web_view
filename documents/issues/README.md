# GitHub Issue作成ガイド

このディレクトリには、MVP開発のための11個のIssueテンプレートが含まれています。

---

## 📋 Issue一覧

| Issue | タイトル | Phase | 優先度 | 見積もり | 依存 |
|-------|---------|-------|-------|---------|------|
| #1 | プロジェクトセットアップと依存関係追加 | Phase 1 | 最高 | 1時間 | なし |
| #2 | 「小説家になろう」HTML構造の調査 | Phase 1 | 最高 | 2時間 | #1 |
| #3 | HTML解析機能の実装 | Phase 1 | 最高 | 2時間 | #2 |
| #4 | 基本的なアプリ構造とルーティング設定 | Phase 1 | 高 | 1.5時間 | #1 |
| #5 | TTS基本機能の実装 | Phase 2 | 高 | 2.5時間 | #1 |
| #6 | 読み上げ速度設定UI | Phase 2 | 中 | 1.5時間 | #5 |
| #7 | 再生コントローラーUI | Phase 2 | 高 | 2時間 | #5 |
| #8 | 小説本文表示UIとデータ統合 | Phase 3 | 高 | 2.5時間 | #3, #4 |
| #9 | 読み上げ位置のハイライト表示機能 | Phase 3 | 高 | 2.5時間 | #5, #8 |
| #10 | 読み上げ位置の自動スクロール機能 | Phase 3 | 高 | 2時間 | #9 |
| #11 | MVPの総合テストと最終調整 | Phase 4 | 最高 | 3時間 | #1〜#10 |

**合計**: 11 Issues、22.5時間

---

## 🚀 Issue作成方法

### 方法1: GitHub Web UIで手動作成（推奨）

1. **GitHubリポジトリにアクセス**
   ```
   https://github.com/claude-desktop-aoisakanana-001/flutter_web_view
   ```

2. **Issuesタブを開く**
   - リポジトリページの「Issues」タブをクリック

3. **New Issueボタンをクリック**

4. **各Issueの内容をコピー&ペースト**
   - `issue-01.md` の内容をコピー
   - タイトルと本文を貼り付け
   - ラベルを設定（例: `phase-1`, `priority-high`）
   - 「Submit new issue」をクリック

5. **残りのIssueも同様に作成**
   - `issue-02.md` 〜 `issue-11.md`

### 方法2: 一括作成スクリプト（要GitHub CLI）

**注意**: この環境ではGitHub CLIが利用できないため、ローカル環境で実行してください。

```bash
#!/bin/bash
# create-issues.sh

cd documents/issues

for i in {01..11}; do
  title=$(head -n 1 "issue-${i}.md" | sed 's/^# //')
  body=$(tail -n +3 "issue-${i}.md")

  gh issue create \
    --title "$title" \
    --body "$body" \
    --label "phase-$(( (i-1) / 4 + 1 ))"
done
```

実行方法：
```bash
chmod +x create-issues.sh
./create-issues.sh
```

---

## 🏷️ ラベル設定

各Issueに以下のラベルを設定してください：

### Phase別ラベル
- `phase-1`: Issue #1〜#4
- `phase-2`: Issue #5〜#7
- `phase-3`: Issue #8〜#10
- `phase-4`: Issue #11

### 優先度ラベル
- `priority-high`: Issue #1, #2, #3, #5, #7, #8, #9, #10, #11
- `priority-medium`: Issue #6
- （priority-lowはなし）

### 追加ラベル
- `research`: Issue #2（調査Issue）
- `feature`: Issue #9, #10（新機能）
- `testing`: Issue #11（テスト）

---

## 📌 マイルストーン設定

すべてのIssueを `MVP v1.0.0` マイルストーンに紐付けてください。

### マイルストーン作成手順
1. GitHubリポジトリの「Issues」タブを開く
2. 「Milestones」をクリック
3. 「New milestone」をクリック
4. 以下の情報を入力：
   - **Title**: `MVP v1.0.0`
   - **Due date**: （任意）
   - **Description**:
     ```
     小説家になろうリーダーアプリのMVPリリース
     - 小説閲覧機能
     - TTS読み上げ機能
     - ハイライト表示
     - 自動スクロール
     - 再生コントロール
     ```
5. 「Create milestone」をクリック

---

## 📝 Issue作成時の注意事項

### 1. タイトル
- テンプレートの1行目（`# `を除く部分）をそのまま使用

### 2. 本文
- テンプレートの3行目以降をコピー
- GitHub Markdown形式でフォーマット済み

### 3. ラベル
- 上記の「ラベル設定」セクションを参照
- 必要に応じてラベルを追加作成

### 4. Assignees
- 作業担当者をアサイン

### 5. Projects
- 必要に応じてプロジェクトボードに追加

---

## ✅ 作成確認チェックリスト

Issue作成後、以下を確認してください：

- [ ] 11個すべてのIssueが作成されている
- [ ] 各IssueにPhaseラベルが設定されている
- [ ] 各Issueに優先度ラベルが設定されている
- [ ] すべてのIssueが `MVP v1.0.0` マイルストーンに紐付いている
- [ ] Issue番号が依存関係に沿っている

---

## 🔗 参考資料

- [issue-plan.md](../issue-plan.md) - 詳細なIssue計画
- [mvp-requirements.md](../mvp-requirements.md) - MVP要件定義
- [architecture.md](../architecture.md) - アーキテクチャ設計

---

## 📞 サポート

Issue作成で問題が発生した場合は、以下を確認してください：
- GitHubリポジトリへのアクセス権限があるか
- Issueの作成権限があるか
- ラベルが存在するか（なければ作成）

---

**作成日**: 2025-11-30
**バージョン**: 1.0.0
