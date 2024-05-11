// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$configurationHash() => r'47c526cdcc9b3803aaa6399130a784fb7aeeb04b';

/// See also [configuration].
@ProviderFor(configuration)
final configurationProvider = AutoDisposeFutureProvider<Configuration>.internal(
  configuration,
  name: r'configurationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$configurationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConfigurationRef = AutoDisposeFutureProviderRef<Configuration>;
String _$highlightersHash() => r'01f202edc49d254b69d7a8176dfd193879465525';

/// See also [highlighters].
@ProviderFor(highlighters)
final highlightersProvider = AutoDisposeFutureProvider<Highlighters>.internal(
  highlighters,
  name: r'highlightersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$highlightersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HighlightersRef = AutoDisposeFutureProviderRef<Highlighters>;
String _$cursorHash() => r'dc3b971e67ea35927d8fbaed42ad30046c19cfb9';

/// See also [Cursor].
@ProviderFor(Cursor)
final cursorProvider =
    AutoDisposeNotifierProvider<Cursor, (Section, Step, SubStep)>.internal(
  Cursor.new,
  name: r'cursorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cursorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Cursor = AutoDisposeNotifier<(Section, Step, SubStep)>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
