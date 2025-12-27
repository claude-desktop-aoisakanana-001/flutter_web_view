import 'package:freezed_annotation/freezed_annotation.dart';

part 'parsed_novel.freezed.dart';
part 'parsed_novel.g.json.dart';

/// 小説家になろうから解析した小説データ
///
/// WebView + JavaScript Injection により取得したDOMデータを保持します。
@freezed
class ParsedNovel with _$ParsedNovel {
  const factory ParsedNovel({
    /// 小説タイトル
    required String title,

    /// 作者名
    required String author,

    /// 本文段落のリスト
    /// 各要素が1つの段落（<p>タグ）に対応
    required List<String> paragraphs,

    /// 追加のメタデータ（オプション）
    /// 例: 前書き、後書き、章タイトルなど
    Map<String, String>? metadata,
  }) = _ParsedNovel;

  factory ParsedNovel.fromJson(Map<String, dynamic> json) =>
      _$ParsedNovelFromJson(json);
}
