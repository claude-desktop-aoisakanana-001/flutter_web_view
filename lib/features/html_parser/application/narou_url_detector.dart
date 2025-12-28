/// 小説家になろうの URL パターン検出ユーティリティ
///
/// 小説ページのURLを検出し、ページタイプを判定します。
class NarouUrlDetector {
  /// 小説本文ページのパターン（連載）
  /// 例: https://ncode.syosetu.com/n1234ab/1/
  static final RegExp _novelPagePattern = RegExp(
    r'^https?://ncode\.syosetu\.com/n\w+/\d+/?$',
  );

  /// 短編小説のパターン
  /// 例: https://ncode.syosetu.com/n1234ab/
  static final RegExp _shortStoryPattern = RegExp(
    r'^https?://ncode\.syosetu\.com/n\w+/?$',
  );

  /// URLが小説ページかどうかを判定
  ///
  /// [url] 判定対象のURL
  /// 戻り値: 小説ページの場合 true、それ以外は false
  static bool isNovelPage(String url) {
    return _novelPagePattern.hasMatch(url) ||
        _shortStoryPattern.hasMatch(url);
  }

  /// ページタイプを判定
  ///
  /// [url] 判定対象のURL
  /// 戻り値: ページタイプ（連載/短編）、小説ページでない場合は null
  static NovelPageType? getPageType(String url) {
    if (_novelPagePattern.hasMatch(url)) {
      return NovelPageType.series;
    } else if (_shortStoryPattern.hasMatch(url)) {
      return NovelPageType.shortStory;
    }
    return null;
  }
}

/// 小説ページのタイプ
enum NovelPageType {
  /// 連載小説
  series,

  /// 短編小説
  shortStory,
}
