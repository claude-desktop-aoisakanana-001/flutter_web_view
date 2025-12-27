// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_novel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedNovelImpl _$$ParsedNovelImplFromJson(Map<String, dynamic> json) =>
    _$ParsedNovelImpl(
      title: json['title'] as String,
      author: json['author'] as String,
      paragraphs: (json['paragraphs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      metadata: (json['metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$ParsedNovelImplToJson(_$ParsedNovelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'paragraphs': instance.paragraphs,
      'metadata': instance.metadata,
    };
