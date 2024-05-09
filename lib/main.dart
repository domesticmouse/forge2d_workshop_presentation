import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'configuration.dart';
import 'providers.dart';
import 'slides/slides.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final configuration = ref.watch(configurationProvider).asData;
    final List<Widget> drawerSteps = [];
    if (configuration != null) {
      for (var step in configuration.value.steps) {
        drawerSteps.add(
          ListTile(
            title: Flexible(
              child: Text(
                step.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        );
        for (var subStep in step.steps) {
          drawerSteps.add(
            ListTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 16),
                  Flexible(
                    child: Text(
                      subStep.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
    }

    return _EagerInitialization(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'goo.gle/forge2d-workshop',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 0.02297297 * size.height + 7.594595,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              children: drawerSteps,
            ),
          ),
          body: DisplayCode(
            assetPath: 'assets/screen-test.txt',
            fileType: 'dart',
            tree: [
              Node(
                directory: 'lib',
                children: [
                  Node(
                    directory: 'components',
                    children: [
                      Node(
                        file: 'game.dart',
                        fileType: 'dart',
                      ),
                      Node(
                        file: 'body_component_with_user_data.dart',
                        fileType: 'dart',
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
