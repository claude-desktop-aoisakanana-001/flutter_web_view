import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../domain/models/parsed_novel.dart';

part 'narou_parser_service.g.dart';

/// 小説家になろうのHTML解析サービス
///
/// WebView + JavaScript Injection を使用して、
/// 利用規約を遵守しながら小説データを取得します。
@riverpod
class NarouParserService extends _$NarouParserService {
  @override
  void build() {
    // 初期化処理（必要に応じて）
  }

  /// WebView経由で小説データを解析
  ///
  /// [webViewController] WebViewのコントローラー
  /// [url] 小説のURL
  ///
  /// Returns 解析済みの小説データ
  /// Throws [ParserException] 解析に失敗した場合
  Future<ParsedNovel> parseFromWebView({
    required WebViewController webViewController,
    required String url,
  }) async {
    try {
      // 1. WebView でページを読み込み
      await webViewController.loadRequest(Uri.parse(url));

      // 2. ページ読み込み完了を待機
      await _waitForPageLoad(webViewController);

      // 3. JavaScript Injection で DOM から情報を取得
      final title = await _extractTitle(webViewController);
      final author = await _extractAuthor(webViewController);
      final paragraphs = await _extractParagraphs(webViewController);

      // 4. オプション: メタデータ取得
      final metadata = await _extractMetadata(webViewController);

      // 5. ParsedNovel モデルに変換
      return ParsedNovel(
        title: title,
        author: author,
        paragraphs: paragraphs,
        metadata: metadata,
      );
    } catch (e) {
      throw ParserException('小説の解析に失敗しました: $e');
    }
  }

  /// ページ読み込み完了を待機
  ///
  /// document.readyState が 'complete' になるまで待機します。
  Future<void> _waitForPageLoad(WebViewController controller) async {
    const maxAttempts = 30; // 最大30秒待機
    const delayMs = 1000; // 1秒ごとにチェック

    for (var i = 0; i < maxAttempts; i++) {
      try {
        final readyState = await controller.runJavaScriptReturningResult(
          "document.readyState",
        ) as String;

        if (readyState == '"complete"' || readyState == 'complete') {
          // ページ読み込み完了
          return;
        }
      } catch (e) {
        // JavaScript実行エラーは無視して再試行
      }

      await Future.delayed(const Duration(milliseconds: delayMs));
    }

    throw ParserException('ページの読み込みがタイムアウトしました');
  }

  /// タイトルを抽出
  Future<String> _extractTitle(WebViewController controller) async {
    try {
      // デバッグ: ページのタイトル要素を確認
      final titleDebug = await controller.runJavaScriptReturningResult(
        """
        (function() {
          const titleEl = document.querySelector('.novel_title');
          const pageTitle = document.title;
          return JSON.stringify({
            hasElement: !!titleEl,
            text: titleEl?.textContent?.trim() || '',
            pageTitle: pageTitle,
            allH1: Array.from(document.querySelectorAll('h1')).map(h => h.textContent.trim()),
            allH2: Array.from(document.querySelectorAll('h2')).map(h => h.textContent.trim())
          });
        })()
        """,
      );
      print('DEBUG Title: $titleDebug');

      final result = await controller.runJavaScriptReturningResult(
        "document.querySelector('.novel_title')?.textContent?.trim() || document.title || ''",
      );
      return _cleanString(result.toString());
    } catch (e) {
      throw ParserException('タイトルの取得に失敗しました: $e');
    }
  }

  /// 作者名を抽出
  Future<String> _extractAuthor(WebViewController controller) async {
    try {
      // デバッグ: ページの作者要素を確認
      final authorDebug = await controller.runJavaScriptReturningResult(
        """
        (function() {
          const authorEl = document.querySelector('.novel_writername');
          const authorLink = document.querySelector('a[href*="/mypage/"]');
          return JSON.stringify({
            hasElement: !!authorEl,
            text: authorEl?.textContent?.trim() || '',
            linkText: authorLink?.textContent?.trim() || '',
            allClasses: Array.from(document.querySelectorAll('[class*="writer"], [class*="author"]')).map(el => ({
              class: el.className,
              text: el.textContent.trim()
            }))
          });
        })()
        """,
      );
      print('DEBUG Author: $authorDebug');

      // 作者名を取得し、「作: 」などのプレフィックスを削除
      final result = await controller.runJavaScriptReturningResult(
        """
        (function() {
          const authorEl = document.querySelector('.novel_writername');
          if (!authorEl) {
            const authorLink = document.querySelector('a[href*="/mypage/"]');
            return authorLink?.textContent?.trim() || 'Unknown';
          }
          let authorText = authorEl.textContent.trim();
          // 「作: 」「作者: 」などのプレフィックスを削除
          authorText = authorText.replace(/^(作|作者|著者)[:：]\s*/, '');
          return authorText || 'Unknown';
        })()
        """,
      );
      return _cleanString(result.toString());
    } catch (e) {
      throw ParserException('作者名の取得に失敗しました: $e');
    }
  }

  /// 本文段落を抽出
  Future<List<String>> _extractParagraphs(WebViewController controller) async {
    try {
      // デバッグ: ページの本文要素を確認
      final paragraphDebug = await controller.runJavaScriptReturningResult(
        """
        (function() {
          const honbunEl = document.querySelector('#novel_honbun');
          const pElements = document.querySelectorAll('#novel_honbun p');
          return JSON.stringify({
            hasHonbun: !!honbunEl,
            pCount: pElements.length,
            firstPText: pElements[0]?.textContent?.trim() || '',
            allDivIds: Array.from(document.querySelectorAll('div[id]')).map(d => d.id),
            bodyText: document.body?.textContent?.substring(0, 200) || ''
          });
        })()
        """,
      );
      print('DEBUG Paragraphs: $paragraphDebug');

      // JavaScript で段落を配列として取得し、JSON形式で返す
      final result = await controller.runJavaScriptReturningResult(
        """
        (function() {
          // 複数のセレクタを試す
          let paragraphs = [];
          const selectors = ['#novel_honbun p', '#novel_view p', '.novel_view p', '.novel_body p'];

          for (const selector of selectors) {
            const elements = document.querySelectorAll(selector);
            if (elements.length > 0) {
              paragraphs = Array.from(elements)
                .map(p => p.textContent.trim())
                .filter(text => text.length > 0);
              break;
            }
          }

          return JSON.stringify(paragraphs);
        })()
        """,
      );

      final jsonString = _cleanString(result.toString());
      final List<dynamic> paragraphsJson = jsonDecode(jsonString);

      if (paragraphsJson.isEmpty) {
        throw ParserException('本文が見つかりませんでした');
      }

      return paragraphsJson.map((p) => p.toString()).toList();
    } catch (e) {
      throw ParserException('本文の取得に失敗しました: $e');
    }
  }

  /// メタデータを抽出（オプション）
  Future<Map<String, String>?> _extractMetadata(
    WebViewController controller,
  ) async {
    try {
      final metadata = <String, String>{};

      // 前書きを取得
      final preface = await controller.runJavaScriptReturningResult(
        "document.querySelector('#novel_p')?.textContent?.trim() || ''",
      );
      if (preface.toString().isNotEmpty) {
        metadata['preface'] = _cleanString(preface.toString());
      }

      // 後書きを取得
      final postscript = await controller.runJavaScriptReturningResult(
        "document.querySelector('#novel_a')?.textContent?.trim() || ''",
      );
      if (postscript.toString().isNotEmpty) {
        metadata['postscript'] = _cleanString(postscript.toString());
      }

      // サブタイトル（章タイトル）を取得
      final subtitle = await controller.runJavaScriptReturningResult(
        "document.querySelector('.novel_subtitle')?.textContent?.trim() || ''",
      );
      if (subtitle.toString().isNotEmpty) {
        metadata['subtitle'] = _cleanString(subtitle.toString());
      }

      return metadata.isNotEmpty ? metadata : null;
    } catch (e) {
      // メタデータ取得失敗は許容（nullを返す）
      return null;
    }
  }

  /// 文字列をクリーンアップ
  ///
  /// JavaScriptから返された文字列から不要なクォートを削除します。
  String _cleanString(String input) {
    var result = input.trim();
    // ダブルクォートで囲まれている場合は削除
    if (result.startsWith('"') && result.endsWith('"')) {
      result = result.substring(1, result.length - 1);
    }
    // エスケープされた文字を処理
    result = result.replaceAll(r'\"', '"');
    result = result.replaceAll(r'\n', '\n');
    result = result.replaceAll(r'\t', '\t');
    return result;
  }
}

/// パーサーの例外クラス
class ParserException implements Exception {
  final String message;

  ParserException(this.message);

  @override
  String toString() => 'ParserException: $message';
}
