// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_text_layout/super_text_layout.dart';

import '../configuration.dart';
import '../providers.dart';

class DisplayCode extends StatefulWidget {
  const DisplayCode({
    super.key,
    required this.assetPath,
    required this.fileType,
    required this.tree,
    required this.baseOffset,
    required this.extentOffset,
    required this.scrollPercentage,
    required this.scrollSeconds,
  });

  final String assetPath;
  final String fileType;
  final List<Node> tree;
  final int baseOffset;
  final int extentOffset;
  final double scrollPercentage;
  final int scrollSeconds;

  @override
  State<DisplayCode> createState() => _DisplayCodeState();
}

class _DisplayCodeState extends State<DisplayCode> {
  late final TreeController<Node> treeController;

  @override
  void initState() {
    super.initState();
    treeController = TreeController<Node>(
      roots: widget.tree,
      childrenProvider: (node) => node.children ?? [],
      defaultExpansionState: true,
    );
  }

  @override
  void didUpdateWidget(covariant DisplayCode oldWidget) {
    super.didUpdateWidget(oldWidget);
    treeController.roots = widget.tree;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 0.1098633 * size.width + 133.0078,
          child: AnimatedTreeView(
            padding: const EdgeInsets.all(12),
            treeController: treeController,
            nodeBuilder:
                (context, entry) => TreeIndentation(
                  guide: IndentGuide.connectingLines(
                    indent: 0.01052632 * size.width + 5.052632,
                    color: Colors.grey,
                    thickness: 2.0,
                    origin: 0.6,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    // roundCorners: true,
                  ),
                  entry: entry,
                  child: Text(
                    entry.node.title,
                    maxLines: 1,
                    style: GoogleFonts.robotoMono(
                      textStyle: TextStyle(
                        fontSize: 0.01972973 * size.height + 2,
                        color: Colors.white.withAlpha(200),
                        fontWeight:
                            entry.node.contents == widget.assetPath
                                ? FontWeight.w500
                                : FontWeight.w300,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
          ),
        ),
        VerticalDivider(thickness: 1, color: Colors.white.withAlpha(75)),
        if (widget.fileType != 'png') ...[
          SizedBox(width: 12),
          Expanded(
            child: DisplayCodeText(
              assetPath: widget.assetPath,
              fileType: widget.fileType,
              baseOffset: widget.baseOffset,
              extentOffset: widget.extentOffset,
              scrollPercentage: widget.scrollPercentage,
              scrollSeconds: widget.scrollSeconds,
            ),
          ),
        ],
        if (widget.fileType == 'png')
          Expanded(child: Center(child: Image.asset(widget.assetPath))),
      ],
    );
  }
}

class DisplayCodeText extends ConsumerStatefulWidget {
  const DisplayCodeText({
    super.key,
    required this.assetPath,
    required this.fileType,
    required this.baseOffset,
    required this.extentOffset,
    required this.scrollPercentage,
    required this.scrollSeconds,
  });

  final String assetPath;
  final String fileType;
  final int baseOffset;
  final int extentOffset;
  final double scrollPercentage;
  final int scrollSeconds;

  @override
  ConsumerState<DisplayCodeText> createState() => _DisplayCodeTextState();
}

class _DisplayCodeTextState extends ConsumerState<DisplayCodeText> {
  @override
  void initState() {
    super.initState();
    content = rootBundle.loadString(widget.assetPath);
  }

  @override
  void didUpdateWidget(covariant DisplayCodeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    content = rootBundle.loadString(widget.assetPath);
  }

  late Future<String> content;

  @override
  Widget build(BuildContext context) {
    final highlightersAsync = ref.watch(highlightersProvider);
    return highlightersAsync.when(
      data:
          (highlighters) => FutureBuilder<String>(
            future: content,
            builder:
                (context, snapshot) => switch ((
                  snapshot.hasData,
                  snapshot.hasError,
                )) {
                  (true, _) => _DisplayCodeTextHelper(
                    assetPath: widget.assetPath,
                    content: snapshot.data ?? '',
                    fileType: widget.fileType,
                    highlighters: highlighters,
                    baseOffset: widget.baseOffset,
                    extentOffset: widget.extentOffset,
                    scrollPercentage: widget.scrollPercentage,
                    scrollSeconds: widget.scrollSeconds,
                  ),
                  (_, true) => Center(child: Text('Error: ${snapshot.error}')),
                  _ => Center(child: CircularProgressIndicator()),
                },
          ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error\n$stack')),
    );
  }
}

class _DisplayCodeTextHelper extends StatefulWidget {
  const _DisplayCodeTextHelper({
    required this.assetPath,
    required this.content,
    required this.fileType,
    required this.highlighters,
    required this.baseOffset,
    required this.extentOffset,
    required this.scrollPercentage,
    required this.scrollSeconds,
  });

  final String assetPath;
  final String content;
  final String fileType;
  final Highlighters highlighters;
  final int baseOffset;
  final int extentOffset;
  final double scrollPercentage;
  final int scrollSeconds;

  @override
  State<_DisplayCodeTextHelper> createState() => _DisplayCodeTextHelperState();
}

class _DisplayCodeTextHelperState extends State<_DisplayCodeTextHelper> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void didUpdateWidget(covariant _DisplayCodeTextHelper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollSeconds > 0) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent *
            widget.scrollPercentage /
            100,
        duration: Duration(seconds: widget.scrollSeconds),
        curve: Curves.easeInOut,
      );
    } else {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent *
            widget.scrollPercentage /
            100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final textSelection = TextSelection(
      baseOffset: widget.baseOffset,
      extentOffset: widget.extentOffset,
      affinity: TextAffinity.upstream,
    );

    return ListView(
      controller: scrollController,
      children: [
        SizedBox(height: 8),
        SuperText(
          richText: TextSpan(
            style: GoogleFonts.robotoMono(
              textStyle: TextStyle(
                fontSize: 0.02567568 * size.height - 1.864865,
                fontWeight: FontWeight.w300,
              ),
            ),
            children: [
              switch (widget.fileType) {
                'dart' => widget.highlighters.dart.highlight(widget.content),
                'yaml' => widget.highlighters.yaml.highlight(widget.content),
                'xml' => widget.highlighters.xml.highlight(widget.content),
                _ => TextSpan(
                  text: widget.content,
                  style: const TextStyle(color: Colors.white),
                ),
              },
            ],
          ),
          layerAboveBuilder: (context, textLayout) {
            return Stack(
              children: [
                TextLayoutCaret(
                  textLayout: textLayout,
                  style: const CaretStyle(color: Colors.white, width: 2),
                  position: TextPosition(offset: textSelection.extentOffset),
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
                    color: Color.fromARGB(255, 60, 91, 183),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  selection: textSelection,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
