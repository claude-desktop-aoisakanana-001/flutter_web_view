// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_reader_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NovelReaderState {
  /// 読み込んだ小説コンテンツ
  NovelContent? get novelContent => throw _privateConstructorUsedError;

  /// 読み込み中かどうか
  bool get isLoading => throw _privateConstructorUsedError;

  /// エラーメッセージ（エラーがない場合は null）
  String? get errorMessage => throw _privateConstructorUsedError;

  /// 現在ハイライト表示している段落の位置
  /// （将来の読み上げ連動機能で使用）
  int get currentHighlightPosition => throw _privateConstructorUsedError;

  /// Create a copy of NovelReaderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelReaderStateCopyWith<NovelReaderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelReaderStateCopyWith<$Res> {
  factory $NovelReaderStateCopyWith(
          NovelReaderState value, $Res Function(NovelReaderState) then) =
      _$NovelReaderStateCopyWithImpl<$Res, NovelReaderState>;
  @useResult
  $Res call(
      {NovelContent? novelContent,
      bool isLoading,
      String? errorMessage,
      int currentHighlightPosition});

  $NovelContentCopyWith<$Res>? get novelContent;
}

/// @nodoc
class _$NovelReaderStateCopyWithImpl<$Res, $Val extends NovelReaderState>
    implements $NovelReaderStateCopyWith<$Res> {
  _$NovelReaderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelReaderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? novelContent = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? currentHighlightPosition = null,
  }) {
    return _then(_value.copyWith(
      novelContent: freezed == novelContent
          ? _value.novelContent
          : novelContent // ignore: cast_nullable_to_non_nullable
              as NovelContent?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      currentHighlightPosition: null == currentHighlightPosition
          ? _value.currentHighlightPosition
          : currentHighlightPosition // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of NovelReaderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NovelContentCopyWith<$Res>? get novelContent {
    if (_value.novelContent == null) {
      return null;
    }

    return $NovelContentCopyWith<$Res>(_value.novelContent!, (value) {
      return _then(_value.copyWith(novelContent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NovelReaderStateImplCopyWith<$Res>
    implements $NovelReaderStateCopyWith<$Res> {
  factory _$$NovelReaderStateImplCopyWith(_$NovelReaderStateImpl value,
          $Res Function(_$NovelReaderStateImpl) then) =
      __$$NovelReaderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NovelContent? novelContent,
      bool isLoading,
      String? errorMessage,
      int currentHighlightPosition});

  @override
  $NovelContentCopyWith<$Res>? get novelContent;
}

/// @nodoc
class __$$NovelReaderStateImplCopyWithImpl<$Res>
    extends _$NovelReaderStateCopyWithImpl<$Res, _$NovelReaderStateImpl>
    implements _$$NovelReaderStateImplCopyWith<$Res> {
  __$$NovelReaderStateImplCopyWithImpl(_$NovelReaderStateImpl _value,
      $Res Function(_$NovelReaderStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelReaderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? novelContent = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? currentHighlightPosition = null,
  }) {
    return _then(_$NovelReaderStateImpl(
      novelContent: freezed == novelContent
          ? _value.novelContent
          : novelContent // ignore: cast_nullable_to_non_nullable
              as NovelContent?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      currentHighlightPosition: null == currentHighlightPosition
          ? _value.currentHighlightPosition
          : currentHighlightPosition // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$NovelReaderStateImpl implements _NovelReaderState {
  const _$NovelReaderStateImpl(
      {this.novelContent,
      this.isLoading = false,
      this.errorMessage,
      this.currentHighlightPosition = 0});

  /// 読み込んだ小説コンテンツ
  @override
  final NovelContent? novelContent;

  /// 読み込み中かどうか
  @override
  @JsonKey()
  final bool isLoading;

  /// エラーメッセージ（エラーがない場合は null）
  @override
  final String? errorMessage;

  /// 現在ハイライト表示している段落の位置
  /// （将来の読み上げ連動機能で使用）
  @override
  @JsonKey()
  final int currentHighlightPosition;

  @override
  String toString() {
    return 'NovelReaderState(novelContent: $novelContent, isLoading: $isLoading, errorMessage: $errorMessage, currentHighlightPosition: $currentHighlightPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelReaderStateImpl &&
            (identical(other.novelContent, novelContent) ||
                other.novelContent == novelContent) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(
                    other.currentHighlightPosition, currentHighlightPosition) ||
                other.currentHighlightPosition == currentHighlightPosition));
  }

  @override
  int get hashCode => Object.hash(runtimeType, novelContent, isLoading,
      errorMessage, currentHighlightPosition);

  /// Create a copy of NovelReaderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelReaderStateImplCopyWith<_$NovelReaderStateImpl> get copyWith =>
      __$$NovelReaderStateImplCopyWithImpl<_$NovelReaderStateImpl>(
          this, _$identity);
}

abstract class _NovelReaderState implements NovelReaderState {
  const factory _NovelReaderState(
      {final NovelContent? novelContent,
      final bool isLoading,
      final String? errorMessage,
      final int currentHighlightPosition}) = _$NovelReaderStateImpl;

  /// 読み込んだ小説コンテンツ
  @override
  NovelContent? get novelContent;

  /// 読み込み中かどうか
  @override
  bool get isLoading;

  /// エラーメッセージ（エラーがない場合は null）
  @override
  String? get errorMessage;

  /// 現在ハイライト表示している段落の位置
  /// （将来の読み上げ連動機能で使用）
  @override
  int get currentHighlightPosition;

  /// Create a copy of NovelReaderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelReaderStateImplCopyWith<_$NovelReaderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
