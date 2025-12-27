import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yomiagerun_app/features/html_parser/application/narou_parser_service.dart';
import 'package:yomiagerun_app/features/html_parser/application/webview_helper.dart';
import 'package:yomiagerun_app/features/novel_reader/domain/models/novel_content.dart';
import 'package:yomiagerun_app/features/novel_reader/domain/models/novel_reader_state.dart';

part 'novel_reader_notifier.g.dart';

/// 小説リーダーの状態を管理する Notifier
///
/// URL から小説を読み込み、表示用のデータを管理します。
@riverpod
class NovelReaderNotifier extends _$NovelReaderNotifier {
  WebViewController? _webViewController;

  @override
  NovelReaderState build() {
    return const NovelReaderState();
  }

  /// WebViewController を取得または作成
  ///
  /// テスト環境では WebViewController が作成されないように遅延初期化します。
  WebViewController _getOrCreateController() {
    if (_webViewController == null) {
      _webViewController = WebViewHelper.createController();
    }
    return _webViewController!;
  }

  /// URL から小説を読み込む
  ///
  /// [url] 小説のURL（例: https://ncode.syosetu.com/n1234ab/1/）
  ///
  /// エラーが発生した場合はエラーメッセージを状態に設定します。
  Future<void> loadNovel(String url) async {
    if (url.isEmpty) {
      state = state.copyWith(
        errorMessage: 'URLを入力してください',
      );
      return;
    }

    // ローディング開始
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      // WebViewController を取得（遅延初期化）
      final controller = _getOrCreateController();

      // NarouParserService を使用して小説を解析
      final parserService = ref.read(narouParserServiceProvider.notifier);
      final parsedNovel = await parserService.parseFromWebView(
        webViewController: controller,
        url: url,
      );

      // NovelContent に変換
      final novelContent = NovelContent(
        title: parsedNovel.title,
        author: parsedNovel.author,
        url: url,
        paragraphs: parsedNovel.paragraphs,
        fetchedAt: DateTime.now(),
      );

      // 状態を更新
      state = state.copyWith(
        novelContent: novelContent,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      // エラーハンドリング
      state = state.copyWith(
        isLoading: false,
        errorMessage: '小説の読み込みに失敗しました: $e',
      );
    }
  }

  /// ハイライト位置を設定
  ///
  /// [position] 段落のインデックス
  ///
  /// 将来の読み上げ連動機能で使用します。
  void setHighlightPosition(int position) {
    state = state.copyWith(currentHighlightPosition: position);
  }

  /// 小説をクリア
  void clearNovel() {
    state = const NovelReaderState();
  }
}
