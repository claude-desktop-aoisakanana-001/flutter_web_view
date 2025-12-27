// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yomiagerun_app/app/app.dart';

void main() {
  testWidgets('App shows NovelReaderScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    // Verify that the app title is displayed
    expect(find.text('よみあげRun'), findsWidgets);

    // Verify that the placeholder text is displayed
    expect(find.text('小説閲覧画面（準備中）'), findsOneWidget);

    // Verify that the settings button is displayed
    expect(find.byIcon(Icons.settings), findsOneWidget);

    // Verify that the FAB is displayed
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
