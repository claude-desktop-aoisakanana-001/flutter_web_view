import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/tts/domain/models/tts_config.dart';

void main() {
  group('TTSConfig', () {
    test('デフォルト値で作成できる', () {
      const config = TTSConfig();

      expect(config.speed, 1.0);
      expect(config.pitch, 1.0);
      expect(config.volume, 1.0);
      expect(config.linePause, 0.0);
      expect(config.paragraphPause, 0.0);
    });

    test('カスタム値で作成できる', () {
      const config = TTSConfig(
        speed: 1.5,
        pitch: 0.8,
        volume: 0.9,
        linePause: 0.5,
        paragraphPause: 1.0,
      );

      expect(config.speed, 1.5);
      expect(config.pitch, 0.8);
      expect(config.volume, 0.9);
      expect(config.linePause, 0.5);
      expect(config.paragraphPause, 1.0);
    });

    test('copyWith で値を更新できる', () {
      const original = TTSConfig(speed: 1.0);
      final updated = original.copyWith(speed: 2.0);

      expect(original.speed, 1.0);
      expect(updated.speed, 2.0);
      expect(updated.pitch, 1.0); // 他の値は変わらない
    });

    test('同じ値を持つインスタンスは等しい', () {
      const config1 = TTSConfig(speed: 1.5, pitch: 0.8);
      const config2 = TTSConfig(speed: 1.5, pitch: 0.8);

      expect(config1, config2);
      expect(config1.hashCode, config2.hashCode);
    });

    test('異なる値を持つインスタンスは等しくない', () {
      const config1 = TTSConfig(speed: 1.5);
      const config2 = TTSConfig(speed: 2.0);

      expect(config1, isNot(config2));
    });

    test('JSON にシリアライズできる', () {
      const config = TTSConfig(
        speed: 1.5,
        pitch: 0.8,
        volume: 0.9,
        linePause: 0.5,
        paragraphPause: 1.0,
      );

      final json = config.toJson();

      expect(json['speed'], 1.5);
      expect(json['pitch'], 0.8);
      expect(json['volume'], 0.9);
      expect(json['linePause'], 0.5);
      expect(json['paragraphPause'], 1.0);
    });

    test('JSON からデシリアライズできる', () {
      final json = {
        'speed': 1.5,
        'pitch': 0.8,
        'volume': 0.9,
        'linePause': 0.5,
        'paragraphPause': 1.0,
      };

      final config = TTSConfig.fromJson(json);

      expect(config.speed, 1.5);
      expect(config.pitch, 0.8);
      expect(config.volume, 0.9);
      expect(config.linePause, 0.5);
      expect(config.paragraphPause, 1.0);
    });

    test('MVP で使用する速度の範囲を検証', () {
      // 最小速度
      const slowConfig = TTSConfig(speed: 0.5);
      expect(slowConfig.speed, 0.5);

      // 通常速度
      const normalConfig = TTSConfig(speed: 1.0);
      expect(normalConfig.speed, 1.0);

      // 最大速度
      const fastConfig = TTSConfig(speed: 2.0);
      expect(fastConfig.speed, 2.0);
    });
  });
}
