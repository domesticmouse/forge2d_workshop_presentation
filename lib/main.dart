import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'slides/slides.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _EagerInitialization(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: DisplayMarkdown(
            assetPath: 'assets/markdown/01_create_project.md',
          ),
        ),
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Force the eager loading and parsing of the assets/steps.yaml file
    ref.watch(configurationProvider);
    return child;
  }
}
