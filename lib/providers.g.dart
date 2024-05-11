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
String _$currentSectionHash() => r'59de2f1b45012f3eddce41a3f50cc955b2aaae9b';

/// See also [CurrentSection].
@ProviderFor(CurrentSection)
final currentSectionProvider =
    AutoDisposeNotifierProvider<CurrentSection, Section>.internal(
  CurrentSection.new,
  name: r'currentSectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSection = AutoDisposeNotifier<Section>;
String _$currentStepHash() => r'ee10b3c0279069a03a91548b1eb5f3a45c32c352';

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
String _$currentSubStepHash() => r'372872fa170ce16c8277427c13cc0e8487e1a364';

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
