import 'package:freezed_annotation/freezed_annotation.dart';

part 'novel_content.freezed.dart';
part 'novel_content.g.dart';

/// 小説のコンテンツを表すモデル
///
/// HTML パーサーから取得したデータと URL 情報を保持します。
@freezed
class NovelContent with _$NovelContent {
  const factory NovelContent({
    /// 小説タイトル
    required String title,

    /// 作者名
    required String author,

    /// 小説のURL
    required String url,

    /// 本文の段落リスト
    required List<String> paragraphs,

    /// 取得日時
    DateTime? fetchedAt,
  }) = _NovelContent;

  factory NovelContent.fromJson(Map<String, dynamic> json) =>
      _$NovelContentFromJson(json);
}
