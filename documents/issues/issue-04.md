# Phase 1: 基本的なアプリ構造とルーティング設定

**ラベル**: `phase-1`, `priority-high`
**見積もり**: 1.5時間
**依存**: Issue #1

---

## 概要
アプリのエントリーポイントと基本的な画面構成を作成する。

## タスク
- [ ] `lib/app/app.dart` を作成
  - MaterialApp の設定
  - テーマ設定
  - ProviderScope の設定
- [ ] `lib/main.dart` を更新
  - ProviderScope でアプリをラップ
- [ ] `NovelReaderScreen` のスケルトンを作成
  - 基本的な Scaffold
  - AppBar
  - 後で実装する部分はプレースホルダー
- [ ] 動作確認（アプリが起動すること）

## 成功基準
- [ ] アプリが正常に起動する
- [ ] NovelReaderScreen が表示される
- [ ] `flutter analyze` でエラーなし

## 参考資料
- [architecture.md](../architecture.md)
- [tech-selection.md](../tech-selection.md)
- [issue-plan.md](../issue-plan.md)

---

## 作業完了報告

**実施日**: 2025-12-27
**担当**: Claude AI Assistant

### 実施内容

Issue-04 で計画された基本的なアプリ構造とルーティング設定を完了しました。

#### 1. lib/app/app.dart の作成

**ファイル**: `lib/app/app.dart` (新規作成、62行)

アプリケーションのルートウィジェットを作成：

**主要機能**:
- Material 3 デザインの採用
- ライトテーマとダークテーマの設定
  - シードカラー: `Colors.deepPurple`
  - テーマモード: システム設定に従う (`ThemeMode.system`)
- 小説閲覧に最適化されたテキストテーマ
  - `bodyLarge`: fontSize 18, lineHeight 1.8（読みやすさ重視）
  - `bodyMedium`: fontSize 16, lineHeight 1.6
- AppBar テーマ
  - 中央寄せタイトル
  - elevation 0（フラットデザイン）
- ホーム画面として `NovelReaderScreen` を設定

#### 2. NovelReaderScreen のスケルトン作成

**ファイル**: `lib/features/novel_reader/presentation/novel_reader_screen.dart` (新規作成、63行)

小説閲覧画面の基礎を作成：

**主要機能**:
- `StatefulWidget` として実装（将来の WebView 統合に備える）
- AppBar
  - タイトル: 「よみあげRun」
  - 設定ボタン（TODO: Issue #6 で実装予定）
- プレースホルダーUI
  - アプリアイコン（auto_stories）
  - アプリ名とステータス表示
  - 実装予定の機能を明示
- FloatingActionButton
  - URL 入力用（TODO: Issue #5 で実装予定）

**コード例**:
```dart
class NovelReaderScreen extends StatefulWidget {
  const NovelReaderScreen({super.key});

  @override
  State<NovelReaderScreen> createState() => _NovelReaderScreenState();
}

class _NovelReaderScreenState extends State<NovelReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('よみあげRun'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: 設定画面へ遷移
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories, size: 100),
            Text('よみあげRun'),
            Text('小説閲覧画面（準備中）'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Issue #5 で URL 入力ダイアログを実装
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

#### 3. lib/main.dart の更新

**ファイル**: `lib/main.dart` (122行 → 14行に大幅簡素化)

エントリーポイントをシンプルに再構成：

**変更内容**:
- デフォルトのカウンターアプリコード（`MyApp`、`MyHomePage`）を削除
- Riverpod の `ProviderScope` で App をラップ
- 新しい `App` ウィジェットを使用

**完成コード**:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yomiagerun_app/app/app.dart';

/// アプリケーションのエントリーポイント
///
/// ProviderScope で App をラップして Riverpod の状態管理を有効化します。
void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
```

### 変更ファイル

**新規作成**:
- `lib/app/app.dart` (62行)
- `lib/features/novel_reader/presentation/novel_reader_screen.dart` (63行)

**更新**:
- `lib/main.dart` (122行 → 14行、-108行)

**統計**:
- 合計: 3ファイル変更、141行追加、118行削除

### 成功基準の確認

- [x] `lib/app/app.dart` を作成（MaterialApp、テーマ、ProviderScope 設定）
- [x] `lib/main.dart` を更新（ProviderScope でラップ）
- [x] `NovelReaderScreen` のスケルトンを作成（Scaffold、AppBar、プレースホルダー）
- [x] アプリが正常に起動する準備完了
- [ ] `flutter analyze` でエラーなし（ローカル環境で実施必要）

### 次のステップ

#### ローカル環境での確認

以下のコマンドを実行してください：

```bash
# 静的解析
flutter analyze

# アプリの起動確認
flutter run
```

#### 期待される動作

- アプリが起動し、「よみあげRun」というタイトルの画面が表示される
- 中央に本のアイコンと「小説閲覧画面（準備中）」のテキストが表示される
- 右上に設定ボタン、右下に URL 入力用の FAB が表示される
- ライトモード/ダークモードがシステム設定に追従する

#### 次の Issue

- **Issue #5**: URL 入力ダイアログの実装
- **Issue #6**: 設定画面のスケルトン作成
- **Issue #8**: WebView 統合と HTML パーサー連携

### 技術的ハイライト

#### Material 3 デザインの採用
✅ `useMaterial3: true` により最新のデザイン言語を使用

#### 読みやすさ重視のテキストテーマ
- 行間を広く設定（`height: 1.8`）して長文の可読性を向上
- フォントサイズを大きめに設定（18px）

#### Riverpod の準備完了
- `ProviderScope` でアプリ全体をラップ
- Issue #7 以降で状態管理を実装可能

#### シンプルで保守性の高いコード
- main.dart を 122行 → 14行に簡素化
- 関心の分離（App ウィジェット、Screen ウィジェット）
- 将来の拡張を考慮した設計

### 備考

- Flutter コマンドは実行環境で利用不可のため、静的解析と実機確認はローカル環境で実施してください
- WebView 統合は Issue #8 で実装予定（今回はプレースホルダーのみ）
- 設定画面と URL 入力ダイアログは Issue #5, #6 で実装予定
- カウンターアプリのコードは完全に削除され、アプリの基礎構造に置き換わりました
