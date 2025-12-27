// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TTSState {
  /// TTS が初期化済みかどうか
  bool get isInitialized => throw _privateConstructorUsedError;

  /// TTS の設定
  TTSConfig? get config => throw _privateConstructorUsedError;

  /// エラーメッセージ（エラーがない場合は null）
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of TTSState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TTSStateCopyWith<TTSState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TTSStateCopyWith<$Res> {
  factory $TTSStateCopyWith(TTSState value, $Res Function(TTSState) then) =
      _$TTSStateCopyWithImpl<$Res, TTSState>;
  @useResult
  $Res call({bool isInitialized, TTSConfig? config, String? errorMessage});

  $TTSConfigCopyWith<$Res>? get config;
}

/// @nodoc
class _$TTSStateCopyWithImpl<$Res, $Val extends TTSState>
    implements $TTSStateCopyWith<$Res> {
  _$TTSStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TTSState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitialized = null,
    Object? config = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      config: freezed == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as TTSConfig?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of TTSState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TTSConfigCopyWith<$Res>? get config {
    if (_value.config == null) {
      return null;
    }

    return $TTSConfigCopyWith<$Res>(_value.config!, (value) {
      return _then(_value.copyWith(config: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TTSStateImplCopyWith<$Res>
    implements $TTSStateCopyWith<$Res> {
  factory _$$TTSStateImplCopyWith(
          _$TTSStateImpl value, $Res Function(_$TTSStateImpl) then) =
      __$$TTSStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isInitialized, TTSConfig? config, String? errorMessage});

  @override
  $TTSConfigCopyWith<$Res>? get config;
}

/// @nodoc
class __$$TTSStateImplCopyWithImpl<$Res>
    extends _$TTSStateCopyWithImpl<$Res, _$TTSStateImpl>
    implements _$$TTSStateImplCopyWith<$Res> {
  __$$TTSStateImplCopyWithImpl(
      _$TTSStateImpl _value, $Res Function(_$TTSStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TTSState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitialized = null,
    Object? config = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$TTSStateImpl(
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      config: freezed == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as TTSConfig?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TTSStateImpl implements _TTSState {
  const _$TTSStateImpl(
      {this.isInitialized = false, this.config, this.errorMessage});

  /// TTS が初期化済みかどうか
  @override
  @JsonKey()
  final bool isInitialized;

  /// TTS の設定
  @override
  final TTSConfig? config;

  /// エラーメッセージ（エラーがない場合は null）
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'TTSState(isInitialized: $isInitialized, config: $config, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TTSStateImpl &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.config, config) || other.config == config) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isInitialized, config, errorMessage);

  /// Create a copy of TTSState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TTSStateImplCopyWith<_$TTSStateImpl> get copyWith =>
      __$$TTSStateImplCopyWithImpl<_$TTSStateImpl>(this, _$identity);
}

abstract class _TTSState implements TTSState {
  const factory _TTSState(
      {final bool isInitialized,
      final TTSConfig? config,
      final String? errorMessage}) = _$TTSStateImpl;

  /// TTS が初期化済みかどうか
  @override
  bool get isInitialized;

  /// TTS の設定
  @override
  TTSConfig? get config;

  /// エラーメッセージ（エラーがない場合は null）
  @override
  String? get errorMessage;

  /// Create a copy of TTSState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TTSStateImplCopyWith<_$TTSStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
