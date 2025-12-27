import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yomiagerun_app/features/tts/presentation/speed_settings.dart';
import 'package:yomiagerun_app/features/tts/presentation/speed_settings_notifier.dart';

void main() {
  group('SpeedSettings Widget', () {
    testWidgets('初期表示で速度が 1.0x と表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SpeedSettings(),
            ),
          ),
        ),
      );

      // タイトルが表示されている
      expect(find.text('読み上げ速度'), findsOneWidget);

      // 現在の速度が表示されている
      expect(find.text('現在の速度: 1.0x'), findsOneWidget);

      // リセットボタンが表示されている
      expect(find.text('リセット'), findsOneWidget);

      // スライダーの範囲ラベルが表示されている
      expect(find.text('0.5x'), findsOneWidget);
      expect(find.text('2.0x'), findsOneWidget);
    });

    testWidgets('スライダーが表示されている', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SpeedSettings(),
            ),
          ),
        ),
      );

      // Slider ウィジェットが存在する
      expect(find.byType(Slider), findsOneWidget);

      // Slider の初期値が 1.0
      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.value, 1.0);
      expect(slider.min, 0.5);
      expect(slider.max, 2.0);
      expect(slider.divisions, 15);
    });

    testWidgets('リセットボタンが表示されている', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SpeedSettings(),
            ),
          ),
        ),
      );

      // リセットボタンが表示されている
      expect(find.byIcon(Icons.refresh), findsOneWidget);
      expect(find.text('リセット'), findsOneWidget);

      // TextButton が存在する（リセットボタンとして）
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('Card 内に配置されている', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SpeedSettings(),
            ),
          ),
        ),
      );

      // Card ウィジェットが存在する
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('カスタム初期値で表示できる', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // 初期値を 1.5 に設定
            speedSettingsNotifierProvider
                .overrideWith(() => _TestSpeedSettingsNotifier(1.5)),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: SpeedSettings(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // カスタム速度が表示されている
      expect(find.text('現在の速度: 1.5x'), findsOneWidget);

      // Slider の値も 1.5
      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.value, 1.5);
    });
  });
}

/// テスト用の SpeedSettingsNotifier
class _TestSpeedSettingsNotifier extends SpeedSettingsNotifier {
  _TestSpeedSettingsNotifier(this.initialSpeed);

  final double initialSpeed;

  @override
  double build() {
    return initialSpeed;
  }
}
