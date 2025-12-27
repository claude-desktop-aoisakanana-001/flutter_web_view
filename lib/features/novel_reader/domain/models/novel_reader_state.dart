import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yomiagerun_app/features/novel_reader/domain/models/novel_content.dart';

part 'novel_reader_state.freezed.dart';

/// 小説リーダーの状態を表すモデル
///
/// 読み込み中、エラー、コンテンツ表示などの状態を管理します。
@freezed
class NovelReaderState with _$NovelReaderState {
  const factory NovelReaderState({
    /// 読み込んだ小説コンテンツ
    NovelContent? novelContent,

    /// 読み込み中かどうか
    @Default(false) bool isLoading,

    /// エラーメッセージ（エラーがない場合は null）
    String? errorMessage,

    /// 現在ハイライト表示している段落の位置
    /// （将来の読み上げ連動機能で使用）
    @Default(0) int currentHighlightPosition,
  }) = _NovelReaderState;
}
