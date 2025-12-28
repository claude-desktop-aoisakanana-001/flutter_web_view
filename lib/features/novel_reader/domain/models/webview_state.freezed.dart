// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'webview_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WebViewState {
  /// 現在表示中のURL
  String get currentUrl => throw _privateConstructorUsedError;

  /// ページ読み込み中かどうか
  bool get isLoading => throw _privateConstructorUsedError;

  /// 戻るボタンが有効かどうか
  bool get canGoBack => throw _privateConstructorUsedError;

  /// 進むボタンが有効かどうか
  bool get canGoForward => throw _privateConstructorUsedError;

  /// ページタイトル（将来使用）
  String? get pageTitle => throw _privateConstructorUsedError;

  /// Create a copy of WebViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebViewStateCopyWith<WebViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebViewStateCopyWith<$Res> {
  factory $WebViewStateCopyWith(
          WebViewState value, $Res Function(WebViewState) then) =
      _$WebViewStateCopyWithImpl<$Res, WebViewState>;
  @useResult
  $Res call(
      {String currentUrl,
      bool isLoading,
      bool canGoBack,
      bool canGoForward,
      String? pageTitle});
}

/// @nodoc
class _$WebViewStateCopyWithImpl<$Res, $Val extends WebViewState>
    implements $WebViewStateCopyWith<$Res> {
  _$WebViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUrl = null,
    Object? isLoading = null,
    Object? canGoBack = null,
    Object? canGoForward = null,
    Object? pageTitle = freezed,
  }) {
    return _then(_value.copyWith(
      currentUrl: null == currentUrl
          ? _value.currentUrl
          : currentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      canGoBack: null == canGoBack
          ? _value.canGoBack
          : canGoBack // ignore: cast_nullable_to_non_nullable
              as bool,
      canGoForward: null == canGoForward
          ? _value.canGoForward
          : canGoForward // ignore: cast_nullable_to_non_nullable
              as bool,
      pageTitle: freezed == pageTitle
          ? _value.pageTitle
          : pageTitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebViewStateImplCopyWith<$Res>
    implements $WebViewStateCopyWith<$Res> {
  factory _$$WebViewStateImplCopyWith(
          _$WebViewStateImpl value, $Res Function(_$WebViewStateImpl) then) =
      __$$WebViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currentUrl,
      bool isLoading,
      bool canGoBack,
      bool canGoForward,
      String? pageTitle});
}

/// @nodoc
class __$$WebViewStateImplCopyWithImpl<$Res>
    extends _$WebViewStateCopyWithImpl<$Res, _$WebViewStateImpl>
    implements _$$WebViewStateImplCopyWith<$Res> {
  __$$WebViewStateImplCopyWithImpl(
      _$WebViewStateImpl _value, $Res Function(_$WebViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUrl = null,
    Object? isLoading = null,
    Object? canGoBack = null,
    Object? canGoForward = null,
    Object? pageTitle = freezed,
  }) {
    return _then(_$WebViewStateImpl(
      currentUrl: null == currentUrl
          ? _value.currentUrl
          : currentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      canGoBack: null == canGoBack
          ? _value.canGoBack
          : canGoBack // ignore: cast_nullable_to_non_nullable
              as bool,
      canGoForward: null == canGoForward
          ? _value.canGoForward
          : canGoForward // ignore: cast_nullable_to_non_nullable
              as bool,
      pageTitle: freezed == pageTitle
          ? _value.pageTitle
          : pageTitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WebViewStateImpl implements _WebViewState {
  const _$WebViewStateImpl(
      {this.currentUrl = '',
      this.isLoading = false,
      this.canGoBack = false,
      this.canGoForward = false,
      this.pageTitle});

  /// 現在表示中のURL
  @override
  @JsonKey()
  final String currentUrl;

  /// ページ読み込み中かどうか
  @override
  @JsonKey()
  final bool isLoading;

  /// 戻るボタンが有効かどうか
  @override
  @JsonKey()
  final bool canGoBack;

  /// 進むボタンが有効かどうか
  @override
  @JsonKey()
  final bool canGoForward;

  /// ページタイトル（将来使用）
  @override
  final String? pageTitle;

  @override
  String toString() {
    return 'WebViewState(currentUrl: $currentUrl, isLoading: $isLoading, canGoBack: $canGoBack, canGoForward: $canGoForward, pageTitle: $pageTitle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebViewStateImpl &&
            (identical(other.currentUrl, currentUrl) ||
                other.currentUrl == currentUrl) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.canGoBack, canGoBack) ||
                other.canGoBack == canGoBack) &&
            (identical(other.canGoForward, canGoForward) ||
                other.canGoForward == canGoForward) &&
            (identical(other.pageTitle, pageTitle) ||
                other.pageTitle == pageTitle));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, currentUrl, isLoading, canGoBack, canGoForward, pageTitle);

  /// Create a copy of WebViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebViewStateImplCopyWith<_$WebViewStateImpl> get copyWith =>
      __$$WebViewStateImplCopyWithImpl<_$WebViewStateImpl>(this, _$identity);
}

abstract class _WebViewState implements WebViewState {
  const factory _WebViewState(
      {final String currentUrl,
      final bool isLoading,
      final bool canGoBack,
      final bool canGoForward,
      final String? pageTitle}) = _$WebViewStateImpl;

  /// 現在表示中のURL
  @override
  String get currentUrl;

  /// ページ読み込み中かどうか
  @override
  bool get isLoading;

  /// 戻るボタンが有効かどうか
  @override
  bool get canGoBack;

  /// 進むボタンが有効かどうか
  @override
  bool get canGoForward;

  /// ページタイトル（将来使用）
  @override
  String? get pageTitle;

  /// Create a copy of WebViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebViewStateImplCopyWith<_$WebViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
