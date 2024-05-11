import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game/step_03/components/game.dart' as step_03;
import 'game/step_04/components/game.dart' as step_04;
import 'game/step_05/components/game.dart' as step_05;
import 'game/step_06/components/game.dart' as step_06;
import 'game/step_07/components/game.dart' as step_07;
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
    final (currentSection, currentStep, currentSubStep) =
        ref.watch(cursorProvider);

    return _EagerInitialization(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: CallbackShortcuts(
          bindings: <ShortcutActivator, VoidCallback>{
            SingleActivator(LogicalKeyboardKey.arrowRight): () =>
                ref.read(cursorProvider.notifier).next(),
            SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
                ref.read(cursorProvider.notifier).previous(),
          },
          child: Focus(
            autofocus: true,
            skipTraversal: true,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'goo.gle/forge2d-workshop - '
                  'Step ${currentSection.displayStepNumber}: ${currentSection.name}',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 0.02297297 * size.height + 7.594595,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              drawer: NavigationDrawer(),
              body: switch ((
                currentStep.displayCode,
                currentStep.displayMarkdown,
                currentStep.showGame,
              )) {
                (String code, _, _) => DisplayCode(
                    assetPath: code,
                    fileType: currentStep.fileType ?? 'txt',
                    tree: currentStep.tree ?? [],
                    baseOffset: currentSubStep.baseOffset,
                    extentOffset: currentSubStep.extentOffset ??
                        currentSubStep.baseOffset,
                    scrollPercentage: currentSubStep.scrollPercentage ?? 0,
                    scrollSeconds: currentSubStep.scrollSeconds ?? 0,
                  ),
                (_, String markdown, _) => DisplayMarkdown(assetPath: markdown),
                (_, _, 'step_02') => ShowGame(gameFactory: FlameGame.new),
                (_, _, 'step_03') =>
                  ShowGame(gameFactory: step_03.MyPhysicsGame.new),
                (_, _, 'step_04') =>
                  ShowGame(gameFactory: step_04.MyPhysicsGame.new),
                (_, _, 'step_05') =>
                  ShowGame(gameFactory: step_05.MyPhysicsGame.new),
                (_, _, 'step_06') =>
                  ShowGame(gameFactory: step_06.MyPhysicsGame.new),
                (_, _, 'step_07') =>
                  ShowGame(gameFactory: step_07.MyPhysicsGame.new),
                _ => DisplayMarkdown(
                    assetPath: 'assets/empty.txt',
                  )
              },
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer extends ConsumerWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configuration = ref.watch(configurationProvider).asData;
    final (currentSection, currentStep, _) = ref.watch(cursorProvider);

    return Drawer(
      child: ListView(
        children: configuration != null
            ? [
                for (final (sectionNumber, section)
                    in configuration.value.sections.indexed) ...[
                  ListTile(
                    title: Text(
                      section.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: section == currentSection
                          ? Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold)
                          : Theme.of(context).textTheme.titleLarge,
                    ),
                    onTap: () {
                      ref.read(cursorProvider.notifier).setCursorPosition(
                          sectionNumber: sectionNumber, stepNumber: 0);
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                  if (section == currentSection)
                    for (var (stepNumber, step) in section.steps.indexed)
                      ListTile(
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                step.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: step == currentStep
                                    ? Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold)
                                    : Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          ref.read(cursorProvider.notifier).setCursorPosition(
                              sectionNumber: sectionNumber,
                              stepNumber: stepNumber);
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                ],
              ]
            : [],
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
