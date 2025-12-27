// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_novel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ParsedNovel _$ParsedNovelFromJson(Map<String, dynamic> json) {
  return _ParsedNovel.fromJson(json);
}

/// @nodoc
mixin _$ParsedNovel {
  /// 小説タイトル
  String get title => throw _privateConstructorUsedError;

  /// 作者名
  String get author => throw _privateConstructorUsedError;

  /// 本文段落のリスト
  /// 各要素が1つの段落（<p>タグ）に対応
  List<String> get paragraphs => throw _privateConstructorUsedError;

  /// 追加のメタデータ（オプション）
  /// 例: 前書き、後書き、章タイトルなど
  Map<String, String>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this ParsedNovel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParsedNovel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParsedNovelCopyWith<ParsedNovel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedNovelCopyWith<$Res> {
  factory $ParsedNovelCopyWith(
          ParsedNovel value, $Res Function(ParsedNovel) then) =
      _$ParsedNovelCopyWithImpl<$Res, ParsedNovel>;
  @useResult
  $Res call(
      {String title,
      String author,
      List<String> paragraphs,
      Map<String, String>? metadata});
}

/// @nodoc
class _$ParsedNovelCopyWithImpl<$Res, $Val extends ParsedNovel>
    implements $ParsedNovelCopyWith<$Res> {
  _$ParsedNovelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParsedNovel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? author = null,
    Object? paragraphs = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphs: null == paragraphs
          ? _value.paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParsedNovelImplCopyWith<$Res>
    implements $ParsedNovelCopyWith<$Res> {
  factory _$$ParsedNovelImplCopyWith(
          _$ParsedNovelImpl value, $Res Function(_$ParsedNovelImpl) then) =
      __$$ParsedNovelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String author,
      List<String> paragraphs,
      Map<String, String>? metadata});
}

/// @nodoc
class __$$ParsedNovelImplCopyWithImpl<$Res>
    extends _$ParsedNovelCopyWithImpl<$Res, _$ParsedNovelImpl>
    implements _$$ParsedNovelImplCopyWith<$Res> {
  __$$ParsedNovelImplCopyWithImpl(
      _$ParsedNovelImpl _value, $Res Function(_$ParsedNovelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ParsedNovel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? author = null,
    Object? paragraphs = null,
    Object? metadata = freezed,
  }) {
    return _then(_$ParsedNovelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphs: null == paragraphs
          ? _value._paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedNovelImpl implements _ParsedNovel {
  const _$ParsedNovelImpl(
      {required this.title,
      required this.author,
      required final List<String> paragraphs,
      final Map<String, String>? metadata})
      : _paragraphs = paragraphs,
        _metadata = metadata;

  factory _$ParsedNovelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParsedNovelImplFromJson(json);

  /// 小説タイトル
  @override
  final String title;

  /// 作者名
  @override
  final String author;

  /// 本文段落のリスト
  /// 各要素が1つの段落（<p>タグ）に対応
  final List<String> _paragraphs;

  /// 本文段落のリスト
  /// 各要素が1つの段落（<p>タグ）に対応
  @override
  List<String> get paragraphs {
    if (_paragraphs is EqualUnmodifiableListView) return _paragraphs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paragraphs);
  }

  /// 追加のメタデータ（オプション）
  /// 例: 前書き、後書き、章タイトルなど
  final Map<String, String>? _metadata;

  /// 追加のメタデータ（オプション）
  /// 例: 前書き、後書き、章タイトルなど
  @override
  Map<String, String>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ParsedNovel(title: $title, author: $author, paragraphs: $paragraphs, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedNovelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality()
                .equals(other._paragraphs, _paragraphs) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      author,
      const DeepCollectionEquality().hash(_paragraphs),
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of ParsedNovel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedNovelImplCopyWith<_$ParsedNovelImpl> get copyWith =>
      __$$ParsedNovelImplCopyWithImpl<_$ParsedNovelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParsedNovelImplToJson(
      this,
    );
  }
}

abstract class _ParsedNovel implements ParsedNovel {
  const factory _ParsedNovel(
      {required final String title,
      required final String author,
      required final List<String> paragraphs,
      final Map<String, String>? metadata}) = _$ParsedNovelImpl;

  factory _ParsedNovel.fromJson(Map<String, dynamic> json) =
      _$ParsedNovelImpl.fromJson;

  /// 小説タイトル
  @override
  String get title;

  /// 作者名
  @override
  String get author;

  /// 本文段落のリスト
  /// 各要素が1つの段落（<p>タグ）に対応
  @override
  List<String> get paragraphs;

  /// 追加のメタデータ（オプション）
  /// 例: 前書き、後書き、章タイトルなど
  @override
  Map<String, String>? get metadata;

  /// Create a copy of ParsedNovel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParsedNovelImplCopyWith<_$ParsedNovelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
