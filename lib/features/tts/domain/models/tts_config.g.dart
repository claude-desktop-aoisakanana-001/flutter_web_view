// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TTSConfigImpl _$$TTSConfigImplFromJson(Map<String, dynamic> json) =>
    _$TTSConfigImpl(
      speed: (json['speed'] as num?)?.toDouble() ?? 1.0,
      pitch: (json['pitch'] as num?)?.toDouble() ?? 1.0,
      volume: (json['volume'] as num?)?.toDouble() ?? 1.0,
      linePause: (json['linePause'] as num?)?.toDouble() ?? 0.0,
      paragraphPause: (json['paragraphPause'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$TTSConfigImplToJson(_$TTSConfigImpl instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'pitch': instance.pitch,
      'volume': instance.volume,
      'linePause': instance.linePause,
      'paragraphPause': instance.paragraphPause,
    };
