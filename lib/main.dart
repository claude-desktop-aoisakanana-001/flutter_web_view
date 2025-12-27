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
