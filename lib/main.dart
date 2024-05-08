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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _EagerInitialization(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'goo.gle/forge2d-workshop',
              style: GoogleFonts.roboto(
                textStyle:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          body: DisplayCode(
            assetPath: 'assets/step_07/lib/components/enemy.dart',
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
