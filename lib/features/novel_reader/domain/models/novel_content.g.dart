// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NovelContentImpl _$$NovelContentImplFromJson(Map<String, dynamic> json) =>
    _$NovelContentImpl(
      title: json['title'] as String,
      author: json['author'] as String,
      url: json['url'] as String,
      paragraphs: (json['paragraphs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      fetchedAt: json['fetchedAt'] == null
          ? null
          : DateTime.parse(json['fetchedAt'] as String),
    );

Map<String, dynamic> _$$NovelContentImplToJson(_$NovelContentImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'url': instance.url,
      'paragraphs': instance.paragraphs,
      'fetchedAt': instance.fetchedAt?.toIso8601String(),
    };
