import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/tts/domain/models/tts_config.dart';
import 'package:yomiagerun_app/features/tts/domain/models/tts_state.dart';

void main() {
  group('TTSState', () {
    test('デフォルト値で作成できる', () {
      const state = TTSState();

      expect(state.isInitialized, false);
      expect(state.config, null);
      expect(state.errorMessage, null);
    });

    test('カスタム値で作成できる', () {
      const config = TTSConfig(speed: 1.5);
      const state = TTSState(
        isInitialized: true,
        config: config,
        errorMessage: 'エラーメッセージ',
      );

      expect(state.isInitialized, true);
      expect(state.config, config);
      expect(state.errorMessage, 'エラーメッセージ');
    });

    test('copyWith で初期化状態を更新できる', () {
      const original = TTSState(isInitialized: false);
      final updated = original.copyWith(isInitialized: true);

      expect(original.isInitialized, false);
      expect(updated.isInitialized, true);
    });

    test('copyWith で設定を更新できる', () {
      const config1 = TTSConfig(speed: 1.0);
      const config2 = TTSConfig(speed: 1.5);

      const original = TTSState(config: config1);
      final updated = original.copyWith(config: config2);

      expect(original.config?.speed, 1.0);
      expect(updated.config?.speed, 1.5);
    });

    test('copyWith でエラーメッセージを更新できる', () {
      const original = TTSState();
      final updated = original.copyWith(errorMessage: 'エラーが発生しました');

      expect(original.errorMessage, null);
      expect(updated.errorMessage, 'エラーが発生しました');
    });

    test('copyWith でエラーメッセージをクリアできる', () {
      const original = TTSState(errorMessage: 'エラー');
      final updated = original.copyWith(errorMessage: null);

      expect(original.errorMessage, 'エラー');
      expect(updated.errorMessage, null);
    });

    test('同じ値を持つインスタンスは等しい', () {
      const config = TTSConfig(speed: 1.5);
      const state1 = TTSState(
        isInitialized: true,
        config: config,
      );
      const state2 = TTSState(
        isInitialized: true,
        config: config,
      );

      expect(state1, state2);
      expect(state1.hashCode, state2.hashCode);
    });

    test('異なる値を持つインスタンスは等しくない', () {
      const state1 = TTSState(isInitialized: false);
      const state2 = TTSState(isInitialized: true);

      expect(state1, isNot(state2));
    });

    test('初期化成功の状態遷移', () {
      // 初期状態
      const initial = TTSState();
      expect(initial.isInitialized, false);
      expect(initial.config, null);
      expect(initial.errorMessage, null);

      // 初期化成功
      const config = TTSConfig();
      final initialized = initial.copyWith(
        isInitialized: true,
        config: config,
        errorMessage: null,
      );
      expect(initialized.isInitialized, true);
      expect(initialized.config, config);
      expect(initialized.errorMessage, null);
    });

    test('初期化失敗の状態遷移', () {
      // 初期状態
      const initial = TTSState();

      // 初期化失敗
      final failed = initial.copyWith(
        isInitialized: false,
        errorMessage: '初期化に失敗しました',
      );
      expect(failed.isInitialized, false);
      expect(failed.errorMessage, '初期化に失敗しました');
    });

    test('エラーからの復帰の状態遷移', () {
      // エラー状態
      const errorState = TTSState(
        isInitialized: true,
        config: TTSConfig(),
        errorMessage: 'エラーが発生しました',
      );

      // エラーをクリア
      final recovered = errorState.copyWith(errorMessage: null);
      expect(recovered.isInitialized, true);
      expect(recovered.errorMessage, null);
    });
  });
}
