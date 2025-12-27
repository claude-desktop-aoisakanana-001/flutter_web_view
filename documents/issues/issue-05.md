# Phase 2: TTS基本機能の実装

**ラベル**: `phase-2`, `priority-high`
**見積もり**: 2.5時間
**依存**: Issue #1

---

## 概要
flutter_tts を使用した基本的な読み上げ機能を実装する。

## タスク
- [ ] `TTSConfig` モデルを作成（Freezed使用）
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
  - **注**: MVP では speed のみ使用、他は将来の拡張性を担保
- [ ] `TTSState` モデルを作成
  ```dart
  @freezed
  class TTSState with _$TTSState {
    const factory TTSState({
      @Default(false) bool isInitialized,
      TTSConfig? config,
      String? errorMessage,
    }) = _TTSState;
  }
  ```
- [ ] `TtsService` を実装（Riverpod使用）
  - flutter_tts の初期化
  - `speak(String text)` メソッド
  - `pause()` メソッド
  - `stop()` メソッド
  - `setSpeed(double speed)` メソッド
  - `setConfig(TTSConfig config)` メソッド（将来の拡張用）
  - 読み上げ位置のコールバック設定
- [ ] 日本語音声の設定
- [ ] エラーハンドリング
- [ ] ユニットテストを作成
- [ ] コード生成を実行

## 成功基準
- [ ] テキストを読み上げできる
- [ ] 一時停止・停止が動作する
- [ ] 速度設定が反映される
- [ ] ユニットテストが成功
- [ ] `flutter analyze` でエラーなし

## 参考資料
- [tech-selection.md](../tech-selection.md)
- [architecture.md](../architecture.md)
- [issue-plan.md](../issue-plan.md)

---

## 作業完了報告

**実施日**: 2025-12-27
**担当**: Claude AI Assistant

### 実施内容

Issue-05 で計画された TTS（Text-to-Speech）基本機能を実装しました。

#### 1. TTSConfig モデルの作成

**ファイル**: `lib/features/tts/domain/models/tts_config.dart` (新規作成、43行)

Freezed を使用した TTS 設定モデル：

**プロパティ**:
- `speed` (double): 読み上げ速度（0.5〜2.0）**← MVP で使用**
- `pitch` (double): 音程（将来対応）
- `volume` (double): 音量（将来対応）
- `linePause` (double): 行間の間隔（将来対応）
- `paragraphPause` (double): 段落間の間隔（将来対応）

**特徴**:
- Immutable（不変）モデル
- JSON シリアライズ/デシリアライズ対応
- すべてのプロパティにデフォルト値を設定
- 将来の拡張性を担保

**コード例**:
```dart
@freezed
class TTSConfig with _$TTSConfig {
  const factory TTSConfig({
    @Default(1.0) double speed,
    @Default(1.0) double pitch,
    @Default(1.0) double volume,
    @Default(0.0) double linePause,
    @Default(0.0) double paragraphPause,
  }) = _TTSConfig;

  factory TTSConfig.fromJson(Map<String, dynamic> json) =>
      _$TTSConfigFromJson(json);
}
```

#### 2. TTSState モデルの作成

**ファイル**: `lib/features/tts/domain/models/tts_state.dart` (新規作成、21行)

TTS サービスの状態を管理するモデル：

**プロパティ**:
- `isInitialized` (bool): TTS が初期化済みかどうか
- `config` (TTSConfig?): 現在の TTS 設定
- `errorMessage` (String?): エラーメッセージ

**用途**:
- TTS サービスの初期化状態を追跡
- 設定の保持と管理
- エラー状態の管理

**コード例**:
```dart
@freezed
class TTSState with _$TTSState {
  const factory TTSState({
    @Default(false) bool isInitialized,
    TTSConfig? config,
    String? errorMessage,
  }) = _TTSState;
}
```

#### 3. TtsService の実装

**ファイル**: `lib/features/tts/application/tts_service.dart` (新規作成、204行)

Riverpod の StateNotifier として実装された TTS サービス：

**主要メソッド**:

1. **speak(String text)**
   - テキストを読み上げる
   - 初期化チェック
   - 空テキストのバリデーション
   - エラーハンドリング

2. **pause()**
   - 読み上げを一時停止
   - 初期化チェック

3. **stop()**
   - 読み上げを停止
   - 初期化チェック

4. **setSpeed(double speed)**
   - 読み上げ速度を設定（0.5〜2.0）
   - 範囲バリデーション
   - 設定の状態への反映

5. **setConfig(TTSConfig config)**
   - TTS 設定を一括適用
   - MVP では speed のみ適用
   - 将来の拡張用パラメータは保存のみ

**初期化処理**:
- 日本語音声の設定（`ja-JP`）
- デフォルト設定の適用
- コールバックの設定
  - 読み上げ開始ハンドラ
  - 読み上げ完了ハンドラ
  - 読み上げ進捗ハンドラ（将来の UI 更新用）
  - エラーハンドラ

**エラーハンドリング**:
- すべてのメソッドで例外をキャッチ
- 状態にエラーメッセージを保存
- `TtsServiceException` をスロー

**コード例**:
```dart
@riverpod
class TtsServiceNotifier extends _$TtsServiceNotifier {
  late FlutterTts _flutterTts;

  @override
  TTSState build() {
    _flutterTts = FlutterTts();
    _initializeTts();
    return const TTSState();
  }

  Future<void> speak(String text) async {
    if (!state.isInitialized) {
      throw TtsServiceException('TTS が初期化されていません');
    }
    // ...
    await _flutterTts.speak(text);
  }

  Future<void> setSpeed(double speed) async {
    if (speed < 0.5 || speed > 2.0) {
      throw TtsServiceException('速度は 0.5 〜 2.0 の範囲で指定してください');
    }
    await _flutterTts.setSpeechRate(speed);
    // ...
  }
}
```

#### 4. TtsServiceException の実装

**ファイル**: `lib/features/tts/application/tts_service.dart` (同上)

TTS サービス専用の例外クラス：

```dart
class TtsServiceException implements Exception {
  final String message;
  TtsServiceException(this.message);

  @override
  String toString() => 'TtsServiceException: $message';
}
```

#### 5. ユニットテストの作成

**ファイル**:
- `test/features/tts/domain/models/tts_config_test.dart` (新規作成、120行)
- `test/features/tts/domain/models/tts_state_test.dart` (新規作成、130行)
- `test/features/tts/application/tts_service_test.dart` (新規作成、36行)

**テストカバレッジ**:

1. **TTSConfig テスト**:
   - デフォルト値の検証
   - カスタム値での作成
   - `copyWith` による更新
   - 等価性の検証
   - JSON シリアライズ/デシリアライズ
   - MVP で使用する速度範囲の検証

2. **TTSState テスト**:
   - デフォルト値の検証
   - カスタム値での作成
   - `copyWith` による各プロパティの更新
   - 等価性の検証
   - 状態遷移のテスト
     - 初期化成功
     - 初期化失敗
     - エラーからの復帰

3. **TtsService テスト**:
   - `TtsServiceException` の基本テスト
   - 統合テストは Issue #9 で実装予定（FlutterTts のモックが必要）

### 変更ファイル

**新規作成**:
- `lib/features/tts/domain/models/tts_config.dart` (43行)
- `lib/features/tts/domain/models/tts_state.dart` (21行)
- `lib/features/tts/application/tts_service.dart` (204行)
- `test/features/tts/domain/models/tts_config_test.dart` (120行)
- `test/features/tts/domain/models/tts_state_test.dart` (130行)
- `test/features/tts/application/tts_service_test.dart` (36行)

**統計**:
- 合計: 6ファイル、539行追加

### 成功基準の確認

- [x] TTSConfig モデルを作成（Freezed 使用）
- [x] TTSState モデルを作成
- [x] TtsService を実装（Riverpod 使用）
  - [x] speak(String text) メソッド
  - [x] pause() メソッド
  - [x] stop() メソッド
  - [x] setSpeed(double speed) メソッド
  - [x] setConfig(TTSConfig config) メソッド
  - [x] 読み上げ位置のコールバック設定
- [x] 日本語音声の設定（ja-JP）
- [x] エラーハンドリング
- [x] ユニットテストを作成
- [ ] コード生成を実行（ローカル環境で実施必要）
- [ ] `flutter analyze` でエラーなし（ローカル環境で実施必要）
- [ ] テキストを読み上げできる（実機確認必要）
- [ ] 一時停止・停止が動作する（実機確認必要）
- [ ] 速度設定が反映される（実機確認必要）

### 次のステップ

#### ローカル環境での確認

以下のコマンドを実行してください：

```bash
# コード生成（Freezed と Riverpod）
dart run build_runner build --delete-conflicting-outputs

# 静的解析
flutter analyze

# ユニットテスト実行
flutter test

# 実機でアプリを起動して TTS をテスト
flutter run
```

#### 期待される動作

- コード生成が成功する（`.freezed.dart`, `.g.json.dart`, `.g.dart` ファイルが生成される）
- 静的解析がエラーなく完了する
- すべてのユニットテストが成功する
- 実機でテキスト読み上げが動作する（UI は Issue #6-8 で実装）

#### 次の Issue

- **Issue #6**: 設定画面のスケルトン作成
- **Issue #7**: URL 入力ダイアログの実装
- **Issue #8**: WebView 統合と HTML パーサー連携

### 技術的ハイライト

#### Freezed による型安全なモデル
✅ `TTSConfig` と `TTSState` を Freezed で実装し、イミュータブルで型安全な設計を実現

#### Riverpod による状態管理
✅ `TtsServiceNotifier` を使用して TTS の状態を一元管理
✅ `@riverpod` アノテーションによるコード生成で定型コードを削減

#### 将来の拡張性を考慮
- MVP では `speed` のみ使用
- `pitch`, `volume`, `linePause`, `paragraphPause` は将来対応
- これにより、後から機能を追加しやすい設計

#### 日本語音声の自動設定
- 初期化時に `ja-JP` を自動設定
- ユーザーが手動で設定する必要なし

#### 堅牢なエラーハンドリング
- すべてのメソッドで初期化チェック
- パラメータのバリデーション（速度範囲など）
- エラーメッセージを状態に保存し、UI から参照可能
- 専用の例外クラス `TtsServiceException`

#### 読み上げ進捗コールバック
- 将来の UI 更新機能に備えてコールバックを実装
- 読み上げ中のテキストハイライト機能などに対応可能

### 備考

- Flutter コマンドは実行環境で利用不可のため、コード生成と動作確認はローカル環境で実施してください
- TtsService の統合テストは FlutterTts のモックが必要なため、Issue #9 で実装予定
- UI との統合は Issue #6-8 で実装予定（現在は TTS サービス層のみ）
- 実機での読み上げ確認が必要です（エミュレータでは音声が出ない場合があります）
