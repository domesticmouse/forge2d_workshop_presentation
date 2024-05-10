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
String _$currentStepHash() => r'e5c68dd8b00eb769a166e058329b3650fb1871db';

/// See also [CurrentStep].
@ProviderFor(CurrentStep)
final currentStepProvider =
    AutoDisposeNotifierProvider<CurrentStep, Step>.internal(
  CurrentStep.new,
  name: r'currentStepProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentStepHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentStep = AutoDisposeNotifier<Step>;
String _$currentSubStepHash() => r'd67d6bd201d08c6a8fb0f18d4f886a2c19a0abb3';

/// See also [CurrentSubStep].
@ProviderFor(CurrentSubStep)
final currentSubStepProvider =
    AutoDisposeNotifierProvider<CurrentSubStep, SubStep>.internal(
  CurrentSubStep.new,
  name: r'currentSubStepProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSubStepHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSubStep = AutoDisposeNotifier<SubStep>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
