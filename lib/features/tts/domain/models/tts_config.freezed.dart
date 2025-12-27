// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tts_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TTSConfig _$TTSConfigFromJson(Map<String, dynamic> json) {
  return _TTSConfig.fromJson(json);
}

/// @nodoc
mixin _$TTSConfig {
  /// 読み上げ速度（0.5 〜 2.0）
  /// - 1.0: 通常速度
  /// - 0.5: 半分の速度（ゆっくり）
  /// - 2.0: 倍速
  double get speed => throw _privateConstructorUsedError;

  /// 音程（0.5 〜 2.0）
  /// ※ 将来対応
  double get pitch => throw _privateConstructorUsedError;

  /// 音量（0.0 〜 1.0）
  /// ※ 将来対応
  double get volume => throw _privateConstructorUsedError;

  /// 行間の間隔（秒）
  /// ※ 将来対応
  double get linePause => throw _privateConstructorUsedError;

  /// 段落間の間隔（秒）
  /// ※ 将来対応
  double get paragraphPause => throw _privateConstructorUsedError;

  /// Serializes this TTSConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TTSConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TTSConfigCopyWith<TTSConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TTSConfigCopyWith<$Res> {
  factory $TTSConfigCopyWith(TTSConfig value, $Res Function(TTSConfig) then) =
      _$TTSConfigCopyWithImpl<$Res, TTSConfig>;
  @useResult
  $Res call(
      {double speed,
      double pitch,
      double volume,
      double linePause,
      double paragraphPause});
}

/// @nodoc
class _$TTSConfigCopyWithImpl<$Res, $Val extends TTSConfig>
    implements $TTSConfigCopyWith<$Res> {
  _$TTSConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TTSConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? pitch = null,
    Object? volume = null,
    Object? linePause = null,
    Object? paragraphPause = null,
  }) {
    return _then(_value.copyWith(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      pitch: null == pitch
          ? _value.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as double,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      linePause: null == linePause
          ? _value.linePause
          : linePause // ignore: cast_nullable_to_non_nullable
              as double,
      paragraphPause: null == paragraphPause
          ? _value.paragraphPause
          : paragraphPause // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TTSConfigImplCopyWith<$Res>
    implements $TTSConfigCopyWith<$Res> {
  factory _$$TTSConfigImplCopyWith(
          _$TTSConfigImpl value, $Res Function(_$TTSConfigImpl) then) =
      __$$TTSConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double speed,
      double pitch,
      double volume,
      double linePause,
      double paragraphPause});
}

/// @nodoc
class __$$TTSConfigImplCopyWithImpl<$Res>
    extends _$TTSConfigCopyWithImpl<$Res, _$TTSConfigImpl>
    implements _$$TTSConfigImplCopyWith<$Res> {
  __$$TTSConfigImplCopyWithImpl(
      _$TTSConfigImpl _value, $Res Function(_$TTSConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of TTSConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? pitch = null,
    Object? volume = null,
    Object? linePause = null,
    Object? paragraphPause = null,
  }) {
    return _then(_$TTSConfigImpl(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      pitch: null == pitch
          ? _value.pitch
          : pitch // ignore: cast_nullable_to_non_nullable
              as double,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      linePause: null == linePause
          ? _value.linePause
          : linePause // ignore: cast_nullable_to_non_nullable
              as double,
      paragraphPause: null == paragraphPause
          ? _value.paragraphPause
          : paragraphPause // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TTSConfigImpl implements _TTSConfig {
  const _$TTSConfigImpl(
      {this.speed = 1.0,
      this.pitch = 1.0,
      this.volume = 1.0,
      this.linePause = 0.0,
      this.paragraphPause = 0.0});

  factory _$TTSConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$TTSConfigImplFromJson(json);

  /// 読み上げ速度（0.5 〜 2.0）
  /// - 1.0: 通常速度
  /// - 0.5: 半分の速度（ゆっくり）
  /// - 2.0: 倍速
  @override
  @JsonKey()
  final double speed;

  /// 音程（0.5 〜 2.0）
  /// ※ 将来対応
  @override
  @JsonKey()
  final double pitch;

  /// 音量（0.0 〜 1.0）
  /// ※ 将来対応
  @override
  @JsonKey()
  final double volume;

  /// 行間の間隔（秒）
  /// ※ 将来対応
  @override
  @JsonKey()
  final double linePause;

  /// 段落間の間隔（秒）
  /// ※ 将来対応
  @override
  @JsonKey()
  final double paragraphPause;

  @override
  String toString() {
    return 'TTSConfig(speed: $speed, pitch: $pitch, volume: $volume, linePause: $linePause, paragraphPause: $paragraphPause)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TTSConfigImpl &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.pitch, pitch) || other.pitch == pitch) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.linePause, linePause) ||
                other.linePause == linePause) &&
            (identical(other.paragraphPause, paragraphPause) ||
                other.paragraphPause == paragraphPause));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, speed, pitch, volume, linePause, paragraphPause);

  /// Create a copy of TTSConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TTSConfigImplCopyWith<_$TTSConfigImpl> get copyWith =>
      __$$TTSConfigImplCopyWithImpl<_$TTSConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TTSConfigImplToJson(
      this,
    );
  }
}

abstract class _TTSConfig implements TTSConfig {
  const factory _TTSConfig(
      {final double speed,
      final double pitch,
      final double volume,
      final double linePause,
      final double paragraphPause}) = _$TTSConfigImpl;

  factory _TTSConfig.fromJson(Map<String, dynamic> json) =
      _$TTSConfigImpl.fromJson;

  /// 読み上げ速度（0.5 〜 2.0）
  /// - 1.0: 通常速度
  /// - 0.5: 半分の速度（ゆっくり）
  /// - 2.0: 倍速
  @override
  double get speed;

  /// 音程（0.5 〜 2.0）
  /// ※ 将来対応
  @override
  double get pitch;

  /// 音量（0.0 〜 1.0）
  /// ※ 将来対応
  @override
  double get volume;

  /// 行間の間隔（秒）
  /// ※ 将来対応
  @override
  double get linePause;

  /// 段落間の間隔（秒）
  /// ※ 将来対応
  @override
  double get paragraphPause;

  /// Create a copy of TTSConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TTSConfigImplCopyWith<_$TTSConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
