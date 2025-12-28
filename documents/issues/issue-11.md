# Phase 4: WebViewブラウザ統合テストとUX改善

**ラベル**: `phase-4`, `priority-high`, `testing`, `enhancement`
**見積もり**: 4時間
**依存**: すべての前Issue（#1〜#10）が完了

---

## 概要
WebViewベースのブラウザとTTS機能の統合を完成させ、エンドツーエンドで動作することを確認する。ハイライト表示と自動スクロール機能を追加し、ユーザー体験を向上させる。

## 目的
- WebViewブラウジング体験の総合テスト
- 読み上げ位置のハイライト表示機能を追加
- 読み上げ位置の自動スクロール機能を追加
- UI/UXの最終調整
- パフォーマンス最適化
- MVPの完成

## タスク

### 1. 読み上げ位置のハイライト表示機能
- [ ] WebView内でのハイライト実装方法の選択
  - **Option A**: JavaScript Injection で DOM を直接操作
    - 利点: 正確な位置、サイトの表示を保持
    - 欠点: DOM操作の複雑さ
  - **Option B**: オーバーレイUIでハイライト表示
    - 利点: 実装が簡単
    - 欠点: 位置合わせの難しさ
  - **推奨**: Option A（JavaScript Injection）
- [ ] JavaScript Injection によるハイライト実装
  - 現在読み上げ中の段落要素に CSS class を追加
  - スタイル（背景色、テキスト色）をインジェクト
  - 前の段落のハイライトを解除
- [ ] 読み上げ位置の追跡
  - `TtsService` に進捗コールバックを追加
  - 現在の段落インデックスを通知
- [ ] ハイライトのスムーズな切り替え
  - CSSトランジションで滑らかに

### 2. 読み上げ位置の自動スクロール機能
- [ ] JavaScript Injection によるスクロール実装
  - 現在の段落要素の位置を取得
  - `element.scrollIntoView()` でスクロール
  - スムーズスクロールオプションを有効化
- [ ] スクロールタイミングの調整
  - 段落読み上げ開始時にスクロール
  - 画面中央に配置されるように調整
- [ ] ユーザーによる手動スクロールの考慮
  - 基本的には自動スクロールを優先
  - 必要に応じて、手動スクロール検出を実装（将来拡張）

### 3. 統合テストシナリオの実施
- [ ] エンドツーエンドテストシナリオ
  1. アプリ起動
  2. 小説家になろうトップページの表示確認
  3. サイト内を自然にブラウジング
  4. 小説ページへ遷移
  5. TTSコントロールが自動的に有効化されることを確認
  6. 再生ボタンをタップ
  7. 読み上げ開始を確認
  8. ハイライト表示を確認
  9. 自動スクロールを確認
  10. 速度変更を確認
  11. 一時停止を確認
  12. 再開を確認
  13. 停止を確認
  14. 非小説ページへ遷移時の動作確認（再生停止、コントロール無効化）

### 4. 実機でのテスト（iOS）
- [ ] iPhone実機での動作確認
  - 各機能の動作確認
  - WebViewのレンダリング確認
  - TTSの音声出力確認
- [ ] パフォーマンスチェック
  - ページ読み込み速度
  - TTS再生のレスポンス
  - スクロールの滑らかさ
- [ ] メモリ使用量チェック
  - WebViewのメモリ使用量
  - 長時間使用時のメモリリーク確認
- [ ] バッテリー消費チェック
  - 連続再生時のバッテリー消費

### 5. エッジケースのテスト
- [ ] ネットワークエラー時の動作
  - オフライン時のエラー表示
  - 接続回復時の動作
- [ ] 長文小説での動作
  - 100段落以上の小説で動作確認
  - メモリ使用量の確認
- [ ] ルビが多い小説での動作
  - ルビの読み上げ確認
  - ハイライト表示の確認
- [ ] 特殊記法がある小説での動作
  - 傍点、改行などの処理確認
- [ ] 短編小説での動作
  - URLパターンの違いを確認
- [ ] ページ遷移パターンのテスト
  - 小説 → 小説
  - 小説 → トップ
  - トップ → 小説
  - 再生中の遷移

### 6. UI/UX調整
- [ ] レイアウトの最終調整
  - WebViewとコントロールパネルのバランス
  - コントロールパネルの高さ調整
  - ボタンサイズの調整
- [ ] 色・フォントの調整
  - ハイライト色の最適化
  - コントロールパネルのテーマカラー
- [ ] アニメーションの調整
  - ページ読み込み時のローディング表示
  - ボタン押下時のフィードバック
- [ ] エラーメッセージの改善
  - ユーザーフレンドリーなメッセージ
  - 適切な回復手段の提示
- [ ] アクセシビリティ
  - VoiceOverでの操作確認
  - コントラスト比の確認

### 7. パフォーマンス最適化
- [ ] 不要な rebuild の削減
  - `const` コンストラクタの活用
  - `select` の活用でリビルド範囲を限定
- [ ] WebView のメモリ使用量最適化
  - キャッシュ設定の調整
  - 不要なリソースの読み込み制限
- [ ] JavaScript Injection の最適化
  - 実行回数の削減
  - スクリプトサイズの最小化

### 8. コードレビューとリファクタリング
- [ ] コードの可読性チェック
  - 命名規則の統一
  - 複雑なロジックの分割
- [ ] コメント追加
  - 重要なロジックへのコメント
  - TODOコメントの整理
- [ ] リファクタリング
  - 重複コードの削減
  - 関数の適切な分割
- [ ] 未使用コードの整理
  - `NovelContentView` など、使用していないコードの削除
  - コメントアウトしたコードの削除

### 9. ドキュメント更新
- [ ] README.md の更新
  - アプリの説明を更新
  - WebViewベースのブラウザであることを明記
  - 使い方の説明を追加
- [ ] 既知の問題・制限事項の文書化
  - `documents/known-issues.md` を作成
  - 将来の改善点をリストアップ
- [ ] 完成報告書の作成
  - `documents/mvp-completion-report.md`
  - 実装した機能の一覧
  - テスト結果のサマリー
  - 次のステップ（将来機能）

## 成功基準
- [ ] すべての統合テストシナリオが成功
- [ ] 読み上げ位置がハイライト表示される
- [ ] 読み上げ位置に合わせて自動スクロールする
- [ ] ページ遷移時の動作が適切
- [ ] すべてのユニットテスト・ウィジェットテストが成功
- [ ] `flutter analyze` でエラーなし
- [ ] iPhone実機で30分以上連続稼働しクラッシュしない
- [ ] MVP要件定義書の成功基準をすべて満たす
- [ ] ユーザーフレンドリーなエラーメッセージ
- [ ] パフォーマンスが許容範囲内

## 技術的詳細

### JavaScript Injection によるハイライト
```dart
Future<void> _highlightParagraph(int index) async {
  await _controller.runJavaScript('''
    // 前のハイライトを削除
    const prevHighlight = document.querySelector('.tts-highlight');
    if (prevHighlight) {
      prevHighlight.classList.remove('tts-highlight');
    }

    // 新しい段落をハイライト
    const paragraphs = document.querySelectorAll('#novel_honbun p');
    if (paragraphs[$index]) {
      paragraphs[$index].classList.add('tts-highlight');
      paragraphs[$index].scrollIntoView({
        behavior: 'smooth',
        block: 'center'
      });
    }
  ''');

  // CSSスタイルをインジェクト（初回のみ）
  await _controller.runJavaScript('''
    if (!document.getElementById('tts-highlight-style')) {
      const style = document.createElement('style');
      style.id = 'tts-highlight-style';
      style.textContent = `
        .tts-highlight {
          background-color: rgba(255, 255, 0, 0.3) !important;
          transition: background-color 0.3s ease;
        }
      `;
      document.head.appendChild(style);
    }
  ''');
}
```

### TTS進捗コールバック
```dart
class TtsService {
  void setProgressHandler(void Function(int index) onProgress) {
    _onProgress = onProgress;
  }

  Future<void> speakParagraphs(List<String> paragraphs) async {
    for (int i = 0; i < paragraphs.length; i++) {
      _onProgress?.call(i); // 進捗を通知
      await speak(paragraphs[i]);
    }
  }
}
```

## 影響範囲
- `lib/features/tts/application/tts_service.dart` - 進捗コールバック追加
- `lib/features/tts/presentation/playback_controller_notifier.dart` - ハイライト・スクロール統合
- `lib/features/novel_reader/presentation/novel_reader_screen.dart` - JavaScript Injection追加
- `test/**/*` - 既存テストの修正、新規テストの追加
- `README.md` - 更新
- `documents/` - 新規ドキュメント追加

## 注意事項
- **MVP完成**: このIssue完了でMVPが完成する
- **ハイライト・スクロール**: 元々Issue #9, #10で予定していた機能を統合
- **実機テスト**: 必ず実機で動作確認を行う
- **パフォーマンス**: WebViewとJavaScript Injectionのパフォーマンスに注意
- **メモリ管理**: 長時間使用でもメモリリークがないことを確認

## 参考資料
- [mvp-requirements.md](../mvp-requirements.md)
- [architecture.md](../architecture.md)
- [issue-plan.md](../issue-plan.md)
- [WebView Flutter公式ドキュメント](https://pub.dev/packages/webview_flutter)
- [JavaScript Injection Examples](https://pub.dev/packages/webview_flutter#javascript-channels)
