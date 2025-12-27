// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narou_parser_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$narouParserServiceHash() =>
    r'44f396df8226085e2652aef90d360038ee6b93b5';

/// 小説家になろうのHTML解析サービス
///
/// WebView + JavaScript Injection を使用して、
/// 利用規約を遵守しながら小説データを取得します。
///
/// Copied from [NarouParserService].
@ProviderFor(NarouParserService)
final narouParserServiceProvider =
    AutoDisposeNotifierProvider<NarouParserService, void>.internal(
  NarouParserService.new,
  name: r'narouParserServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$narouParserServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NarouParserService = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
