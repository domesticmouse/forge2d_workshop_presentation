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
    final configuration = ref.watch(configurationProvider).asData;
    final currentStep = ref.watch(currentStepProvider);
    final currentSubStep = ref.watch(currentSubStepProvider);

    return _EagerInitialization(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CallbackShortcuts(
          bindings: <ShortcutActivator, VoidCallback>{
            SingleActivator(LogicalKeyboardKey.arrowRight): () =>
                ref.read(currentStepProvider.notifier).next(),
            SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
                ref.read(currentStepProvider.notifier).previous(),
          },
          child: Focus(
            autofocus: true,
            skipTraversal: true,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'goo.gle/forge2d-workshop - '
                  'Step ${currentStep.displayStepNumber}: ${currentStep.name}',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 0.02297297 * size.height + 7.594595,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              drawer: Drawer(
                  child: ListView(
                      children: configuration != null
                          ? [
                              for (final (stepNumber, step)
                                  in configuration.value.steps.indexed) ...[
                                ListTile(
                                  title: Flexible(
                                    child: Text(
                                      step.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: step == currentStep
                                          ? Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold)
                                          : Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                    ),
                                  ),
                                ),
                                for (var (subStepNumber, subStep)
                                    in step.steps.indexed)
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
                                            style: subStep == currentSubStep
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)
                                                : Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      ref
                                          .read(currentStepProvider.notifier)
                                          .stepNumber = stepNumber;
                                      ref
                                          .read(currentSubStepProvider.notifier)
                                          .subStepNumber = subStepNumber;
                                    },
                                  ),
                              ],
                            ]
                          : [])),
              body: switch ((
                currentSubStep.displayCode,
                currentSubStep.displayMarkdown,
                currentSubStep.showGame,
              )) {
                (String code, _, _) => DisplayCode(
                    assetPath: code,
                    fileType: currentSubStep.fileType ?? 'txt',
                    tree: currentStep.tree),
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
                    assetPath: 'assets/screen-test.txt',
                  )
              },
            ),
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
