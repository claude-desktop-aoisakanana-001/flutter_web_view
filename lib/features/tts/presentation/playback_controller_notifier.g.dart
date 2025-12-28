// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_controller_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playbackControllerNotifierHash() =>
    r'3ea8edfe1c199f47dfded14d010f1c0da6240834';

/// 再生コントローラーの状態を管理する Notifier
///
/// TtsService と連携して再生/一時停止/停止を制御します。
/// Issue #10: 小説コンテンツとの統合
///
/// Copied from [PlaybackControllerNotifier].
@ProviderFor(PlaybackControllerNotifier)
final playbackControllerNotifierProvider = AutoDisposeNotifierProvider<
    PlaybackControllerNotifier, PlaybackState>.internal(
  PlaybackControllerNotifier.new,
  name: r'playbackControllerNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playbackControllerNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PlaybackControllerNotifier = AutoDisposeNotifier<PlaybackState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
