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
    final size = MediaQuery.sizeOf(context);

    return _EagerInitialization(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'goo.gle/forge2d-workshop',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: switch (size.height) {
                      > 1400 => 40,
                      > 1000 => 30,
                      _ => 24,
                    },
                    fontWeight: FontWeight.w300),
              ),
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
