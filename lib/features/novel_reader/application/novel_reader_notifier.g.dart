// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_reader_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$novelReaderNotifierHash() =>
    r'0715556c93edfe6727c1cf9db12c9f42c0a40766';

/// 小説リーダーの状態を管理する Notifier
///
/// URL から小説を読み込み、表示用のデータを管理します。
///
/// Copied from [NovelReaderNotifier].
@ProviderFor(NovelReaderNotifier)
final novelReaderNotifierProvider =
    AutoDisposeNotifierProvider<NovelReaderNotifier, NovelReaderState>.internal(
  NovelReaderNotifier.new,
  name: r'novelReaderNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$novelReaderNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NovelReaderNotifier = AutoDisposeNotifier<NovelReaderState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
