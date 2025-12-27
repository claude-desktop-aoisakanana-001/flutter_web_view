import 'package:flutter/material.dart';
import 'package:yomiagerun_app/features/novel_reader/presentation/novel_reader_screen.dart';

/// アプリケーションのルートウィジェット
///
/// MaterialApp の設定、テーマ、ルーティングを管理します。
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'よみあげRun',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Material 3 デザイン
        useMaterial3: true,

        // カラースキーム
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),

        // AppBar テーマ
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),

        // テキストテーマ
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, height: 1.8),
          bodyMedium: TextStyle(fontSize: 16, height: 1.6),
        ),
      ),

      // ダークテーマ
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, height: 1.8),
          bodyMedium: TextStyle(fontSize: 16, height: 1.6),
        ),
      ),

      // デフォルトはライトテーマ
      themeMode: ThemeMode.system,

      // ホーム画面
      home: const NovelReaderScreen(),
    );
  }
}
