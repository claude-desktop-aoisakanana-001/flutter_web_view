// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NovelContent _$NovelContentFromJson(Map<String, dynamic> json) {
  return _NovelContent.fromJson(json);
}

/// @nodoc
mixin _$NovelContent {
  /// 小説タイトル
  String get title => throw _privateConstructorUsedError;

  /// 作者名
  String get author => throw _privateConstructorUsedError;

  /// 小説のURL
  String get url => throw _privateConstructorUsedError;

  /// 本文の段落リスト
  List<String> get paragraphs => throw _privateConstructorUsedError;

  /// 取得日時
  DateTime? get fetchedAt => throw _privateConstructorUsedError;

  /// Serializes this NovelContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NovelContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelContentCopyWith<NovelContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelContentCopyWith<$Res> {
  factory $NovelContentCopyWith(
          NovelContent value, $Res Function(NovelContent) then) =
      _$NovelContentCopyWithImpl<$Res, NovelContent>;
  @useResult
  $Res call(
      {String title,
      String author,
      String url,
      List<String> paragraphs,
      DateTime? fetchedAt});
}

/// @nodoc
class _$NovelContentCopyWithImpl<$Res, $Val extends NovelContent>
    implements $NovelContentCopyWith<$Res> {
  _$NovelContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? author = null,
    Object? url = null,
    Object? paragraphs = null,
    Object? fetchedAt = freezed,
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
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphs: null == paragraphs
          ? _value.paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fetchedAt: freezed == fetchedAt
          ? _value.fetchedAt
          : fetchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NovelContentImplCopyWith<$Res>
    implements $NovelContentCopyWith<$Res> {
  factory _$$NovelContentImplCopyWith(
          _$NovelContentImpl value, $Res Function(_$NovelContentImpl) then) =
      __$$NovelContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String author,
      String url,
      List<String> paragraphs,
      DateTime? fetchedAt});
}

/// @nodoc
class __$$NovelContentImplCopyWithImpl<$Res>
    extends _$NovelContentCopyWithImpl<$Res, _$NovelContentImpl>
    implements _$$NovelContentImplCopyWith<$Res> {
  __$$NovelContentImplCopyWithImpl(
      _$NovelContentImpl _value, $Res Function(_$NovelContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? author = null,
    Object? url = null,
    Object? paragraphs = null,
    Object? fetchedAt = freezed,
  }) {
    return _then(_$NovelContentImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphs: null == paragraphs
          ? _value._paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fetchedAt: freezed == fetchedAt
          ? _value.fetchedAt
          : fetchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelContentImpl implements _NovelContent {
  const _$NovelContentImpl(
      {required this.title,
      required this.author,
      required this.url,
      required final List<String> paragraphs,
      this.fetchedAt})
      : _paragraphs = paragraphs;

  factory _$NovelContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelContentImplFromJson(json);

  /// 小説タイトル
  @override
  final String title;

  /// 作者名
  @override
  final String author;

  /// 小説のURL
  @override
  final String url;

  /// 本文の段落リスト
  final List<String> _paragraphs;

  /// 本文の段落リスト
  @override
  List<String> get paragraphs {
    if (_paragraphs is EqualUnmodifiableListView) return _paragraphs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paragraphs);
  }

  /// 取得日時
  @override
  final DateTime? fetchedAt;

  @override
  String toString() {
    return 'NovelContent(title: $title, author: $author, url: $url, paragraphs: $paragraphs, fetchedAt: $fetchedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelContentImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality()
                .equals(other._paragraphs, _paragraphs) &&
            (identical(other.fetchedAt, fetchedAt) ||
                other.fetchedAt == fetchedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, author, url,
      const DeepCollectionEquality().hash(_paragraphs), fetchedAt);

  /// Create a copy of NovelContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelContentImplCopyWith<_$NovelContentImpl> get copyWith =>
      __$$NovelContentImplCopyWithImpl<_$NovelContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelContentImplToJson(
      this,
    );
  }
}

abstract class _NovelContent implements NovelContent {
  const factory _NovelContent(
      {required final String title,
      required final String author,
      required final String url,
      required final List<String> paragraphs,
      final DateTime? fetchedAt}) = _$NovelContentImpl;

  factory _NovelContent.fromJson(Map<String, dynamic> json) =
      _$NovelContentImpl.fromJson;

  /// 小説タイトル
  @override
  String get title;

  /// 作者名
  @override
  String get author;

  /// 小説のURL
  @override
  String get url;

  /// 本文の段落リスト
  @override
  List<String> get paragraphs;

  /// 取得日時
  @override
  DateTime? get fetchedAt;

  /// Create a copy of NovelContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelContentImplCopyWith<_$NovelContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
