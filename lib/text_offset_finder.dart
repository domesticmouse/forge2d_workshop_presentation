// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart' hide Step;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge2d_workshop_presentation/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_text_layout/super_text_layout.dart';

import 'configuration.dart';

void main() {
  runApp(const ProviderScope(child: TextOffsetFinderApp()));
}

class TextOffsetFinderApp extends StatelessWidget {
  const TextOffsetFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text Offset Finder'),
          actions: const [TextOffsetFinderAppMenu()],
        ),
        body: TextOffsetFinderBody(),
      ),
    );
  }
}

class TextOffsetFinderAppMenu extends ConsumerWidget {
  const TextOffsetFinderAppMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configuration = ref.watch(configurationProvider).asData?.value;
    final (currentSection, currentStep, _) = ref.watch(cursorProvider);

    if (configuration == null) {
      return MenuAnchor(
        menuChildren: const [],
        builder:
            (context, controller, child) => IconButton(
              onPressed: () => controller.open(),
              icon: Icon(Icons.file_open),
            ),
      );
    }

    return MenuAnchor(
      menuChildren: [
        for (final section in configuration.sections) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: Text(
              section.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  section == currentSection
                      ? Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      )
                      : Theme.of(context).textTheme.titleLarge,
            ),
          ),
          for (final step in section.steps.where(
            (step) => step.displayCode != null && step.fileType != 'png',
          )) ...[
            MenuItemButton(
              onPressed:
                  () => ref
                      .read(cursorProvider.notifier)
                      .setCursorPosition(
                        sectionNumber: configuration.sections.indexOf(section),
                        stepNumber: section.steps.indexOf(step),
                      ),
              child: Text(
                step.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    step == currentStep
                        ? Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        )
                        : Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ],
      ],
      builder:
          (context, controller, child) => IconButton(
            onPressed: () => controller.open(),
            icon: Icon(Icons.file_open),
          ),
    );
  }
}

class TextOffsetFinderBody extends ConsumerStatefulWidget {
  const TextOffsetFinderBody({super.key});

  @override
  ConsumerState<TextOffsetFinderBody> createState() =>
      _TextOffsetFinderBodyState();
}

class _TextOffsetFinderBodyState extends ConsumerState<TextOffsetFinderBody> {
  @override
  Widget build(BuildContext context) {
    final configuration = ref.watch(configurationProvider).asData?.value;
    final (currentSection, currentStep, _) = ref.watch(cursorProvider);

    if (configuration == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox.expand(
      child: OffsetFinderTextView(section: currentSection, step: currentStep),
    );
  }
}

class OffsetFinderTextView extends StatefulWidget {
  const OffsetFinderTextView({
    super.key,
    required this.section,
    required this.step,
  });

  final Section section;
  final Step step;

  @override
  State<OffsetFinderTextView> createState() => _OffsetFinderTextViewState();
}

class _OffsetFinderTextViewState extends State<OffsetFinderTextView> {
  @override
  void initState() {
    super.initState();
    var displayCode = widget.step.displayCode;
    if (displayCode != null) {
      content = rootBundle.loadString(displayCode);
    } else {
      content = Future.value('Not a code step.');
    }
  }

  @override
  void didUpdateWidget(covariant OffsetFinderTextView oldWidget) {
    super.didUpdateWidget(oldWidget);
    var displayCode = widget.step.displayCode;
    if (displayCode != null) {
      content = rootBundle.loadString(displayCode);
    } else {
      content = Future.value('Not a code step.');
    }
  }

  late Future<String> content;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: content,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return OffsetFinderTextViewHelper(
          content: snapshot.data ?? '',
          assetPath: widget.step.displayCode ?? '',
        );
      },
    );
  }
}

class OffsetFinderTextViewHelper extends StatefulWidget {
  const OffsetFinderTextViewHelper({
    super.key,
    required this.content,
    required this.assetPath,
  });

  final String assetPath;
  final String content;

  @override
  State<OffsetFinderTextViewHelper> createState() =>
      _OffsetFinderTextViewHelperState();
}

class _OffsetFinderTextViewHelperState
    extends State<OffsetFinderTextViewHelper> {
  var _cursor = Cursor(content: '');
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cursor = Cursor(content: widget.content);
  }

  @override
  void didUpdateWidget(covariant OffsetFinderTextViewHelper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _cursor = Cursor(content: widget.content);
  }

  @override
  Widget build(BuildContext context) {
    var scrollPercentage = _cursor.scrollPercentage * 100;
    if (scrollPercentage.isNaN) {
      scrollPercentage = 0;
    } else {
      scrollPercentage = scrollPercentage.roundToDouble();
    }

    return CallbackShortcuts(
      bindings: {
        SingleActivator(LogicalKeyboardKey.arrowLeft):
            () => setState(() {
              _cursor.left();
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent *
                    _cursor.scrollPercentage,
              );
            }),
        SingleActivator(LogicalKeyboardKey.arrowRight):
            () => setState(() {
              _cursor.right();
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent *
                    _cursor.scrollPercentage,
              );
            }),
        SingleActivator(LogicalKeyboardKey.arrowUp):
            () => setState(() {
              _cursor.up();
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent *
                    _cursor.scrollPercentage,
              );
            }),
        SingleActivator(LogicalKeyboardKey.arrowDown):
            () => setState(() {
              _cursor.down();
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent *
                    _cursor.scrollPercentage,
              );
            }),
        SingleActivator(LogicalKeyboardKey.arrowLeft, shift: true):
            () => setState(() {
              _cursor.shiftLeft();
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent *
                    _cursor.scrollPercentage,
              );
            }),
        SingleActivator(LogicalKeyboardKey.arrowRight, shift: true):
            () => setState(() {
              _cursor.shiftRight();
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent *
                    _cursor.scrollPercentage,
              );
            }),
        SingleActivator(LogicalKeyboardKey.arrowUp, shift: true):
            () => setState(() {
              _cursor.shiftUp();
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent *
                    _cursor.scrollPercentage,
              );
            }),
        SingleActivator(LogicalKeyboardKey.arrowDown, shift: true):
            () => setState(() {
              _cursor.shiftDown();
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent *
                    _cursor.scrollPercentage,
              );
            }),
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Focus(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SuperText(
                    richText: TextSpan(
                      style: GoogleFonts.robotoMono(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      children: [
                        TextSpan(
                          text: widget.content,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    layerAboveBuilder: (context, textLayout) {
                      return Stack(
                        children: [
                          TextLayoutCaret(
                            textLayout: textLayout,
                            style: const CaretStyle(
                              color: Colors.black,
                              width: 2,
                            ),
                            position: TextPosition(
                              offset: _cursor.textSelection.extentOffset,
                            ),
                          ),
                        ],
                      );
                    },
                    layerBeneathBuilder: (context, textLayout) {
                      return Stack(
                        children: [
                          TextLayoutSelectionHighlight(
                            textLayout: textLayout,
                            style: SelectionHighlightStyle(
                              color: Colors.blue.withAlpha(75),
                            ),
                            selection: _cursor.textSelection,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: SelectableText(
              'Asset Path: ${widget.assetPath} '
              'Cursor: ${_cursor.extentLine}:${_cursor.extentColumn} '
              'base-offset: ${_cursor.basePosition.offset} '
              'extent-offset: ${_cursor.extentPosition.offset} '
              'scroll-percentage: $scrollPercentage',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class CursorPosition {
  final String glyph;
  final int offset;
  final int line;
  final int column;

  CursorPosition({
    required this.glyph,
    required this.offset,
    required this.line,
    required this.column,
  });
}

class Cursor {
  int baseLine = 0;
  int baseColumn = 0;
  int extentLine = 0;
  int extentColumn = 0;

  TextSelection get textSelection => TextSelection(
    baseOffset: basePosition.offset,
    extentOffset: extentPosition.offset,
    affinity: TextAffinity.upstream,
  );

  late final List<CursorPosition> _positions;

  Cursor({required String content}) {
    int line = 0;
    int column = 0;
    final positions = <CursorPosition>[];

    for (final (index, glyph) in content.characters.indexed) {
      positions.add(
        CursorPosition(glyph: glyph, offset: index, line: line, column: column),
      );

      if (glyph == '\n') {
        line++;
        column = 0;
      } else {
        column++;
      }
    }
    _positions = positions;
  }

  double get scrollPercentage => extentLine / _positions.last.line;

  CursorPosition get basePosition {
    final position = _positions.where(
      (position) => position.line == baseLine && position.column == baseColumn,
    );
    if (position.isNotEmpty) {
      return position.first;
    }

    final row = _positions.where((position) => position.line == baseLine);
    if (row.isNotEmpty) {
      return row.last;
    }

    return _positions.last;
  }

  CursorPosition get extentPosition {
    final position = _positions.where(
      (position) =>
          position.line == extentLine && position.column == extentColumn,
    );
    if (position.isNotEmpty) {
      return position.first;
    }

    final row = _positions.where((position) => position.line == extentLine);
    if (row.isNotEmpty) {
      return row.last;
    }

    return _positions.last;
  }

  void left() {
    final currentPosition = extentPosition;
    if (currentPosition == _positions.first) {
      return;
    }

    final previousPosition = _positions[currentPosition.offset - 1];
    extentLine = previousPosition.line;
    extentColumn = previousPosition.column;
    baseLine = extentLine;
    baseColumn = extentColumn;
  }

  void right() {
    final currentPosition = extentPosition;
    if (currentPosition == _positions.last) {
      return;
    }

    final nextPosition = _positions[currentPosition.offset + 1];
    extentLine = nextPosition.line;
    extentColumn = nextPosition.column;
    baseLine = extentLine;
    baseColumn = extentColumn;
  }

  void up() {
    final currentPosition = extentPosition;
    if (currentPosition.line == 0) {
      extentColumn = 0;
      baseLine = extentLine;
      baseColumn = extentColumn;
      return;
    }

    extentLine = currentPosition.line - 1;
    baseLine = extentLine;
    baseColumn = extentColumn;
  }

  void down() {
    final currentPosition = extentPosition;
    if (currentPosition.line == _positions.last.line) {
      extentColumn = _positions.last.column;
      baseLine = extentLine;
      baseColumn = extentColumn;
      return;
    }

    extentLine = currentPosition.line + 1;
    baseLine = extentLine;
    baseColumn = extentColumn;
  }

  void shiftLeft() {
    final currentPosition = extentPosition;
    if (currentPosition == _positions.first) {
      return;
    }

    final previousPosition = _positions[currentPosition.offset - 1];
    extentLine = previousPosition.line;
    extentColumn = previousPosition.column;
  }

  void shiftRight() {
    final currentPosition = extentPosition;
    if (currentPosition == _positions.last) {
      return;
    }

    final nextPosition = _positions[currentPosition.offset + 1];
    extentLine = nextPosition.line;
    extentColumn = nextPosition.column;
  }

  void shiftUp() {
    final currentPosition = extentPosition;
    if (currentPosition.line == 0) {
      extentColumn = 0;
      return;
    }

    extentLine = currentPosition.line - 1;
  }

  void shiftDown() {
    final currentPosition = extentPosition;
    if (currentPosition.line == _positions.last.line) {
      extentColumn = _positions.last.column;
      return;
    }

    extentLine = currentPosition.line + 1;
  }
}
