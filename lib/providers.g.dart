// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(configuration)
const configurationProvider = ConfigurationProvider._();

final class ConfigurationProvider
    extends
        $FunctionalProvider<
          AsyncValue<Configuration>,
          Configuration,
          FutureOr<Configuration>
        >
    with $FutureModifier<Configuration>, $FutureProvider<Configuration> {
  const ConfigurationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'configurationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$configurationHash();

  @$internal
  @override
  $FutureProviderElement<Configuration> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Configuration> create(Ref ref) {
    return configuration(ref);
  }
}

String _$configurationHash() => r'b569038866dd3fdeb3d0c6a33b87bd30d832e699';

@ProviderFor(Cursor)
const cursorProvider = CursorProvider._();

final class CursorProvider
    extends $NotifierProvider<Cursor, (Section, Step, SubStep)> {
  const CursorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cursorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cursorHash();

  @$internal
  @override
  Cursor create() => Cursor();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue((Section, Step, SubStep) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<(Section, Step, SubStep)>(value),
    );
  }
}

String _$cursorHash() => r'9763a27c8368c949b58f6398bd639c5be4e63884';

abstract class _$Cursor extends $Notifier<(Section, Step, SubStep)> {
  (Section, Step, SubStep) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<(Section, Step, SubStep), (Section, Step, SubStep)>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<(Section, Step, SubStep), (Section, Step, SubStep)>,
              (Section, Step, SubStep),
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(highlighters)
const highlightersProvider = HighlightersProvider._();

final class HighlightersProvider
    extends
        $FunctionalProvider<
          AsyncValue<Highlighters>,
          Highlighters,
          FutureOr<Highlighters>
        >
    with $FutureModifier<Highlighters>, $FutureProvider<Highlighters> {
  const HighlightersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'highlightersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$highlightersHash();

  @$internal
  @override
  $FutureProviderElement<Highlighters> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Highlighters> create(Ref ref) {
    return highlighters(ref);
  }
}

String _$highlightersHash() => r'2a2b82c9d44dfe2a7408cb2229e574cd9acfc4a6';
